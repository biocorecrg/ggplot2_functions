#### Functions for diverse plots using ggplot2 ####

### PCA ###

pca_ggplot <- function(data, title, first_pc, second_pc, groups, samples){

	# check if the data argument was passed: no input!
	if (missing(data))
		stop("Need to input a data argument (matrix)")
	if(!is.matrix(data))
		stop("data should be a matrix")

	# Performs principal component analysis on data
	pca <- prcomp(t(data))
	# Retrieve the percentages of variation for each component
	percentVar <- pca$sdev^2 / sum( pca$sdev^2 )

	# check if optional arguments are missing: set defaults if they are

	if(missing(title)){
		# title defaults to time stamp
		title <- Sys.Date()
	}

	if(missing(first_pc) | missing(second_pc)){
		first_pc <- 1
		second_pc <- 2
	}

	if(missing(samples)){
		# defaults will be the column names of the matrix
		samples <- colnames(data) 
	}

	if(missing(groups)){
		# if groups is not passed, set to NA: the plot will be modified accordingly.
		groups <- NA
	}

	# Create data frame with principal components (elected or default), sample and group information; Create fist plot layer with or without "groups"

	if(any(is.na(groups))){
		d <- data.frame(PC1=pca$x[,first_pc], PC2=pca$x[,second_pc], sample=samples)
		p <- ggplot(data=d, aes(x=PC1, y=PC2, label=sample))
	}else{
		d <- data.frame(PC1=pca$x[,first_pc], PC2=pca$x[,second_pc], group=groups, sample=samples)
		p <- ggplot(data=d, aes(x=PC1, y=PC2, color=group, label=sample))
	}

	# set x limits to allow space for the labels
	xlimits <- c(min(d$PC1)+0.2*min(d$PC1), max(d$PC1)+0.2*max(d$PC1))
	
	# plot
	p2 <- p + geom_point(size=3) +
	theme_bw() +
	xlab(paste0("PC:",first_pc," ", round(percentVar[first_pc] * 100),"% variance")) +
	ylab(paste0("PC:",second_pc," ", round(percentVar[second_pc] * 100),"% variance")) +
	ggtitle(paste("PCA", title)) +
	geom_text(size=5, hjust=-0.1) +
	xlim(xlimits)

	# save plot in pdf format
	pdf(paste0("PCA_", gsub(" ", "_", title), ".pdf"), height=7, width=9)
		print(p2)
	dev.off()
}

# create example matrix
dat <- matrix(rnorm(1200), ncol=6)
colnames(dat) <- paste0("sample", 1:6)
# test function
pca_ggplot(dat, first_pc=1, second_pc=3, samples=1:6, groups=c(rep("one", 3), rep("two", 3)), title="tt")



### Density plot ###

library(ggplot2)
# just loading this library formats the ggplots in a publishing friendly format
library(cowplots) 

# build data frame:

df <- data.frame(counts=rnorm(1000))

# get maximum x coordinate at peak of density plot (we will add a vertical line to the plot):
maxdens <- which.max(density(df$counts)$y)
xmaxdens <- density(df$counts)$x[maxdens]

# plot
ggplot(df, aes(df$counts)) + geom_density() + geom_vline(xintercept=xmaxdens, col="red")

# dendrogram

# boxplot

# volcano plot

# scatter plot

# heatmap

# venn diagram


