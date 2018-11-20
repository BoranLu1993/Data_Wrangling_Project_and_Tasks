#install.packages("Hmisc")
#install.packages("SASxport")
library(SASxport)
data <- read.xport("C:/Users/blv/Desktop/Course/Fall2018/QBS181/midterm/DIQ_I.xpt")
write.csv(data,file="data111.csv")
DIAB<- data[data$DIQ010==1,] #people get diabetes

#In my perspective, I do not change any NA to 0, mean, or median. The reasons that I want to
#address are some NA's could not be impute such as for DID040, I only have the date which 
#people who develop diabetes and others were NA's. Thus, those NA's were seperate from the 
#meanful data which people who develop diabetes, people who do not develop diabetes were assigned
#as NA's and there is no real meaning to convert those NA's into other value. 
#DID040
#omit 999 because 999 is not actual value in the data set
a <- DIAB$DID040[DIAB$DID040 != 999]
#assign 0.5 to 666 because mean age less than 1 is about 0.5
a[a==666] <- 0.5 
summary(a)

data$DID040[is.na(data$DID040[data$DIQ010==1])] <- 48.4
#assign mean 48.4 to null in DIQ010==1 which is people who develop diabetes
data$DID040[data$DID040==999] <- 48.4
#assign mean 48.4 to 999 which is don't know
data$DID040[data$DID040==666] <- 0.5
#assign 0.5 to 666 because mean age less than 1 is about 0.5
summary(data$DID040)
data1$DID040[is.na(data1$DID040)] <- 0

#conver all categorical variables to factor so that it would convert to correct data type and value compared with website
#omit 999 or 9999 because 999 or 9999 is not actual value in the data set
#set 5555,6666,or 7777 to NA because I treat refused as NA and the amoung of refused is small, so it would not affect the result too much
#replace 999 or 9999 with the predicted mean which I predicted for each variable

#DIQ160
data$DIQ160 <- as.factor(data$DIQ160)
summary(data$DIQ160)

#DIQ170
data$DIQ170 <- as.factor(data$DIQ170)
summary(data$DIQ170)

#DIQ172
data$DIQ172 <- as.factor(data$DIQ172)
summary(data$DIQ172)

#DIQ175A
data$DIQ175A <- as.factor(data$DIQ175A)
summary(data$DIQ175A)

#DIQ175B
data$DIQ175B <- as.factor(data$DIQ175B)
summary(data$DIQ175B)

#DIQ175C
data$DIQ175C <- as.factor(data$DIQ175C)
summary(data$DIQ175C)

#DIQ175D
data$DIQ175D <- as.factor(data$DIQ175D)
summary(data$DIQ175D)

#DIQ175E
data$DIQ175E <- as.factor(data$DIQ175E)
summary(data$DIQ175E)

#DIQ175F
data$DIQ175F <- as.factor(data$DIQ175F)
summary(data$DIQ175F)

#DIQ175G
data$DIQ175G <- as.factor(data$DIQ175G)
summary(data$DIQ175G)

#DIQ175H
data$DIQ175H <- as.factor(data$DIQ175H)
summary(data$DIQ175H)

#DIQ175I
data$DIQ175I <- as.factor(data$DIQ175I)
summary(data$DIQ175I)

#DIQ175J
data$DIQ175J <- as.factor(data$DIQ175J)
summary(data$DIQ175J)

#DIQ175K
data$DIQ175K <- as.factor(data$DIQ175K)
summary(data$DIQ175K)

#DIQ175L
data$DIQ175L <- as.factor(data$DIQ175L)
summary(data$DIQ175L)

#DIQ175M
data$DIQ175M <- as.factor(data$DIQ175M)
summary(data$DIQ175M)

#DIQ175N
data$DIQ175N <- as.factor(data$DIQ175N)
summary(data$DIQ175N)

#DIQ175O
data$DIQ175O <- as.factor(data$DIQ175O)
summary(data$DIQ175O)

#DIQ175P
data$DIQ175P <- as.factor(data$DIQ175P)
summary(data$DIQ175P)

#DIQ175Q
data$DIQ175Q <- as.factor(data$DIQ175Q)
summary(data$DIQ175Q)

#DIQ175R
data$DIQ175R <- as.factor(data$DIQ175R)
summary(data$DIQ175R)

#DIQ175S
data$DIQ175S <- as.factor(data$DIQ175S)
summary(data$DIQ175S)

#DIQ175T
data$DIQ175T <- as.factor(data$DIQ175T)
summary(data$DIQ175T)

#DIQ175U
data$DIQ175U <- as.factor(data$DIQ175U)
summary(data$DIQ175U)

#DIQ175V
data$DIQ175V <- as.factor(data$DIQ175V)
summary(data$DIQ175V)

#DIQ175W
data$DIQ175W <- as.factor(data$DIQ175W)
summary(data$DIQ175W)

#DIQ175X
data$DIQ175X <- as.factor(data$DIQ175X)
summary(data$DIQ175X)

#DIQ180
data$DIQ180 <- as.factor(data$DIQ180)
summary(data$DIQ180)

#DIQ050
#count each number for taking insulin or not.
data$DIQ050 <- as.factor(data$DIQ050)
summary(data$DIQ050)

#DIQ060U
#convert year to month which use 12 to replace 2
data$DIQ060U[data$DIQ060U==2] <- 12

#DID060
#convert 666 which is year less than 1 year to 0.5 which represents the mean for the time period
data$DID060[data$DID060==666] <- 0.5
d <- data$DID060*data$DIQ060U
summary(d)
#replace 999 with the predicted mean 102.3
data$DID060[data$DID060==999] <- 102.3

#DID070
data$DIQ070 <- as.factor(data$DIQ070)
summary(data$DIQ070)

#DIQ230
#set 5 which is never to 0 to make more sence
data$DIQ230[data$DIQ230==5] <- 0
#set "Never" to 0 so that the result of summary is in order
data$DIQ230 <- as.factor(data$DIQ230)
summary(data$DIQ230)

#DIQ240
data$DIQ240 <- as.factor(data$DIQ240)
summary(data$DIQ240)

#DID250
e <- data$DID250[data$DID250!= 9999]
summary(e)
data$DID250[data$DID250 == 9999] <- 4.508
summary(data$DID250)

#DID260
summary(data$DID260)

#DIQ260U
#convert all days, weeks, months, anf years to years
f <- data$DIQ260U
f[f==1] <- 365
f[f==2] <- 52.1
f[f==3] <- 12
f[f==4] <- 1
g <- data$DID260*f
#multiply DIQ260U and DID260
summary(g)
data$DID260 <- g
#store the valutes in DID260

#DIQ275
data$DIQ275 <- as.factor(data$DIQ275)
summary(data$DIQ275)

#DIQ280
h <- data$DIQ280[data$DIQ280 != 999]
h[h==777] <- NA
summary(h)
data$DIQ280[data$DIQ280 == 999] <- 7.334
data$DIQ280[data$DIQ280 == 777] <- NA
summary(data$DIQ280)

#DIQ291
data$DIQ291 <- as.factor(data$DIQ291)
summary(data$DIQ291)

#DIQ300S
i <- data$DIQ300S[data$DIQ300S != 9999]
i[i==7777] <- NA
summary(i)
data$DIQ300S[data$DIQ300S == 9999] <- 130.5
summary(data$DIQ300S)

#DIQ300D
j <- data$DIQ300D[data$DIQ300D != 9999]
j[j==7777] <- NA
summary(j)
data$DIQ300D[data$DIQ300D == 9999] <- 78.23
summary(data$DIQ300D)

#DID310S
k <- data$DID310S[data$DID310S != 9999]
k[k==6666] <- NA
k[k==7777] <- NA
summary(k)
data$DID310S[data$DID310S == 9999] <- 123.1
summary(data$DID310S)

#DID310D
l <- data$DID310D[data$DID310D != 9999]
l[l==6666] <- NA
l[l==7777] <- NA
summary(l)
data$DID310D[data$DID310D == 9999] <- 76.78
summary(data$DID310D)

#DID320
m <- data$DID320[data$DID320 != 9999]
m[m==5555] <- NA
m[m==6666] <- NA
m[m==7777] <- NA
summary(m)
data$DID320[data$DID320 == 9999] <- 123

#DID330
n <- data$DID330[data$DID330 != 9999]
n[n==6666] <- NA
n[n==7777] <- NA
summary(n)
data$DID330[data$DID330 == 9999] <- 116.2

#DID341
o <- data$DID341[data$DID341 != 9999]
o[o==7777] <- NA
summary(o)
data$DID341[data$DID341 == 9999] <- 2.404

#DID350
summary(data$DID350)

#DIQ350U
q <- data$DIQ350U
q[q==1] <- 365
q[q==2] <- 52.1
q[q==3] <- 12
q[q==4] <- 1
r <- data$DID350*q
summary(r)
data$DID350 <- r

#DIQ360
data$DIQ360[data$DIQ360==5] <- 0
data$DIQ360 <- as.factor(data$DIQ360)
summary(data$DIQ360)

#DIQ080
data$DIQ080 <- as.factor(data$DIQ080)
summary(data$DIQ080)

colnames(data)<-c('Repseqnum','Dtolddiab','Agediabe','Prediabetes',
                   'Healthrisk','Feelatrisk','Familyhis','Overweight',
                   'Age','Poordiet','Race','Babyover9lbs','Lackphyact',
                   'HBP','HBS','HC','Hypo','Exhunger','Tingling',
                   'Bluvision','Infatigue','Anyoneatrisk','Drwarn','Other','Gesdiab',
                   'Frequri','Thirst','Cravsweet','Medi','POS',
                   'Bloodtest','Insulin','Insulintime','Unitinsulintime',
                   'Diapill','Diaspec','Drsee','Drtime','Checkblood',
                   'Unitcheckblood','DrcheckA1C','LastA1C','DrA1C','SBP','DBP',
                   'DrSBP','DrDBP','LDL','DrLDL','Drcheckfeet','Checkfeet',
                   'Unitcheckfeet','Pupils','Diabeyes')
write.csv(data,file="finaldata.csv")