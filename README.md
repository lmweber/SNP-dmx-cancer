# HGSOC-Vireo

Repository containing scripts to demultiplex HGSOC scRNA-seq samples using Vireo/cellSNP.


## Links

- Vireo paper: [Huang et al. 2019, Genome Biology](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-019-1865-2)
- Vireo: [documentation](https://vireosnp.readthedocs.io/en/latest/index.html)
- cellSNP: [documentation](https://github.com/single-cell-genetics/cellSNP)


## Scripts

Order of scripts (where `ZZZ` refers to the samples, i.e. `16030X2`, `16030X3`, `16030X4`):

- `run_cellranger_ZZZ.sh`
- `convert_BAM_to_SAM_ZZZ.sh` (will possibly replace some of these with shell pipes)
- `parse_SAM_barcodes_ZZZ.sh`
- `convert_parsed_SAM_to_BAM_ZZZ.sh`
- `merge_parsed_BAM_files.sh`
- `index_merged_BAM.sh`
- `parse_and_merge_barcodes.sh`
- `run_cellSNP.sh`
- `run_vireo.sh`
- `evaluations.R`

