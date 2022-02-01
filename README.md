# Aspartate_Racemase_Ligands_Bioactivity_Prediction
 This scripts tries to predict the bioactivity of 131 small molecule compounds (taken from ***ChEMBL***) related to ***Aspartate Racemase*** enzyme with the aid of ***MACCS166*** Chemical Fingerprints (from *Rcpi* package), the ***Decision Tree*** algorithm (from *rpart* package), and ***Support Vector Machines*** (from e1071 package).
 
# Installation
Make sure to have installed the following Bioconductor/CRAN/GitHub packages *Rcpi*, *rpart*, *dplyr*, *e1071*, *stringr* in your Rstudio IDE.

# About the dataset
The result of a simple search in ChEMBL (about Aspartate Racemase, small molecules filtered) were downloaded as SDF and TSV files. The bioactivities were extracted from the TSV file with the following criteria : `Bioactivity < 10 ==> High (H) , Bioactivity >= 10 ==> Low (L)` and later stored as *Bio2.csv* file. The SDF file was passed to galaxy server and via open babel, the corresponding smi files were retrieved and saved as *Smile_Files.smi*.

***Note:*** As one can observe, since the dataset is relatively small for such predictions, the change of seed or # of train data would significantly change the accuracy. 

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

