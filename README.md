# Semi-Supervised Topic Modeling

This repository contains an R script for semi-supervised topic modeling of social media posts stored in JSON files. The script detect non-political content to later clean the dataset for further analysis.

## Overview

The script processes social media posts from JSON files, performs topic modeling using the `keyATM` package.

## Features

- **Text Preprocessing**: Cleans and tokenizes text data.
- **Topic Modeling**: Identifies and analyzes key topics using `keyATM`.

## Requirements

- **R**
- **Libraries**: `quanteda`, `readtext`, `jsonlite`, `data.table`, `keyATM`, `magrittr`

Install required libraries with:

```r
install.packages(c("quanteda", "readtext", "jsonlite", "data.table", "keyATM", "magrittr"))
```

## Usage
1. Prepare Files: Place your JSON file (`input_data.json`) and stopwords file (`stopwords.txt`) in the working directory.
2. Run the Script: Execute the R script to filter out non-political posts.
3. Analyze Output: The results are saved in an RDS file (`final.rds`).
