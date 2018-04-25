# Functions for plots useful in HTS data analysis, using [ggplot2](http://ggplot2.org/) R package


## What is done and what is pending

- [x] PCA from a matrix or a DESeq2 object
- [x] Density plot from a data frame or a matrix
- [x] Hierarchical clustering from a matrix or a DESeq2 object
- [x] Dotplot for counts / gene from a matrix or a DESeq2 object
- [ ] Heatmap from a matrix or a DESeq2 object


## Principal component analysis

### source function "pca_ggplot"

```
source("functions/pca.R")
```

### arguments

**data**: compulsory; object of class matrix OR DESeqTransform OR DESeqDataSet: each column is a sample.<br>
**title**: optional; will be used to construct the main title of the plot and the name of the file; defaults to time stamp.<br>
**first_pc**, **second_pc**; optional: which components do you want to plot. first will go to the x axis, second will go to the y axis; defaults to 1 and 2, respectively.<br>
**groups**: optional; vector that contains the name of the experimental groups (same order as in the columns of data).<br>
**samples**: optional; vector that contains the name of the samples for labeling the points; defaults to the column names of data.<br>

### create an example matrix and test the function

```
dat <- matrix(rnorm(1200), ncol=6)
colnames(dat) <- paste0("sample", 1:6)

pca_ggplot(dat, first_pc=1, second_pc=3, 
	samples=1:6, groups=c(rep("one", 3), rep("two", 3)), 
	title="my first PCA")
```



## Density plot

### source function "density_ggplot"

```
source("functions/density.R")
```

### arguments

**data**: compulsory; object of class data.frame or matrix: each column is a sample<br>
**title**: optional; will be used to construct the main title of the plot and the name of the file; defaults to time stamp.<br>


### create an example data frame and test the function

```
df <- data.frame(sample1=rnorm(1000), 
	sample2=rnorm(1000),
	sample3=rnorm(1000))

density_ggplot(df, 
	title="test")
```

## Hierarchical clustering / dendrogram

### source function "dendro_ggplot"

```
source("functions/dendrogram.R")
```

### arguments

**data**: compulsory; object of class matrix OR DESeqTransform OR DESeqDataSet: each column is a sample.<br>
**title**: optional; will be used to construct the main title of the plot and the name of the file; defaults to time stamp.<br>
**groups**: optional; vector that contains the name of the experimental groups (same order as in the columns of data).<br>
**samples**: optional; vector that contains the name of the samples for labeling the points; defaults to the column names of data.<br>

### create an example matrix and test the function

```
dat <- matrix(rnorm(120000), ncol=60)
colnames(dat) <- paste0("sample", 1:60)

dendro_ggplot(dat, 
	title="my first Dendrogram",
	groups=c(rep("one", 15), rep("two", 20), rep("three", 25)))
```

## Dot plots

```
source("functions/dotplot_genes_counts.R")
```

### arguments

**data**: compulsory; object of class matrix: each column is a sample. Row names should be gene names!<br>
**genes**: compulsory; vector of gene names (should be found in row names of data).<br>
**title**: optional; defaults to time stamp.<br>
**groups**: optional; vector that contains the name of the experimental groups (same order as in the columns of data).<br>
**samples**: optional; vector that contains the name of the samples for labeling the points; defaults to the column names of data.<br>

### create an example matrix and test the function

```
dat <- matrix(rnorm(120000), ncol=20, 
	dimnames=list(paste0("gene", 1:6000), paste0("sample", 1:20)))

dotplot_genes_ggplot(dat, 
	genes=c("gene2030", "gene140", "gene850"),
	title="my first dot plot",
	groups=c(rep("one", 6), rep("two", 7), rep("three", 7)))
```




