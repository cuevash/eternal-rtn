# LOG

# 2022-10-10

* Objective is to create a pipeline with DVC that helps to organize the creation of graphics.
* Steps:
  * Install mamba on the conda base env.
  * Create env with python, cookiecutter and R base installed
    * mamba create --name data-science-r-proj --channel=conda-forge python=3.8 r-base=4.2.1 cookiecutter=2.1.1
  * Activate env
  * Install renv
    * mamba install -c conda-forge r-renv=0.16.0
  * Install dvc
    * mamba install -c conda-forge dvc=2.30.0
  * expand the template 
    * cookiecutter https://github.com/khuyentran1401/data-science-template
  * Set up renv and get inital snapshot of the packages.
    * run R
      * renv::init()
      * 
  * Run RStudio from terminal using our r-base 
    * See -> https://community.rstudio.com/t/use-a-different-r-version-temporarily-in-rstudio/20848/7
    * ````
    export RSTUDIO_WHICH_R=/Users/hector/opt/miniconda3/envs/data-science-r-proj/bin/R
    open data-science-r-proj.Rproj
    ````
    * This does not work..

  * Again:
  * launchctl setenv RSTUDIO_WHICH_R /Users/hector/opt/miniconda3/envs/data-science-r-proj/bin/R
    * This works!


  * options(pkgType = "mac.binary") So that by default try to install binaries
  * install.packages("renv")
  * renv::init(bare = TRUE)