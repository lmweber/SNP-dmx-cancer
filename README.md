# snp-dmx-cancer

This repository contains code scripts and a `Snakemake` workflow to reproduce our simulations demonstrating the performance of genetic variation based demultiplexing tools (`Vireo` and `cellSNP`) for pooled single-cell RNA sequencing (scRNA-seq) samples in cancer (high-grade serous ovarian cancer (HGSOC) and lung adenocarcinoma).

The evaluations for the HGSOC dataset include simulated doublets, and the lung dataset demonstrates performance in a high tumor mutational load cancer type.

Based on the evidence from these simulations, we have used sample pooling and genetic variation based demultiplexing for our own studies on HGSOC. This has allowed us to achieve substantial cost savings for library preparation.

The `Snakemake` pipeline can be adapted to perform similar analyses for experimental design planning and budgeting purposes in your own dataset, given an initial set of scRNA-seq pilot samples.

These analyses and the pipeline will also be described in more detail in an upcoming paper.


## Contents

### Pipeline

Code scripts for the main pipeline are saved in the directory [pipeline/](pipeline/).

- [Snakefile](pipeline/Snakefile): `Snakefile` to run the workflow using `Snakemake`
- [scripts/](pipeline/scripts/): directory containing scripts for the individual steps in the `Snakemake` workflow


### Additional scripts

Scripts for additional steps outside the main workflow.

- [alternative](alternative/): scripts for alternative tools that were not used in the main workflow (see below)
- [demuxlet](demuxlet/): scripts to run demuxlet (instead of Vireo)
- [doublets](doublets/): scripts for doublet simulations
- [download_EGA/](download_EGA/): script to download files for lung adenocarcinoma dataset from European Genome-phenome Archive (EGA)
- [evaluations/](evaluations/): R scripts for performance evaluations
- [filter_vcf/](filter_vcf/): to do
- [genotype/](genotype/): scripts to generate genotype files (VCF files) from matched bulk RNA-seq or single-cell RNA-seq samples


### Alternatives

Scripts for alternative tools that were not used in the main workflow. Currently contains scripts to use `salmon alevin` instead of `Cell Ranger`. We used `Cell Ranger` due to incompatibility of the `salmon alevin` outputs with `cellSNP` and `Vireo` (`salmon alevin` generates a transcriptomic BAM file, while `cellSNP` and `Vireo` expect genomic BAM and VCF files). We have kept these scripts here in case they are useful in the future or for other work.

- [salmon_alevin/](alternative/salmon_alevin/): scripts to run `salmon alevin` instead of `Cell Ranger`
- [convert_VCF/](alternative/convert_VCF/): scripts to convert VCF file from genomic coordinates to transcriptomic coordinates


## Links

- Vireo paper: [Huang et al. (2019), Genome Biology](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-019-1865-2)
- Vireo: [documentation](https://vireosnp.readthedocs.io/en/latest/index.html)
- cellSNP: [documentation](https://github.com/single-cell-genetics/cellSNP)
- Cell Ranger: [documentation](https://support.10xgenomics.com/single-cell-gene-expression/software/overview/welcome)

