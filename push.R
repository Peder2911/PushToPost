#!/usr/bin/Rscript

library(RPostgreSQL)
library(yaml)
library(readxl)
library(stringr)
library(fs)

# ================================
if(! interactive()){
   filepath <- commandArgs(trailingOnly = TRUE)[1]
} else {
   writeLines('Please enter filepath:\n>>> ',sep = '')
   filepath <- readline()
}

# SQL setup ======================

dr <- dbDriver('PostgreSQL')
config <- yaml.load_file('config.yaml')
config$con$dr <- dr

con <- do.call(dbConnect,config$con)

# File setup =====================

dataname <- path_split(filepath) 
dataname <- dataname[[1]][length(dataname[[1]])]

data <- read_xlsx(filepath)

# ================================

dbWriteTable(con,dataname,data)

