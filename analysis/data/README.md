# Obtaining data

## Structure

```text
.
├── Gini_families.csv
├── README.md
└── sub-data.txt
```

| File              | Description                                                                                                                                                                                           | Obtained from                                                                                                                  |
| ----------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| Gini_families.csv | [Gini coefficient](https://en.wikipedia.org/wiki/Gini_coefficient) obtained by the original authors from the U.S. Census Bureau.                                                                      | [Harvard dataverse](https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/25655/EHOQ1O) |
| sub-data.txt      | Subset of the [GSS](https://gss.norc.org/) dataset. This csv format txt file is missing columns described in the paper notably RACE and MARITAL which represent respondent's races and marital status | [Harvard dataverse](https://dataverse.harvard.edu/file.xhtml?persistentId=doi:10.7910/DVN/25655/EVUXXU&version=1.0)            |

## Important notes

As the `sub-data.txt` dataset was missing columns available in the GSS data, the R code used to replicate these findings pulled a new dataset using the `gssr` R package.
Instructions to download and use the `gssr` R package are available at the [GSS website](https://kjhealy.github.io/gssr/).