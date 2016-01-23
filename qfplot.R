library(ggplot2) # by Hadley Wickham
library(grid) # Required for the special axes.

qfplot <- function(x,y,...) {
	# We use margins for a cleaner graph.
	# They are calculated as 5% of the range.
	# Feel free to play around with these (10% works well too).
	y.margin <- 0.05 * (max(y)-min(y))
	x.margin <- 0.05 * (max(x)-min(x))
	# They will be important now and a little bit later.
	p <- qplot(x=X, y=Y, data = data.frame(X=x,Y=y)) +
		coord_cartesian(xlim = range(x)+c(-x.margin,x.margin),
						ylim = range(y)+c(-y.margin,y.margin))
	# Right now we have a ggplot object 'p' to work with.
	# We add optional parameters if the user specified them:
	z <- list(...)
	if ( !is.null(z$xlab) ) p <- p + xlab(z$xlab)
	if ( !is.null(z$ylab) ) p <- p + ylab(z$ylab)
	if ( !is.null(z$main) ) p <- p + ggtitle(z$main)
	# P.S. You're free to add your own ggplot2-supported parameters (i.e. aes color, etc.)
	# The idea is to replace the basic, default axes with ones which convey information.
	# Specifically, the information we want to convey is the quartile information.
	qy <- as.numeric(quantile(y))
	qx <- as.numeric(quantile(x))
	p <- p + theme_bw() + scale_x_continuous(limits=range(x),
						 breaks=qx,
						 labels=round(qx,1)) +
						 scale_y_continuous(limits=range(y),
								    breaks=qy,
								    labels=round(qy,1))
	# We now specify various options. Serif is the default font family but the user can specify otherwise.
	p <- p + theme(axis.line = element_line(colour="transparent",size=1,linetype=1),
				  axis.title.y = element_text(family=ifelse(!is.null(z$font.family),z$font.family,"serif"),
				  						  face = "plain", colour = "black",
				  						  size = 14, hjust = 0.5, vjust = 0.4, angle = 90,
				  						  lineheight = 1.2),
				  axis.title.x = element_text(family=ifelse(!is.null(z$font.family),z$font.family,"serif"),
				  						  face = "plain", colour = "black",
				  						  size = 14, hjust = 0.5, vjust = 0.5, angle = 0,
				  						  lineheight = 1.2),
				  axis.text.y = element_text(family=ifelse(!is.null(z$font.family),z$font.family,"serif"),
				  						 face = "plain", colour = "black",
				  						 size = 14, hjust = 0.5, vjust = 0.5, angle = 0,
				  						 lineheight = 1.2),
				  axis.text.x = element_text(family=ifelse(!is.null(z$font.family),z$font.family,"serif"),
				  						 face = "plain", colour = "black",
				  						 size = 14, hjust = 0.5, vjust = 0.5, angle = 0,
				  						 lineheight = 1.2),
				  plot.title = element_text(family=ifelse(!is.null(z$font.family),z$font.family,"serif"),
				  						face = "plain", colour = "black",
				  						size = 18, hjust = 0.5, vjust = 0.5, angle = 0,
				  						lineheight = 1.2),
				  panel.grid.major = element_blank(), # get rid of the guides
				  panel.grid.minor = element_blank(), # get rid of the guides
				  panel.border = element_rect(linetype = 0)) # get rid of the outside frame
	# We wish to have a custom axis that essentially acts as a quartile plot.
	# We have to calculate appropriate line segment endpoints
	# knowing that 100% = max(var) + margin, 0% = min(var) - margin
	# so a particular endpoint = (quantile-(min-margin)) / ((max+margin)-(min-margin))
	qy <- (qy-qy[1]+y.margin)/(qy[5]-qy[1]+2*y.margin)
	qx <- (qx-qx[1]+x.margin)/(qx[5]-qx[1]+2*x.margin)
	# Now comes the fun part of using the grid package and do some raw grob editing!
	ggrob <- ggplotGrob(p)
	idxL <- which(ggrob$layout$name == "axis-l")
	idxB <- which(ggrob$layout$name == "axis-b")
	ggrob$grobs[[idxL]]$children[[1]] <- segmentsGrob(gp=gpar(col=c("gray","black","gray"),lwd=2),
													 y0=unit(c(qy[1],qy[2],qy[4]),"npc"),
													 y1=unit(c(qy[2],qy[4],qy[5]),"npc"),
													 x0=unit(c(0.95,0.975,0.95),"npc"),
													 x1=unit(c(0.95,0.975,0.95),"npc"))
	ggrob$grobs[[idxB]]$children[[1]] <- segmentsGrob(gp=gpar(col=c("gray","black","gray"),lwd=2),
													  x0=unit(c(qx[1],qx[2],qx[4]),"npc"),
													  x1=unit(c(qx[2],qx[4],qx[5]),"npc"),
													  y0=unit(c(1,1.05,1),"npc"),
													  y1=unit(c(1,1.05,1),"npc"))
	# So let's finally get the plot, shall we?
	grid.newpage() # Without this we just draw on top of whatever was drawn before.
	grid.draw(ggrob) # Congratulations on your sweet new Tuftian scatterplot!
}
