###Initialization
library(Rcpi)
library(rpart)
library(dplyr)
library(e1071)
library(stringr)

set.seed(93)

rsq = function(x,y){
  cor(x,y)*cor(x,y)
  }

###Import the chemicals
x=readMolFromSmi("Smile_Files.smi")

###Compute MACCS166 chemical fingerprints for the molecules
y=extractDrugMACCSComplete(x)

###Load Bioactivity data taken from ChEMBL
bio=read.table("Bio2.csv",header = T)

###Process NAs. Delete them from both data, bio(Bioactivity data) and y(MACCS166 matrix)
ind=which(is.na(bio))
bio=na.omit(bio)
y=as.data.frame(y)
y=y[-ind,]
y$bioactivity=(bio[,1])

###Take a look at the data used for the decision tree algorithm
head(y)
y
dim(y)

###Prepare test and train datasets
N=70 # N = amount of data used for training algorithm out of all data = dim(y)[1] = 124
sind=sample(1:(dim(y)[1]),70)
train=y[sind,]
test=y[-sind,]

###Take a look at train and test datasets
head(train)
head(test)
dim(train)
dim(test)

###Implement decision tree
tree=rpart((bioactivity)~.,train)
prd=predict(tree,test[,-167])
real=test[,167]

###Print the confusion matrix
res=table(predicted=round(prd),reality=real)
print(res)

###Accuracy = ?
cat(str_c("Accuracy is ",sum(diag(res))/sum(res),"\n"))



###Implement SVM
mod=svm(as.factor(bioactivity)~.,train,scale = F)
prd=predict(mod,test[,-167])
real=test[,167]

###Print the confusion matrix
res=table(predicted=prd,reality=real)
print(res)

###Accuracy = ?
cat(str_c("Accuracy is ",sum(diag(res))/sum(res),"\n"))

