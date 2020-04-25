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

 GDC_entrez

=head1 SYNOPSIS

 perl variant_effect_predictor.pl -i variations.vcf --plugin GDC_entrez,<entrez_ensembl.json>

=head1 DESCRIPTION

 A VEP plugin that adds in the Entrez IDs based on the Ensembl transcript ID. The accessory script
 can create the input JSON object.

=cut

package GDC_entrez;

use strict;
use warnings;

use JSON;
use Bio::EnsEMBL::Variation::Utils::BaseVepPlugin;

use base qw(Bio::EnsEMBL::Variation::Utils::BaseVepPlugin);

sub new {
    my $class = shift;

    my $self = $class->SUPER::new(@_);

    # get file
    my $json_file = $self->params->[0];
 
    # check file exist
    die "ERROR: entrez json $json_file not found\n" unless -e $json_file; 

    # Load json
    open FILE, $json_file or die "Couldn't open JSON file: $!";
    my $json_text = <FILE>;
    close FILE;
    my $json_db = decode_json $json_text; 

    # Set
    $self->{json_file} = $json_file;
    $self->{json_db}   = $json_db;
    return $self;
}

sub feature_types {
  return ['Feature', 'Intergenic'];
}

sub get_header_info {
  my $self = shift;
  return {
    ENTREZ => 'Entrez_ID'
  } 
}

sub run {
    my ($self, $tva, $other) = @_;

    # Data hash
    my %data;

    # Variation feature
    my $vf = $tva->variation_feature;

    # Return if gene isn't defined.
    return {} unless defined($other->{Gene});

    # entrez variable
    my $entrez;

    # Try to set entrez via ncbi and symbol lookup first
    $entrez = $self->get_by_ncbi( $other ); 
    if($entrez) {
        $data{ENTREZ} = $entrez;
        return \%data; 
    }

    # Try to set entrez via gencode and transcript id 
    $entrez = $self->get_by_gencode( $other ); 
    if($entrez) { 
        $data{ENTREZ} = $entrez;
        return \%data; 
    }

    # Return 
    return \%data; 
}

sub get_by_ncbi {
    my ($self, $other) = @_;

    return '' unless defined($other->{Extra}) && defined($other->{Extra}->{SYMBOL});

    # get symbol 
    my $symbol = $other->{Extra}->{SYMBOL};

    return '' unless defined($self->{json_db}->{NCBI}->{$symbol});

    my $entrez = join(',', @{$self->{json_db}->{NCBI}->{$symbol}}); 

    return $entrez; 
}

sub get_by_gencode {
    my ($self, $other) = @_;

    # get transcript id
    my $ensemblTrans = $other->{Feature};
    return '' unless defined($self->{json_db}->{GENCODE}->{$ensemblTrans});

    # SET ENTREZ ID
    my $entrez  = join(",", @{$self->{json_db}->{GENCODE}->{$ensemblTrans}});
   
    return $entrez; 
}

1;
