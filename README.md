# Functions for diverse plots useful for HTS data analysis, using ggplot2

## Principal component analysis

### source function "pca_ggplot"

```
source("pca.R")
```

### arguments
#### **data**: compulsory; data frame: each column is a sample.
#### **title**: optional; defaults to time stamp.

### create example matrix

```
dat <- matrix(rnorm(1200), ncol=6)
colnames(dat) <- paste0("sample", 1:6)
```

### test function

```
pca_ggplot(dat, first_pc=1, second_pc=3, samples=1:6, groups=c(rep("one", 3), rep("two", 3)), title="my first PCA")
```


## Density plot

### source function "density_ggplot"

```
source("density.R")
```

### arguments
#### **data**: compulsory; a matrix
#### **title**: optional; will be used to construct the main title of the plot and the name of the file; defaults to time stamp
#### **first_pc**, **second_pc**; optional: which components do you want to plot. first will go to the x axis, second will go to the y axis; defaults to 1 and 2, respectively.
#### **groups**: optional; vector that contains the name of the experimental groups (same order as in the columns of data).
#### **samples**: optional; vector that contains the name of the samples for labeling the points; defaults to the column names of data.

### create example data frame

```
df <- data.frame(sample1=rnorm(1000), sample2=rnorm(1000))
```

### test function

```
density_ggplot(df, title="test")
```
