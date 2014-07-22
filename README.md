## Supplementary materials for a report on the stratigraphy and radiocarbon dates from Gua Mo'o hono, Sulawesi, Indonesia

[![Build Status](https://travis-ci.org/benmarwick/PiperetalGMHBone.png?branch=master)](https://travis-ci.org/benmarwick/PiperetalGMHBone) [what's this?](http://en.wikipedia.org/wiki/Continuous_integration)

### Compendium DOI: 
 
http://dx.doi.org/......

### Author of this repository:

Ben Marwick (benmarwick@gmail.com)

### Published in: 

 Piper, Philip J., Sue O’Connor, David Bulbeck, Fredeliza Campos, Rachel Wood, Ken Aplin, Ben Marwick, Fakhrie. under review. Human foraging strategies in south-eastern Sulawesi, Indonesia during the mid to late Holocene, with special reference to the mid-5th millennium BP presence of dogs. _Quaternary International_

## Installation

The simplest way to access the code and data is to download the package in R using these lines:

```r
install.packages("devtools")
devtools::install_github("benmarwick/Stratigraphy-and-radiocarbon-dates-from-Gua-Mo-o-hono-Sulawesi")
library(PiperetalGMHBone)
```

Then you can inspect the plots and statistics in the pre-built Rmarkdown file with this line: 

```r
vignette("spit-depths-and-dated-samples")
```
Or if you want to build the vignette yourself, executing all the R code to generate the output and figures, download and unzip the [zip file](https://github.com/benmarwick/PiperetalGMHBone/zipball/master), navitage to the vignette directory and run `knitr::knit2html("spit-depths-and-dated-samples.Rmd")` and inspect the resulting html file. 

Or if you just want to see the code and data without using R, download the [zip file](https://github.com/benmarwick/PiperetalGMHBone/zipball/master) You will find the pre-built vignette as a html file in the `/inst/docs` directory.  

 
### Contents:

This repository contains a package for R that includes code and data used to analyse the spit depths and radiocarbon dates for the archaeological site Gua Mo'o hono, Sulawesi, Indonesia. Here's an overview of the key items in the repository: 

In the /vignettes directory: 

One Rmarkdown file that can be executed in R. This files contains sections of the narrative found in the published paper and R code used to analyse the data, compute statistics, and generate the data visualisations and tables. To execute these files, ensure all the files are together in a directory in the same structure as they are in this repository, then open R and run `knitr::knit2html("XXX")` where XXX is the name of the Rmd, including the .Rmd suffix and the quotation marks. There are many dependencies on non-core R packages and other software, see the dependencies section below for more details.

Three csv files that contain the raw data on radiocarbon dates and spit depths. 

In the /R directory: 
 
Four R files containing code that the Rmarkdown file uses to load libraries, prepare radiocarbon dates for OxCal calibration, compute statistics, and manage dependencies. These files are sourced by the Rmarkdown file and are needed to execute the Rmarkdown file. The code is externalised in these R files purely as a convenience to improve the readability of the Rmarkdown file.

In the /inst/docs directory:

One html file that is the result of executing the Rmarkdown file. One R file that contains only the code from the Rmarkdown file, as well as the same Rmarkdown file as in /vignettes.

### Licenses:

Manuscript:  CC-BY-4.0 http://creativecommons.org/licenses/by/4.0/

Code: MIT http://opensource.org/licenses/MIT year: 2014, copyright holder: Ben Marwick)

Data: CC0 http://creativecommons.org/publicdomain/zero/1.0/ attribution requested in reuse

### Dependencies:

I used [RStudio](http://www.rstudio.com/products/rstudio/) (version 0.98.953) on Windows 7 and Ubuntu 14.04. In /R/libraries.R you can see a list of packages used in this repository. Here is the sessionInfo()

R version 3.1.1 (2014-07-10)
Platform: x86_64-w64-mingw32/x64 (64-bit)

locale:
[1] LC_COLLATE=English_United States.1252 
[2] LC_CTYPE=English_United States.1252   
[3] LC_MONETARY=English_United States.1252
[4] LC_NUMERIC=C                          
[5] LC_TIME=English_United States.1252    

attached base packages:
[1] grid      stats     graphics  grDevices utils     datasets 
[7] methods   base     

other attached packages:
 [1] rmarkdown_0.2.49     MASS_7.3-33          devtools_1.5        
 [4] whisker_0.3-2        memoise_0.2.1        httr_0.3            
 [7] gridExtra_0.9.1      RColorBrewer_1.0-5   scales_0.2.4        
[10] reshape2_1.4.0.99    ggplot2_1.0.0        dplyr_0.2           
[13] plyr_1.8.1           PiperetalGMHBone_0.1 knitr_1.6           

loaded via a namespace (and not attached):
 [1] assertthat_0.1   colorspace_1.2-4 digest_0.6.4    
 [4] evaluate_0.5.5   formatR_0.10     gtable_0.1.2    
 [7] htmltools_0.2.4  labeling_0.2     munsell_0.4.2   
[10] packrat_0.4.0    parallel_3.1.1   proto_0.3-10    
[13] Rcpp_0.11.2      RCurl_1.95-4.1   stringr_0.6.2   
[16] tools_3.1.1      

All of these are included in this repository using [packrat](http://rstudio.github.io/packrat/), a dependency management system that takes a snapshot of the libraries needed for this project and saves it in the project directory so that you can recreate those exact same libraries on another machine. To use this system, open the Rproj file in RStudio, then open the Rmd file in /vignettes and knit that. 

Other system dependencies identified using `dependencies::needs()` (https://github.com/ropensci/dependencies): 

- pandoc (>= 1.12.3) http://johnmacfarlane.net/pandoc
- libcurl (version 7.14.0 or higher) http://curl.haxx.se

Note that these are external to R and are not bundled with this repository. You'll need to ensure they're installed yourself before executing the Rmarkdown file. Pandoc is installed when RStudio is installed.

### Contact: 

Ben Marwick, Assistant Professor, Department of Anthropology
Denny Hall 117, Box 353100, University of Washington
Seattle, WA 98195-3100 USA

t. (+1) 206.552.9450   e. bmarwick@uw.edu
f. (+1) 206.543.3285   w. http://faculty.washington.edu/bmarwick/ 



