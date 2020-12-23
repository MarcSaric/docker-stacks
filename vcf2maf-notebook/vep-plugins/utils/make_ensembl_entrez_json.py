#!/usr/bin/env python
"""
Accessory script for making the JSON object to use in the GDC entrez plugin.

@author: Kyle Hernandez <kmhernan@uchicago.edu>
"""
from __future__ import print_function
import json
import sys
import gzip


def load_gencode(fil):
    '''Loads the gencode data into a JSON object'''
    dic = {}

    try:
        fh = open(fil, 'rt')
    except Exception:
        print('ERROR!!', 'Unable to open input file', fil, file=sys.stderr)
    else:
        fh.close()

    # Open
    if fil.endswith('gz'):
        fh = gzip.open(fil, 'rt')
    else:
        fh = open(fil, 'rt')

    # Process
    for line in fh:
        tid, entrez = line.rstrip('\r\n').split('\t')
        # Need the ENS Transcript ID not the version
        tid = tid.split('.')[0]
        if entrez:
            if tid not in dic:
                dic[tid] = []
            dic[tid].append(int(entrez))

    fh.close()

    return dic


def load_ncbi(fil):
    '''Loads the ncbi data into a JSON object'''
    dic = {}

    try:
        fh = open(fil, 'rt')
    except Exception:
        print('ERROR!!', 'Unable to open input file', fil, file=sys.stderr)
    else:
        fh.close()

    # Open
    if fil.endswith('gz'):
        fh = gzip.open(fil, 'rt')
    else:
        fh = open(fil, 'rt')

    # Process
    head = []
    for line in fh:
        # comment lines start with '#'
        if line.startswith('#'):
            continue
        else:
            # This assumes that the first column is tax_id
            # second column is GeneID and third column is Symbol
            # Also, geneID and symbol should always be defined
            cols = line.rstrip('\r\n').split('\t')
            entrez = int(cols[1])
            symbol = cols[2]
            if symbol not in dic:
                dic[symbol] = []
            dic[symbol].append(entrez)

    fh.close()

    return dic


def print_usage():
    '''Prints usage to stderr'''
    print('''
-------------------------------------------------------------------------------
Converts the Gencode Entrez Gene IDs file:
<ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_22/gencode.v22.metadata.EntrezGene.gz>

and the NCBI human gene info file:
<ftp://ftp.ncbi.nih.gov/gene/DATA/GENE_INFO/Mammalia/Homo_sapiens.gene_info.gz>

to a JSON object for use with the GDC_entrez plugin
-------------------------------------------------------------------------------

    python make_ensembl_entrez_json.py <gencode_entrez_gene_file>
           <ncbi_gene_info_file> <output_json_file>
''', file=sys.stderr)


if __name__ == '__main__':
    if len(sys.argv) != 4:
        print_usage()
        sys.exit(1)

    # Positionals
    gencode_fil = sys.argv[1]
    ncbi_fil = sys.argv[2]
    ofil = sys.argv[3]

    # Main container
    data = {'GENCODE': {}, 'NCBI': {}}

    # Load gencode
    data['GENCODE'] = load_gencode(gencode_fil)

    # Load ncbi
    data['NCBI'] = load_ncbi(ncbi_fil)

    # Write
    with open(ofil, 'wt') as o:
        json.dump(data, o)
