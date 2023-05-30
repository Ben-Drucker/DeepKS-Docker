install.packages('bspm')
pkg_list <- c("dplyr",
"tidyverse",
"readxl",
"tibble",
"readr",
"this.path",
"stringr",
"BiocManager",
"dendextend",
"circlize",
"viridis",
"ggplot2",
"grImport2",
"rsvg",
"broman",
"numbers",
"devtools",
"Cairo")

bio_pkg_list <- c("Biostrings", "seqinr", "DECIPHER")

install.packages(pkg_list, dependencies = TRUE, NCpus = 8)
devtools::install_version('rlang', ">= 1.1.1")

for (bio_pkg in bio_pkg_list){
    BiocManager::install(bio_pkg)
}
