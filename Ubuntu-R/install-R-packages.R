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
"numbers")

bio_pkg_list <- c("Biostrings", "seqinr", "DECIPHER")

install.packages(pkg_list, dependencies = TRUE)

for (bio_pkg in bio_pkg_list){
    BiocManager::install(biopkg)
}
