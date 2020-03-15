# get the base image, the rocker/verse has R, RStudio and pandoc
FROM rocker/verse:3.6.2

# required
MAINTAINER Benjamin Brodeur Mathieu <bebrodeu@uw.edu>

COPY . /reScienceMarriageAndHappinessPkg

# go into the repo directory
RUN . /etc/environment \
  # Install linux depedendencies here
  && sudo apt-get update \
  && sudo apt-get install libudunits2-dev -y \
  # build this compendium package
  && R -e "devtools::install('/reScienceMarriageAndHappinessPkg', dep=TRUE)" \
  # run check on project
  && R -e "devtools::check('/reScienceMarriageAndHappinessPkg/analysis/paper.Rmd')"
