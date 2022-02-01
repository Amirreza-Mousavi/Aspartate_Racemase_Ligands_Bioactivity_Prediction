library(Rcpi)
rsq = function(x,y){cor(x,y)*cor(x,y)}
Jaccardindex=function(A,B){
  int=table(A&B)[2]
  return(as.numeric(int/(length(A)+length(B)-int)))
  
}
x=readMolFromSmi("Galaxy18-[Convert_to_smi_from_data_16].smi")

y=extractDrugMACCSComplete(x)

###Load Bioactivity
bio=read.table("Bio2.csv",header = T)
ind=which(is.na(bio))
bio=na.omit(bio)
library(dplyr)
y=as.data.frame(y)
y=y[-ind,]
y$bioactivity=(bio[,1])
y
###############
library(rpart)
dim(y)
set.seed(11)
sind=sample(1:124,70)
train=y[sind,]
test=y[-sind,]
dim(train)
dim(test)
#################
library(e1071)
tree=rpart((bioactivity)~.,train)
prd=predict(tree,test[,-167])

real=test[,167]
prd=(prd)
real

table(predicted=round(prd),reality=real)

