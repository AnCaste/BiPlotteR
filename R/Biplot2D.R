#' @title Biplot2D
#'
#' @description Generates an interactive three-dimensional biplot referred
#' to the two principal components (PC) indicated by the user.
#' The Biplot 2D function will automatically center the user's input data.
#' However, data can be scaled to have unit variance before performing
#' the Principal Component Analysis (PCA).
#'
#' @param data A data frame containing the data matrix.
#' The input data frame has to be created following a precise structure.
#' Specifically, the dataset has to be generated in R-mode, i.e. showing variables
#' (features) in columns and samples (objects) in rows.
#' Additionally, the first column should contain all the sample annotations
#' (e.g. sample name, sample number, etc.), which will be displayed next to each
#' point in the biplot. Furthermore, the second column has to be filled with
#' parameters (e.g., types, species, treatments, etc.) useful for samples
#' classification into groups. In this way, all the points referring to
#' samples sharing the same properties will have the same color in the
#' biplot. Variable values are listed starting from the third column
#' onwards. Here, column headers should contain the name of the related feature.
#' These names will be displayed next to the corresponding loading vector in the
#' biplot.
#' @param scaling Do you wish to scale your data prior to PC calculation?
#' Set "YES" if you do; otherwise set "NO". The latter choice is set as default.
#' @param PCx A numeric value indicating which principal component will be
#' displayed on the x axis (e.g. 1 for PC1, 2 for PC2, 3 for PC3, etc.)
#' @param PCy A numeric value indicating which principal component will be
#' displayed on the y axis (e.g. 1 for PC1, 2 for PC2, 3 for PC3, etc.)
#' @param load.filter A numerical threshold ranging from 0 to 1. Only
#' features with loadings greater than the load.filter value will be shown in
#' the biplot. load.filter=0 is set as default (all features will be displayed).
#' @param mag.fact The amplification of loading vectors length can improve the
#' biplot intelligibility. Set "AUTO" if you want an automatic amplification to
#' be performed, otherwise specify an amplification factor value (e.g.
#' mag.fact=2). If no amplification is required, set mag.fact="NO". The latter
#' choice is set as default.
#'
#' @return The two-dimensional interactive biplot as a Plotly object.
#'
#' @import plotly
#'
#' @importFrom stats prcomp
#'
#' @examples
#' \dontrun{
#'
#' > Biplot2D(data,scaling="YES",PCx=2,PCy=3,load.filter=0,mag.fact="AUTO")
#' # Here, a two-dimensional biplot is generated using scaled data. PC2 values
#' will be shown on the x axis, while PC3 values will be displayed on the y axis.
#' No loading filter will be applied (i.e. all the variable loadings will be
#' displayed in the biplot) and the loading vectors will be automatically
#' amplified.
#'
#' }
#'
#' @export

Biplot2D=function(data,scaling="NO",PCx=1,PCy=2,load.filter=0,mag.fact="NO"){
  ncol=dim(data)[2]
  #Principal Component Analysis
  if (scaling=="YES"){
    PCs=prcomp(data[3:ncol],scale=TRUE)
  }else if (scaling=="NO"){
    PCs=prcomp(data[3:ncol],center=TRUE)
  }
  scores=data.frame(PCs[[5]])
  loadings=data.frame(PCs[[2]])

  #Calculation of Variance Explained by PC1, PC2 and PC3
  S=summary(PCs)
  Var=S[[1]]^2
  Var=Var/sum(Var)*100

  # Filter loadings
  m=dim(loadings)[1]
  k=0
  for (i in 1:m){
    if (sqrt(loadings[i,PCx]^2+loadings[i,PCy]^2)<load.filter){
      k=c(k,i)
    }
  }
  if (length(k)!=1){
    k=k[-1]
    loadings=loadings[-k,]
  }
  m=dim(loadings)[1]

  #Loadings value amplification
  m1=max(abs(scores[[PCx]]))
  m2=max(abs(scores[[PCy]]))
  if (mag.fact=="AUTO"){
    mf=min(m1,m2)
  }else if (mag.fact=="NO"){
    mf=1
  }else if (is.numeric(mag.fact)==TRUE){
    mf=mag.fact
  }
  loadings=loadings*mf

  #2D Biplot
  mx=max(abs(scores[[PCx]]))
  my=max(abs(scores[[PCy]]))
  fig <- plot_ly()
  Vx=as.character(round(Var[[PCx]],digits=2))
  Vy=as.character(round(Var[[PCy]],digits=2))
  xtitle=paste("PC",as.character(PCx)," (",Vx,"%)",sep="")
  ytitle=paste("PC",as.character(PCy)," (",Vy,"%)",sep="")
  fig <- fig %>% layout(xaxis = list(title=xtitle),
                        yaxis = list(title=ytitle))
  fig <- fig %>% layout(xaxis = list(range = c(-mx-1,mx+1)),
                        yaxis = list(range = c(-my-1,my+1)))
  fig <- fig %>% add_trace(x = scores[[PCx]], y = scores[[PCy]], mode="markers",
                           type = "scatter", color = data[[2]])
  m=dim(loadings)[1]
  for (i in 1:m){
    x=c(0,loadings[[PCx]][i])
    y=c(0,loadings[[PCy]][i])
    fig <- fig %>% add_trace(x = x, y = y,
                             mode="lines",type = "scatter",showlegend=FALSE)
  }
  fig <- fig %>% add_annotations(x=scores[[PCx]],
                                 y=scores[[PCy]],
                                 text=data[[1]],
                                 showarrow = FALSE,
                                 xanchor = "center",
                                 xshift = 0,
                                 yshift = 10)
  fig <- fig %>% add_annotations(x=loadings[[PCx]],
                                 y=loadings[[PCy]],
                                 text=row.names(loadings),
                                 showarrow = FALSE,
                                 xanchor = "left",
                                 xshift = 1,
                                 yshift = 4)
  return(fig)
}
