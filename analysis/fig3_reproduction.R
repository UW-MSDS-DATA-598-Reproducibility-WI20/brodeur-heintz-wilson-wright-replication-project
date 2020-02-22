require(car)
require(Hmisc)
require(Matrix)
require(lme4)
library(xtable)
library(gssr)

Gini = read.csv("../data/Gini_families.csv")
#happy = read.table("sub-data.txt", header=T, sep=",")
data(gss_all)
happy = gss_all
happy = merge(happy, Gini, by.x = "year", by.y = "Year")

# recode the GSS variables
happy$Happiness = car::recode(happy$happy, "1=3; 3=1; c(0,8,9)=NA")
happy$White = as.numeric(happy$race==1)
happy$Married = as.numeric(happy$marital==1)

whitebyYear = (aggregate(Happiness ~ year, data=happy[happy$race==1,], FUN=mean))
blackbyYear = (aggregate(Happiness ~ year, data=happy[happy$race==2,], FUN=mean))
otherbyYear = (aggregate(Happiness ~ year, data=happy[happy$race==3,], FUN=mean))
plot(whitebyYear$year, whitebyYear$Happiness, ylim=c(1.9,2.5), pch=20, col="blue",
     ylab="Mean Happiness", xlab="Year")
abline(lm(Happiness ~ year, data=whitebyYear), col="blue")
par(new=T)
plot(whitebyYear$year, blackbyYear$Happiness, ylim=c(1.9,2.5), pch=20, col="forestgreen",
     ylab="", xlab="")
abline(lm(Happiness ~ year, data=blackbyYear), col="forestgreen")
par(new=T)
plot(whitebyYear$year, otherbyYear$Happiness, ylim=c(1.9,2.5), pch=20, col="dodgerblue",
     ylab="", xlab="")
abline(lm(Happiness ~ year, data=otherbyYear), col="dodgerblue")
legend("bottomleft", legend=c("White", "Black", "Other"), col=c("blue", "forestgreen", "dodgerblue", lty=1, pch=20))
mtext("Figure 3. Scatter plot (with best-fitting regression lines) showing mean happiness scores
      for respondents identified as White, Black, or another race, from 1972 to 2008", 1, 4.25, cex = .6)
