require(car)
require(Hmisc)
require(Matrix)
require(lme4)
library(xtable)
library(gssr)

Gini = read.csv("../data/Gini_families.csv")
data(gss_all)
happy = gss_all
happy$Year = happy$year
happy = merge(happy, Gini, by="Year")

happy$Happiness = recode(happy$happy, "1=3; 3=1; c(0,8,9)=NA")
happy$TRUSTrecode = recode(happy$trust, "1=3; 2=1; 3=2; c(0,8,9)=NA")
happy$FAIRrecode = recode(happy$fair, "2=3; 3=2; c(0,8,9)=NA")
happy$Age = recode(happy$age, "c(9)=NA")
happy$REALINCrecode = recode(happy$realinc, "0=NA")
happy$REALINClog = log(happy$REALINCrecode)
happy$White = as.numeric(happy$race==1)
happy$Married = as.numeric(happy$marital==1)

origData = happy[happy$Year<=2008,]

#### Table. Correlation of control variables and reported happiness
income = cor.test(origData$REALINClog, origData$Happiness)
age = cor.test(origData$Age, origData$Happiness)
sex = cor.test(origData$sex, origData$Happiness)
race = cor.test(origData$White, origData$Happiness)
marital = cor.test(origData$Married, origData$Happiness)

Estimate = round(c(income$estimate,age$estimate,sex$estimate,race$estimate,marital$estimate),3)
p = round(c(income$p.value,age$p.value,sex$p.value,race$p.value,marital$p.value),3)
table1 = as.data.frame(cbind(Estimate,p))
names(table1)[2] = "p value"
rownames(table1) = c("Logged Income", "Age", "Sex", "White", "Married")
xtable(table1, caption="Correlations between happiness and control variables")
