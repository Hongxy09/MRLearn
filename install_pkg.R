options(timeout = 600000000)
options(download.file.method = "wininet") 

devtools::install_github("mrcieu/gwasglue", build_vignettes = FALSE)
packages=c("dplyr", "tidyr", "CMplot")
Biopkg=c("VariantAnnotation")
ipak <- function(pkg,flag){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) {
    if(flag=="normal")
      install.packages(new.pkg, dependencies = TRUE)
    else{
      BiocManager::install(new.pkg)
    }
    # sapply(pkg, require, character.only = TRUE) # 这是在载入所有的包
  }
}
ipak(packages,flag="normal")
ipak(Biopkg,flag="bio")
