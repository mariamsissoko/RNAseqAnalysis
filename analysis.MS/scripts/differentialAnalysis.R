#Rscript for differential analysis 

library(DESeq2)

# DESeqDataSet object creation
dir="/home/mariam/Documents/countFiles"
HTSeqCountFiles = c("ERR990557s.count.txt", "ERR990558s.count.txt", "ERR990559s.count.txt", "ERR990560s.count.txt")
stages = c("1", "2","2","2") 
samples = c("ERR990557", "ERR990558", "ERR990559", "ERR990560") 
samplesTable = data.frame(sampleName=samples, fileName=HTSeqCountFiles, condition=stages) 
dds = DESeqDataSetFromHTSeqCount(sampleTable=samplesTable, directory=dir, design= ~ condition)

# normalization of counts

# calculation of sizeFactors
dds = estimateSizeFactors(dds)
sizeFactors(dds)

# bar plots
barplot(colSums(counts(dds)),main='number of reads mapped on genes for each experiment')

# boxplots
boxplot(log2(counts(dds)+1),main='Barplot which represent logfc dispersion for each experiment\nbefore normalization')
boxplot(log2(counts(dds,normalized=TRUE)+1),main='Barplot which represent logfc dispersion for each experiment\nafter normalization')

# variance estimations
dds = estimateDispersions(dds)
plotDispEsts(dds,main='Representation of variance')

# differential analysis
dds = nbinomWaldTest(dds)
res = results(dds)

# diagnostic plots

# MA plot
plotMA(res,main='MA plot for differential analysis')

# Histogram of the p values
hist(res$pvalue,main='distribution of p-values',breaks=20,col="grey")
hist(res$padj,main='distribution of adjusted p-values',breaks=20,col="blue")

# selection of the genes with an adjusted p-value<0.01
ind=which(res$padj<0.01)
res=as.matrix(res)
print(res)
res = res[ind,]
write.table(res, "resultOfDifferentialAnalysis.txt", row.name=T, quote=F, sep='\t')
