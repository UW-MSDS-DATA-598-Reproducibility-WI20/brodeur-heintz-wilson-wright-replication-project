rm(list=ls())
require(car)
require(Hmisc)
require(Matrix)
require(lme4)
library(xtable)
library(gssr)

# load the data
Gini = read.csv("data/Gini_families.csv")
#happy = read.table("sub-data.txt", header=T, sep=",")
data(gss_all)
happy = gss_all
happy$Year = happy$year
happy = merge(happy, Gini, by="Year")

# recode the GSS variables
happy$Happiness = recode(happy$happy, "1=3; 3=1; c(0,8,9)=NA")
happy$TRUSTrecode = recode(happy$trust, "1=3; 2=1; 3=2; c(0,8,9)=NA")
happy$FAIRrecode = recode(happy$fair, "2=3; 3=2; c(0,8,9)=NA")
happy$Age = recode(happy$age, "c(9)=NA")
happy$REALINCrecode = recode(happy$realinc, "0=NA")
happy$REALINClog = log(happy$REALINCrecode)
happy$White = as.numeric(happy$race==1)
happy$Married = as.numeric(happy$marital==1)
happy$Gini = happy$Total

# create two data sets, one for original data used in the paper (through 2008)
# and another for the full data set (now available through 2012)
origData = happy[happy$Year<=2008,]
fullData = happy

#### replicate multilevel model, Gini and happiness: Model 1
m1 = lmer(Happiness ~ Gini + (1 | Year), data=origData)
summary(m1)
ci.m1 = confint(m1)

#### Figure 1. Pattern over time of inequality, race, marital status
png(file='Figure1.png', units='in', width=11, height=8.5, res=400)
par(mfrow=c(2,2))
#inequality
giniByYear = Gini[Gini$Year>=1972,]
plot(giniByYear$Year,giniByYear$Total, type="o", pch=20, xlab="Year",
     ylab="Gini Coefficient", xaxt="n", ylim=c(.3, .46))
axis(1, at=seq(1947,2012,by=5),labels=seq(1947,2012,by=5))

#race
raceByYear = aggregate(White ~ Year, FUN=mean, data=fullData)
plot(happyByYear$Year, raceByYear$White, type="o", pch=20, xlab="Year",
     ylab="Proportion White Respondents", xaxt="n", ylim=c(.65, .95))
axis(1, at=seq(1947,2012,by=5),labels=seq(1947,2012,by=5))

#marital status
marByYear = aggregate(Married ~ Year, FUN=mean, data=fullData)
plot(marByYear$Year, marByYear$Married, type="o", pch=20, xlab="Year",
     ylab="Proportion Married Respondents", xaxt="n", ylim=c(.3, .9))
axis(1, at=seq(1947,2012,by=5),labels=seq(1947,2012,by=5))
par(mfrow=c(1,1))
dev.off()

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

#### RESPONDENT's INCOME ####
# logged real income is correlated with reported happiness, see correlation table
# but including income as a control, same effect of Gini
m2 = lmer(Happiness ~ Gini + REALINClog + (1 | Year), data=origData)
m2.ci = confint(m2)

#### RESPONDENT'S AGE ####
# age is correlated with reported happiness, see correlation table
# but including age as a control, same effect of Gini
m3 = lmer(Happiness ~ Gini + Age + (1 | Year), data=origData)
m3.ci = confint(m3)

#### RESPONDENT'S SEX ####
# sex is correlated with reported happiness, see correlation table
# interactions between sex and year
summary(lm(Happiness ~ factor(sex)*Year, data=origData)) # sig interaction (can cite a paper about women's declining reported happiness)
mbyYear = (aggregate(Happiness ~ Year, data=origData[origData$sex==1,], FUN=mean))
wbyYear = (aggregate(Happiness ~ Year, data=origData[origData$sex==2,], FUN=mean))
plot(mbyYear$Year, mbyYear$Happiness, ylim=c(1.9,2.5), pch=20, col="blue",
     ylab="Mean Happiness", xlab="Year")
abline(lm(Happiness ~ Year, data=mbyYear), col="blue")
par(new=T)
plot(wbyYear$Year, wbyYear$Happiness, ylim=c(1.9,2.5), pch=20, col="forestgreen",
     ylab="", xlab="")
abline(lm(Happiness ~ Year, data=wbyYear), col="forestgreen")
legend("bottomleft", legend=c("Men", "Women"), col=c("blue", "forestgreen"), lty=1, pch=20)

# but including sex as a control, same effect of Gini
m4 = lmer(Happiness ~ Gini + factor(sex) + (1 | Year), data=origData)
m4.ci = confint(m4)

#### RESPONDENT'S RACE ####
# race is correlated with happiness, see correlation table
# AND there are significant shifts in race, see figure of demographic trends
#### Figures 2 and 3. plot of proportion white x mean happiness, happiness of racial groups
happybyYear = aggregate(Happiness ~ Year, FUN=mean, data=origData)
raceByYear = merge(raceByYear, happybyYear, by="Year")

png(file='Figure2.png', units='in', width=11, height=8.5, res=400)
plot(raceByYear$White, raceByYear$Happiness, pch = 20, las=1, xlim=rev(range(raceByYear$White)),
 xlab="Proportion White", ylab="Mean Happiness")
abline(lm(Happiness ~ White, data=raceByYear), xlim=rev(range(raceByYear$White)))
text(raceByYear$White, raceByYear$Happiness, labels=raceByYear$Year, adj=c(.4, -.5), cex=.7)
mtext("Figure 2. Scatter plot (with best-fitting regression line) showing mean American happiness scores as a
      function of proportion White respondents, from 1972 to 2008", 1, 4.25, cex = .6)
dev.off()

png(file='Figure3.png', units='in', width=11, height=8.5, res=400)
whitebyYear = (aggregate(Happiness ~ Year, data=happy[happy$race==1,], FUN=mean))
blackbyYear = (aggregate(Happiness ~ Year, data=happy[happy$race==2,], FUN=mean))
otherbyYear = (aggregate(Happiness ~ Year, data=happy[happy$race==3,], FUN=mean))
plot(whitebyYear$Year, whitebyYear$Happiness, ylim=c(1.9,2.5), pch=20, col="blue",
     ylab="Mean Happiness", xlab="Year")
abline(lm(Happiness ~ Year, data=whitebyYear), col="blue")
par(new=T)
plot(whitebyYear$Year, blackbyYear$Happiness, ylim=c(1.9,2.5), pch=20, col="forestgreen",
     ylab="", xlab="")
abline(lm(Happiness ~ Year, data=blackbyYear), col="forestgreen")
par(new=T)
plot(whitebyYear$Year, otherbyYear$Happiness, ylim=c(1.9,2.5), pch=20, col="dodgerblue",
     ylab="", xlab="")
abline(lm(Happiness ~ Year, data=otherbyYear), col="dodgerblue")
legend("bottomleft", legend=c("White", "Black", "Other"), col=c("blue", "forestgreen", "dodgerblue", lty=1, pch=20))
mtext("Figure 3. Scatter plot (with best-fitting regression lines) showing mean happiness scores
      for respondents identified as White, Black, or another race, from 1972 to 2008", 1, 4.25, cex = .6)
dev.off()

# including race as a control, the effect of the Gini coefficient goes away.
# dummies for other and Black
m5 = lmer(Happiness ~ Gini + factor(race) + (1 | Year), data=happy)
# as a dummy variable for being White
m5 = lmer(Happiness ~ Gini + White + (1 | Year), data=origData)
m5.ci = confint(m5)


#### RESPONDENT'S MARITAL STATUS ####
# being married is correlated with reported happiness, see correlation table
# AND there are significant shifts in rates of marriage, see figure of demographic trends
# including marriage as a control, the effect of the Gini coefficient goes away.
m6 = lmer(Happiness ~ Gini + Married + (1 | Year), data=origData)
m6.ci = confint(m6)

# Figure 4. plot of proportion married x mean happiness.
# with abline of: linear model aggregated by year
marByYear = merge(marByYear, happybyYear, by="Year")

png(file='Figure4.png', units='in', width=11, height=8.5, res=400)
plot(marByYear$Married, marByYear$Happiness, pch = 20, las=1, xlim=rev(range(marByYear$Married)),
     ylim = c(2.1,2.26), xlab="Proportion Married", ylab="Mean Happiness")
abline(lm(Happiness ~ Married, data=marByYear), xlim=rev(range(marByYear$Married)))
text(marByYear$Married, marByYear$Happiness, labels=marByYear$Year, adj=c(.4, -.5), cex=.7)
mtext("Figure 4. Scatter plot (with best-fitting regression line) showing mean American happiness scores as a
      function of proportion married, from 1972 to 2008", 1, 4.25, cex = .6)
dev.off()

### Table 2. original replicated model and models with each control
stargazer(m1,m2,m3,m4,m5,m6)

#### APPENDIX #####
# models using full data to 2012
# replicate simple mediation (figure 3)
mediation1 = lmer(Happiness ~ Gini + (1 | Year), data=origData)
mediation2 = lmer(TRUSTrecode ~ Gini + (1 | Year), data=origData)
mediation3 = lmer(FAIRrecode ~ Gini + (1 | Year), data=origData)
mediation4 = lmer(Happiness ~ TRUSTrecode + (1 | Year), data=origData)
mediation5 = lmer(Happiness ~ FAIRrecode + (1 | Year), data=origData)
mediation6 = lmer(Happiness ~ Gini + FAIRrecode + TRUSTrecode + (1 | Year), data=origData)
# table of mediation results
stargazer(mediation1,mediation2,mediation3,mediation4,mediation5,mediation6)

# replicate figures 1 and 2 from the paper
# Fig. 1
png(file='AppendixFig1.png', units='in', width=11, height=8.5, res=400)
plot(Gini$Year[Gini$Year<=2009],Gini$Total[Gini$Year<=2009], type="o", pch=20, xlab="Year",
     ylab="Gini Coefficient", xaxt="n", yaxt="n", ylim=c(.3, .46))
axis(1, at=seq(1947,2007,by=5),labels=seq(1947,2007,by=5))
ys = sub('0[.]', '.',seq(.30,.46,by=.02))
ys[1] = ".30"
ys[6] = ".40"
axis(2, at=seq(.30,.46,by=.02),labels=ys, las=1)
mtext("Fig. 1. Income inequality in the United States from 1947 to 2009, as indexed by the Gini coefficient.", 1, 4, cex = .6)
dev.off()

# reproduce Fig. 2 from paper
# missing years - no happiness data from GSS
png(file='AppendixFig2.png', units='in', width=11, height=8.5, res=400)
plotdata = merge(happybyYear, Gini, by="Year")
plot(plotdata$Total, plotdata$Happiness, ylim=c(2.12, 2.26), xlim=c(.35, .45),
     pch = 20, las=1, ylab="Mean Happiness", xlab="Gini Coefficient", xaxt="n")
axis(1, at=seq(.35, .45, by=.02),labels=sub('0[.]', '.',seq(.35, .45, by=.02)))
abline(lm(plotdata$Happiness ~ plotdata$Total), lwd = 2)
text(plotdata$Total, plotdata$Happiness, labels=plotdata$Year, adj=c(.4, -.5), cex=.8)
mtext("Fig. 2. Scatter plot (with best-fitting regression line) showing mean American happiness scores as a
      function of income inequality, as indexed by the Gini coefficient, from 1972 to 2008", 1, 4.25, cex = .6)
dev.off()

