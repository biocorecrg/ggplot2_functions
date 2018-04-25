#### Dendrogram / hierarchical clustering ####

### Hierarchical clustering from matrix using ggplot2 ###
# data: compulsory; matrix: each column is a sample.
# title: optional; defaults to time stamp.
# groups: optional; vector that contains the name of the experimental groups (same order as in the columns of data).
# samples: optional; vector that contains the name of the samples for labeling the points; defaults to the column names of data.

dendro_ggplot <- function(data, title, groups, samples){

	# check if ggplot2 is installed; if not, install it
	list.of.packages <- c("ggplot2", "cowplots", "ggdendro", "DESeq2")
	new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
	if(length(new.packages)) install.packages(new.packages)
	
	# load ggplot2 and cowplots
	require(ggplot2); require(cowplots); require(ggdendro); require("DESeq2")

	# check if the data argument was passed: no input!
	if (missing(data))
		stop("Need to input a data argument (matrix or data frame)")

	# title defaults to time stamp
	if(missing(title)) title <- Sys.Date()

	# defaults will be the column names of the matrix
	if(missing(samples)) samples <- colnames(data)

	# if groups is not passed, set to NA: the plot will be modified accordingly.
	if(missing(groups)) groups <- NA
	
	# test if data is a matrix or a DESeq2 object; adjust accordingly
	if(is(data, "DESeqTransform")) data <- assay(data)
	if(is(data, "DESeqDataSet")) data <- assay(rlog(data))

	# dendrogram object
	dd.row <- as.dendrogram(hclust(dist(t(data))))
	ddata_x <- dendro_data(dd.row)
	
	# set y axis limits
	ymaxdendro <- max(ddata_x$segments$y)
	ylimits <- c(0-ymaxdendro/5, ymaxdendro)

	# add columns for samples and groups (if exists)
	
	df_colnames <- data.frame(col_names=colnames(data), samples=samples, groups=groups)

	labs <- label(ddata_x)
	labs <- merge(labs, df_colnames, by.x="label", by.y="col_names", all=T, sort=FALSE)

	p2 <- ggplot(segment(ddata_x)) +
	geom_segment(aes(x=x, y=y, xend=xend, yend=yend)) + 
	theme_minimal() + 
	ylim(ylimits) +
	ggtitle(paste("Hierarchical clustering / dendrogram", title))

	if(any(!is.na(groups))){
	p3 <- p2 + geom_text(data=label(ddata_x),
        aes(label=labs$label, x=x, y=0, colour=labs$groups), angle=90, hjust=1) + scale_colour_discrete(name="Experimental\nGroup")
	}else{
	p3 <- p2 + geom_text(data=label(ddata_x),
        aes(label=labs$label, x=x, y=0), angle=90, hjust=1)
	}

	# adapt size of file according to number of samples
	pdf_width <- ifelse(ncol(data) <= 10, 7, ifelse(ncol(data) <= 30, 9, ifelse(ncol(data) <= 50, 12, ifelse(ncol(data) <= 80, 14, 20))))

	# save plot in pdf format
	pdf(paste0("Dendrogram_", gsub(" ", "_", title), ".pdf"), height=7, width=pdf_width)
		print(p3)
	dev.off()

}

