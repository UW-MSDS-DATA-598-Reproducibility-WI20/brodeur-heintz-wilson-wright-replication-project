# ---- import-and-clean-the-data-for-table-2
  require(car)
  require(Hmisc)
  require(Matrix)
  require(lme4)
  library(xtable)
  library(gssr)
  library(stargazer)
  library(kableExtra)
  
  Gini = read.csv("../data/Gini_families.csv")
  data(gss_all)
  happy = gss_all
  happy$Year = happy$year
  happy = merge(happy, Gini, by="Year")
  
  happy$Happiness = recode(happy$happy, "1=3; 3=1; c(0,8,9)=NA")
  happy$Age = recode(happy$age, "c(9)=NA")
  happy$REALINCrecode = recode(happy$realinc, "0=NA")
  happy$REALINClog = log(happy$REALINCrecode)
  happy$White = as.numeric(happy$race==1)
  happy$Married = as.numeric(happy$marital==1)
  happy$Gini = happy$Total

  origData = happy[happy$Year<=2008,]
  
# ---- run-the-regressions
  m1 = lmer(Happiness ~ Gini + (1 | Year), data=origData)
  ci.m1 = confint(m1)
  
  m2 = lmer(Happiness ~ Gini + REALINClog + (1 | Year), data=origData)
  m2.ci = confint(m2)
  
  m3 = lmer(Happiness ~ Gini + Age + (1 | Year), data=origData)
  m3.ci = confint(m3)
  
  m4 = lmer(Happiness ~ Gini + factor(sex) + (1 | Year), data=origData)
  m4.ci = confint(m4)
  
  m5 = lmer(Happiness ~ Gini + White + (1 | Year), data=origData)
  m5.ci = confint(m5)
  
  m6 = lmer(Happiness ~ Gini + Married + (1 | Year), data=origData)
  m6.ci = confint(m6)

# ---- display-table-2
  output <- stargazer(m1,m2,m3,m4,m5,m6, type="text")
  
  knitr::kable(x=output, "html", booktabs = TRUE, linesep = "&&") %>% 
    kable_styling(full_width = FALSE, font_size = 12) %>% 
    column_spec(1, width = "4cm") %>% 
    save_kable(file = "table_2.png")

  