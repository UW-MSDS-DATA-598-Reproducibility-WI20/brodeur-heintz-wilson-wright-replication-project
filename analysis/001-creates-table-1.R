# ---- import-and-clean-the-data-for-table-1
  require(car)
  require(Hmisc)
  require(Matrix)
  require(lme4)
  library(gssr)
  library(xtable)

  data(gss_all)
  happy = gss_all
  
  happy$Happiness = recode(happy$happy, "1=3; 3=1; c(0,8,9)=NA")
  happy$TRUSTrecode = recode(happy$trust, "1=3; 2=1; 3=2; c(0,8,9)=NA")
  happy$FAIRrecode = recode(happy$fair, "2=3; 3=2; c(0,8,9)=NA")
  happy$Age = recode(happy$age, "c(9)=NA")
  happy$REALINCrecode = recode(happy$realinc, "0=NA")
  happy$REALINClog = log(happy$REALINCrecode)
  happy$White = as.numeric(happy$race==1)
  happy$Married = as.numeric(happy$marital==1)
  
  origData = happy[happy$year<=2008,]
  
# ---- create-the-correlations-and-table
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
  
# ---- display-table-1
  print(xtable(x=table1), type="html", comment=FALSE)
