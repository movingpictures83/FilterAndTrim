#First must have dada2 and Bioconductor installed: https://benjjneb.github.io/dada2/dada-installation.html 
#Must also have phyloseq installed: http://joey711.github.io/phyloseq/install.html
#dyn.load(paste("RPluMA", .Platform$dynlib.ext, sep=""))
#source("RPluMA.R")

library(dada2); 
packageVersion("dada2")


input <- function(inputfile) {
  #pfix <<- prefix()
  #if (length(pfix) != 0) {
  #   pfix <<- paste(pfix, "/", sep="")
  #}

  parameters <- read.table(inputfile, as.is=T);
  rownames(parameters) <- parameters[,1]
  fastqdir <<- toString(parameters["FASTQ", 2])

  ###############################################################
  # DEFAULT VALUES
  truncForward <<- 0
  truncReverse <<- 0
  trimForward <<- 0
  trimReverse <<- 0
  maxN <<- 0
  maxEE <<- Inf
  truncQ <<- 2
  ###############################################################
  print(typeof(parameters))
  if ("truncForward" %in% rownames(parameters)) {
  truncForward	<<- as.integer(parameters["truncForward", 2])
  }
  if ("truncReverse" %in% rownames(parameters)) {
  truncReverse	<<- as.integer(parameters["truncReverse", 2])
  }
  if ("trimForward" %in% rownames(parameters)) {
  trimForward	<<- as.integer(parameters["trimForward", 2])
  }
  if ("trimReverse" %in% rownames(parameters)) {
  trimReverse	<<- as.integer(parameters["trimReverse", 2])
  }
  if ("maxN" %in% rownames(parameters)) {
  maxN	<<- as.integer(parameters["maxN", 2])
  }
  if ("maxEE" %in% rownames(parameters)) {
  maxEE	<<- as.integer(parameters["maxEE", 2])
  }
  if ("truncQ" %in% rownames(parameters)) {
  truncQ	<<- as.integer(parameters["truncQ", 2])
  }
}

run <- function() {
#path <<- paste(pfix, fastqdir, sep="") # CHANGE ME to the directory containing the fastq files after unzipping.
path <<- fastqdir
#print(list.files(path))
#print(path)

# Forward and reverse fastq filenames have format: SAMPLENAME_R1_001.fastq and SAMPLENAME_R2_001.fastq
fnFs <<- sort(list.files(path, pattern="-R1.fastq", full.names = TRUE))
fnRs <<- sort(list.files(path, pattern="-R2.fastq", full.names = TRUE))

#print(fnFs)
#print(fnRs)
# Extract sample names, assuming filenames have format: SAMPLENAME_XXX.fastq
sample.names <<- sapply(strsplit(basename(fnFs), "-"), `[`, 1)

#Inspect read quality profiles------------------

}

output <- function(outputfile) {
#Filter and trim--------------------------------
#Place filtered files in filtered/ subdirectory
filtFs <- file.path(paste0(outputfile, sample.names, "_F_filt.fastq.gz"))
filtRs <- file.path(paste0(outputfile, sample.names, "_R_filt.fastq.gz"))
names(filtFs) <- sample.names
names(filtRs) <- sample.names

#print(fnFs)
#print(fnRs)
out <- filterAndTrim(fnFs, filtFs, fnRs, filtRs, truncLen=c(truncForward, truncReverse), trimLeft = c(trimForward, trimReverse),
                     maxN=maxN, maxEE=maxEE, truncQ=truncQ, rm.phix=TRUE,
                     compress=TRUE, multithread=TRUE, n = 1e+09) # On Windows set multithread=FALSE
#saveRDS(out, paste(outputfile, "rds", sep="."))
#print(typeof(out))
#print(out)
write.csv(out, paste(outputfile, "stats.csv",sep=""))
}


