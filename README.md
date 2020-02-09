# Replication of Marriage and happiness: Providing evidence against a relationship between inequality and happiness

 Replication project final submission
 University of Washington: Data 598 A

## Contributors

[Lauren Heintz](https://github.com/lheintz) [![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0002-2834-2112)  
[Will Wright](https://github.com/WrightWillT) [![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0003-1264-4105)  
[Tara Wilson](https://github.com/TaraWilson17) [![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0003-3150-3164)  
[Ben Brodeur Mathieu](https://github.com/ALotOfData) [![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0001-6464-9747)  

## Contents

The purpose of this assignment is to explore the emphasis on reproducibility in scientific research. We will be recreating figures of the 2014 paper, *Marriage and happiness: Providing evidence against a relationship between inequality and happiness*. This paper challenges claims about American happiness, and looks into "happiness drivers" known to change over time. The paper examines the influence of factors such as race and marriage on happiness, and explains how accounting for these factors invalidates claims by a previous paper between the relationship of inequality and happiness. Specifically, our team will be replicating Table 2, a look into demographics and happiness, and Figure 2, a linear investigation of mean happiness and the proportion of the population that is married and white. Since this paper challenges previous claims on the grounds of data control, it is a prime candidate for a meaningful reproduction.

**Paper:** [Marriage and happiness: Providing evidence against a relationship between inequality and happiness](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/25655)

**Citation:** Grunberg, Rebecca L. (Sloan School Of Management, MIT); Kim, Hyejun (Sloan School Of Management, MIT); Kim, Minjae (Sloan School Of Management, MIT). (2014). Marriage and happiness Grunberg Kim Kim.pdf [Data set]. Harvard Dataverse. https://doi.org/10.7910/DVN/25655/MB980L

## Data

The data is available through Harvard Dataverse. The data for `Gini_families.csv` is available [here](https://dataverse.harvard.edu/file.xhtml?persistentId=doi:10.7910/DVN/25655/EHOQ1O&version=1.0). The remaining data from `sub-data.txt` is available for download [here](https://dataverse.harvard.edu/file.xhtml?persistentId=doi:10.7910/DVN/25655/EVUXXU&version=1.0).

## Dependencies

|     Team Member     | OS/Version               | R Version                  |
| :-----------------: | ------------------------ | -------------------------- |
|    Lauren Heintz    | MacOS Mojave 10.14.6     | 3.6.1                      |
|     Will Wright     | MasOS Catalina 10.15.1 	| 3.6.2                      |
|     Tara Wilson     | Windows 10 Home 1903 x64 | 3.3.0, 3.5.0, 3.5.3, 3.6.2 |
| Ben Brodeur Mathieu | MacOS Catalina 10.15.2   | 3.6.2                      |

R Packages Explicitly Required:
* car
* Hmisc
* Matrix
* lme4
* xtable

In the process of installed the listed packages above, other dependencies emerged. Here is the list of packages and their versions ultimately installed.

| R Package Name | Version   |
| :------------: | --------- |
|      car       | 3.0_2     |
|      lme4      | 1.1_21    |
|  matrixmodels  | 0.4_1     |
|     hmisc      | 4.2_0     |
|     xtable     | 1.8_4     |
|     abind      | 1.4_5     |
|    cardata     | 3.0_2     |
|    maptools    | 0.9_5     |
|     minqa      | 1.2.4     |
|     nloptr     | 1.2.1     |
|    openxlsx    | 4.1.0     |
|    pbkrtest    | 0.4_7     |
|    quantreg    | 5.38      |
|   rcppeigen    | 0.3.3.5.0 |
|      rio       | 0.5.16    |
|       sp       | 1.3_1     |
|    sparsem     | 1.77      |
|      zip       | 2.0.1     |
|    acepack     | 1.4.1     |
|   checkmate    | 1.9.1     |
|    formula     | 1.2_3     |
|   gridextra    | 2.3       |
|   htmltable    | 1.13.1    |
|  latticeextra  | 0.6_28    |
|    viridis     | 0.5.1     |

## [Contributing](CONTRIBUTING.md)

We welcome contributions from everyone. Before you get started, please see our contributor guidelines. Please note that this project is released with a Contributor Code of Conduct. By participating in this project you agree to abide by its terms.

Contibution guidelines can be found [here.](CONTRIBUTING.md) Additional Code of Conduct information can be found [here.](CODE_OF_CONDUCT.md)
