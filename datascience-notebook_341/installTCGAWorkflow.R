# Set maximum number of DLLs to a higher value as per https://github.com/BioinformaticsFMRP/TCGAWorkflow/issues/4
Sys.setenv(R_MAX_NUM_DLLS = 512)
# Set CRAN mirror
country.code <- 'de'  # use yours
url.pattern <- 'https://'  # use http if you want
repo.data.frame <- subset(getCRANmirrors(), CountryCode == country.code & grepl(url.pattern, URL))
options(repos = repo.data.frame$URL)
# Execute the installer snippet from GitHub
source("https://bioconductor.org/biocLite.R")
deps <- c("pathview","clusterProfiler","ELMER", "DO.db","GO.db", 
          "ComplexHeatmap","EDASeq", "TCGAbiolinks","AnnotationHub",
          "gaia","ChIPseeker","minet","BSgenome.Hsapiens.UCSC.hg19",
          "MotifDb","MotIV", "rGADEM", "motifStack","RTCGAToolbox")
for(pkg in deps)  if (!pkg %in% installed.packages()) biocLite(pkg, dependencies = TRUE)
deps <- c("devtools","DT","pbapply","readr","circlize")
for(pkg in deps)  if (!pkg %in% installed.packages())  install.packages(pkg,dependencies = TRUE)
devtools::install_github("BioinformaticsFMRP/TCGAWorkflowData")
devtools::install_github("BioinformaticsFMRP/TCGAWorkflow", dependencies = TRUE)

