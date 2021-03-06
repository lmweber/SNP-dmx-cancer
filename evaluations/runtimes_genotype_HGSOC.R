###############
# Runtime plots
###############

# Runtime plot for genotyping

# HGSOC dataset


# module load conda_R/4.1
# Rscript runtimes.R


library(tidyverse)
library(magrittr)
library(ggplot2)


# ----------------------------
# load runtimes for genotyping
# ----------------------------

# steps with one value per sample

sample_names_bulk <- c("17667X1", "17667X2", "17667X3")
sample_names_singlecell <- c("16030X2", "16030X3", "16030X4")

runtime_genotype_bulk_cellSNP <- vector("list", 3)
names(runtime_genotype_bulk_cellSNP) <- sample_names_bulk

runtime_genotype_singlecell_cellSNP <- vector("list", 3)
names(runtime_genotype_singlecell_cellSNP) <- sample_names_singlecell

for (i in 1:length(sample_names_bulk)){
  fn <- paste0("../../genotype/runtimes/genotype_bulk_cellSNP/runtime_genotype_bulk_cellSNP_", sample_names_bulk[i], ".txt")
  runtime_genotype_bulk_cellSNP[[i]] <- gsub("runtime: ", "", gsub(" seconds", "", readLines(fn)))
  
  fn <- paste0("../../genotype/runtimes/genotype_singlecell_cellSNP/runtime_genotype_singlecell_cellSNP_", sample_names_singlecell[i], ".txt")
  runtime_genotype_singlecell_cellSNP[[i]] <- gsub("runtime: ", "", gsub(" seconds", "", readLines(fn)))
}

runtime_genotype_bulk_cellSNP <- unlist(runtime_genotype_bulk_cellSNP)
runtime_genotype_singlecell_cellSNP <- unlist(runtime_genotype_singlecell_cellSNP)


# steps with one value for all samples combined

fn <- "../../genotype/runtimes/genotype_bulk_cellSNP/runtime_concatenate_VCF.txt"
runtime_genotype_bulk_cellSNP_concatenate <- gsub("runtime: ", "", gsub(" seconds", "", readLines(fn)))

fn <- "../../genotype/runtimes/genotype_singlecell_cellSNP/runtime_concatenate_VCF.txt"
runtime_genotype_singlecell_cellSNP_concatenate <- gsub("runtime: ", "", gsub(" seconds", "", readLines(fn)))

fn <- "../../genotype/runtimes/genotype_bulk_bcftools/runtime_genotype_bulk_HGSOC_bcftools.txt"
runtime_genotype_bulk_bcftools <- gsub("runtime: ", "", gsub(" seconds", "", readLines(fn)))

fn <- "../../genotype/runtimes/genotype_bulk_bcftools/runtime_genotype_bulk_HGSOC_bcftools_reheader.txt"
runtime_genotype_bulk_bcftools_reheader <- gsub("runtime: ", "", gsub(" seconds", "", readLines(fn)))


# -------------
# plot runtimes
# -------------

# set up plotting data frame

df_separate_bulk <- as.data.frame(rbind(
  genotype_bulk_cellSNP = runtime_genotype_bulk_cellSNP
))
for (i in 1:ncol(df_separate_bulk)) {
  df_separate_bulk[, i] %<>% as.numeric
}
df_separate_bulk$method <- rownames(df_separate_bulk)
df_separate_bulk$parallel <- c(TRUE)
df_separate_bulk <- gather(df_separate_bulk, "sample_id", "runtime", 
                           "17667X1", "17667X2", "17667X3")

df_separate_singlecell <- as.data.frame(rbind(
  genotype_singlecell_cellSNP = runtime_genotype_singlecell_cellSNP
))
for (i in 1:ncol(df_separate_singlecell)) {
  df_separate_singlecell[, i] %<>% as.numeric
}
df_separate_singlecell$method <- rownames(df_separate_singlecell)
df_separate_singlecell$parallel <- c(TRUE)
df_separate_singlecell <- gather(df_separate_singlecell, "sample_id", "runtime", 
                                 "16030X2", "16030X3", "16030X4")

df_single <- as.data.frame(rbind(
  genotype_bulk_bcftools = runtime_genotype_bulk_bcftools
))
colnames(df_single) <- "all"
df_single$all %<>% as.numeric
df_single$method <- rownames(df_single)
df_single$parallel <- c(FALSE)
df_single <- gather(df_single, "sample_id", "runtime", "all")

df_combined <- rbind(df_separate_bulk, df_separate_singlecell, df_single)

method_names <- c("genotype_bulk_bcftools", "genotype_bulk_cellSNP", "genotype_singlecell_cellSNP")

df_combined$method <- factor(df_combined$method, levels = method_names)
df_combined$sample_id <- factor(df_combined$sample_id, 
                                levels = c("17667X1", "17667X2", "17667X3", 
                                           "16030X2", "16030X3", "16030X4", "all"))


# convert units to hours

df_plot <- df_combined
df_plot$runtime <- df_plot$runtime / 3600


# generate plot

colors <- c("darkorange", "firebrick")

ggplot(df_plot, aes(x = runtime, y = method, group = sample_id, color = parallel)) + 
  geom_point(shape = 4, size = 1.5, stroke = 1.5) + 
  scale_color_manual(values = colors) + 
  xlim(c(0, max(df_plot$runtime))) + 
  xlab("runtime (hours)") + 
  scale_y_discrete(limits = rev(levels(df_plot$method))) + 
  ggtitle("Genotyping") + 
  theme_bw() + 
  theme(axis.title.y = element_blank(), 
        legend.position = "none")

ggsave("../../plots/main/runtimes_genotype_HGSOC.pdf", width = 4.55, height = 1.75)
ggsave("../../plots/main/runtimes_genotype_HGSOC.png", width = 4.55, height = 1.75)

