=head1 LICENSE

  Copyright 2016 University of Chicago

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

=head1 CONTACT

  Kyle Hernandez <khernandez@bsd.uchicago.edu>

=head1 NAME

 GDC_validation

=head1 SYNOPSIS

 perl variant_effect_predictor.pl -i variations.vcf --plugin GDC_evidence,<variation.vcf.gz>

=head1 DESCRIPTION

 A VEP plugin that adds in the ENSEMBL evidence annotations for dbSNPs. The variation VCF
 from ENSEMBL is required and should be tabix indexed. TABIX needs to be in your path. 

=cut

package GDC_evidence;

use strict;
use warnings;

use Bio::EnsEMBL::Variation::Utils::VEP qw(parse_line);
use Bio::EnsEMBL::Variation::Utils::BaseVepPlugin;

use base qw(Bio::EnsEMBL::Variation::Utils::BaseVepPlugin);

sub new {
    my $class = shift;

    my $self = $class->SUPER::new(@_);

    # Test tabix
    die "ERROR: tabix does not seem to be in your path\n" unless `which tabix 2>&1` =~ /tabix$/;

    # get files
    my $var_vcf = $self->params->[0];
 
    # check files exist
    die "ERROR: Tabix index file $var_vcf\.tbi not found - perhaps you need to create it first?\n" 
        unless -e $var_vcf.'.tbi'; 

    # Set
    $self->{var_vcf}   = $var_vcf;
    return $self;
}

sub feature_types {
  return ['Feature', 'Intergenic'];
}

sub get_header_info {
  my $self = shift;
  return {
    EVIDENCE => 'Evidence_Status'
  } 
}

sub run {
    my ($self, $tva, $other) = @_;

    # Data hash
    my %data;

    # Variation feature
    my $vf = $tva->variation_feature;

    # Existing variation 
    my $existing = $other->{Existing_variation};

    # If there is an rsID continue
    if ( $existing =~ /rs/ ) {

      # Get start and stop positions appropriately offset
      my ($s, $e) = ($vf->{start} - 1, $vf->{end} + 1);

      # Make pos string for tabix
      my $pos_string = sprintf("%s:%i-%i", $vf->{chr}, $s, $e);

      # Pull out the dbSNP id from the existing variation
      my @dbsnpids = grep { $_ =~ /^rs/ } split ",", $existing;

      # Only handle where there is a single rsid
      if( scalar(@dbsnpids) == 1 ) {
          # Pull out dbSNP id
          my $dbsnpid = pop(@dbsnpids);

          # Parse validation
          my $validation  = $self->getValidation($dbsnpid, $pos_string, $vf); 

          # If you found validation info set
          if( $validation ) {
              $data{EVIDENCE} = $validation; 
          }
      } 
      elsif( scalar(@dbsnpids) > 1 ) {
          warn "Multiple dbsnpids not handled!! $pos_string\n";
      }
    }

    # Return data 
    return \%data; 
}

sub getValidation {
    my ($self, $dbsnpid, $pos_string, $vf) = @_;

    my $validation;

    open TABIX, sprintf("tabix -f %s %s |", $self->{var_vcf}, $pos_string);

    while(<TABIX>) {
        chomp;
        s/\r$//g;        

        # parse VCF line into a VariationFeature object
        my ($vcf_vf) = @{parse_line({format => 'vcf'}, $_)};

        # check parsed OK
        next unless $vcf_vf && $vcf_vf->isa('Bio::EnsEMBL::Variation::VariationFeature');

        # compare coords
        next unless $vcf_vf->{start} == $vf->{start} && $vcf_vf->{end} == $vf->{end};

        # compare ids
        next unless $vcf_vf->name eq $dbsnpid;

        # Parse info 
        my @cols    = split /\t/, $_;

        # Parse out the flags from the INFO col for evidence 
        my @vals    = grep{ $_ =~ m/^E_/g } split(/;/, $cols[7]);
        $validation = join(",", @vals);
        last; 
    }
    close TABIX;
    return $validation; 
}

1;
