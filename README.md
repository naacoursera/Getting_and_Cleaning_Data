# Readme for `run_analysis.R` 

## Steps to run the R Scripts
1. Download data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
2. Extract into the toplevel of the repository
3. Run `Rscript run_analysis.R`

`tidy_data.txt` will be generated containing the tidy data

This file requires `reshape2` and `data.table` packages.

See CodeBook.md for detail on the extraction process as well as the column descriptions for `tidy_data.txt` 
