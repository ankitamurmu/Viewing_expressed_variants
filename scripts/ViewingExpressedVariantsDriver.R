#!/bin/R
#Driver script

#source in the Utilities script
source("../ViewingExpressedVariantsUtilities.R")

input_file <- commandArgs(trailingOnly = T)
if(length(input_file) == 2){
if(input_file[2] == "TRUE") # if it is a TCGA file then do both epigenetics and gene variants visualizaiton.
{
  #Read in the TCGA file
  df <- process_TCGA_file(input_file[1])

  
  #Get pathway enrichment dataframe for visualization (gene and p-value only)
  # grabs from data output, check this path w group?
  path_data <- read.csv("../data_output/pathogenic_variants.csv")
  
  #Generate visualization for expressed variants
  expressed_variants_viz(path_data)
  
  #Generate visualization for pathways
  pathway_viz(path_data)
  
  #Generate visualization for SVs.
  generate_sv_viz(df)
  
  #Create summary report
  summ_report <- summary_report(type = "TCGA report")
  return(summ_report)
} else if(input_file[2] == "FALSE"){
  
  #Read the data file
  variants_vcf_df <- process_vcf_file(input_file[1])
  #Get pathway enrichment dataframe for visualization (gene and p-value only)
  # grabs from data output, check this path w group?
  path_data <- read.csv("../data_output/pathogenic_variants.csv")
  
  #Generate visualization for expressed variants
  expressed_variants_viz(path_data)
  # Generate visualization for pathways
  pathway_viz(path_data)
  #Create summary report
  summ_report <- summary_report(type = "Expressed variants only")
  return(summ_report)
}
} else if(length(input_file) != 2){
  print("\n Enter path for input vcf file and whether it is a TCGA file (TRUE) or not (FALSE)\n")
}