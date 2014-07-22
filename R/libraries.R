#' Function to load libraries
#' 
#' @export
#' 


my_libraries <- function(){
# libraries need to be in a .R file so packrat can find them
# to bundle them in with the repository 

# set repository to download packages from 
r <- getOption("repos")
r["CRAN"] <- "http://cran.rstudio.com/"
options(repos = r)
rm(r)

# function to download packages if they are not 
# available locally

ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

# The list of packages needed by this repository
pkgs <- c('knitr', 'plyr', 'dplyr', 'ggplot2', 'reshape2', 'scales', 'RColorBrewer', 'gridExtra', 'httr', 'memoise', 'whisker','devtools', 'MASS')
ipak(pkgs)

# assuming that devtools is now installed...
ipak_github <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    devtools::install_github(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

github_pkgs <- c("rmarkdown")
lapply(github_pkgs, ipak_github)


# # this is for reshape2, oddly the repo name (reshape) is different from the 
# # package name (reshape2)...
# ipak_github_reshape <- function(pkg,pkg2){
#   new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
#   if (length(new.pkg)) 
#     devtools::install_github(new.pkg, dependencies = TRUE)
#   sapply(pkg2, require, character.only = TRUE)
# }
# ipak_github_reshape("reshape", "reshape2")
}
