#!/bin/bash

####################################################################
# Shell script to genotype single-cell RNA-seq samples using cellSNP
####################################################################

# This script runs cellSNP (mode 2) to genotype and generate VCF files directly 
# on the single-cell RNA-seq samples in our HGSOC dataset. This is an alternative 
# to genotyping matched bulk samples.


# qsub -V -cwd -pe local 10 -l mem_free=10G,h_vmem=11G,h_fsize=100G genotype_singlecell.sh


# --------------------
# Run cellSNP (mode 2)
# --------------------

# note: can be more stable to run interactively with "qrsh" instead of "qsub" on cluster

# gunzip barcodes file
mkdir -p ../../../genotype/16030X2
gunzip -c ../../../outputs/HGSOC/16030X2_HJVMLDMXX/outs/filtered_feature_bc_matrix/barcodes.tsv.gz > ../../../genotype/16030X2/barcodes.tsv

cellSNP \
-s ../../../outputs/HGSOC/16030X2_HJVMLDMXX/outs/possorted_genome_bam.bam \
-b ../../../genotype/16030X2/barcodes.tsv \
-O ../../../genotype/16030X2/cellSNP_singlecell \
-p 10 \
--minMAF=0.01 \
--minCOUNT=50 \
--UMItag=None

