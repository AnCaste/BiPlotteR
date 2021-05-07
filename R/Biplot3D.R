#' @title Biplot3D
#'
#' @description Generates an interactive three-dimensional biplot referred
#' to the first three principal components (PC).
#' The Biplot 3D function will automatically center the user's input data.
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
#' @param load.filter A numerical threshold ranging from 0 to 1. Only
#' features with loadings greater than the load.filter value will be shown in
#' the biplot. load.filter=0 is set as default (all features will be displayed).
#' @param mag.fact The amplification of loading vectors length can improve the
#' biplot intelligibility. Set "AUTO" if you want an automatic amplification to
#' be performed, otherwise specify an amplification factor value (e.g.
#' mag.fact=2). If no amplification is required, set mag.fact="NO". The latter
#' choice is set as default.
#'
#' @return The three-dimensional interactive biplot as a Plotly object.
#'
#' @import plotly
#'
#' @importFrom stats prcomp
#'
#' @examples
#' \dontrun{
#'
#' > Biplot3D(data,scaling="NO",load.filter=0.2,mag.fact=2)
#' # Here, a three-dimensional biplot is generated using centered data. Only
#' features having loadings greater than 0.2 will be displayed in the biplot.
#' In addition, loading vector length will be doubled in their length.
#'
#' }
#'
#' @export

Biplot3D=function(data,scaling="NO",load.filter=0,mag.fact="NO"){
  ncol=dim(data)[2]

  #Principal Component Analysis
  if (scaling=="YES"){
    PCs=prcomp(data[3:ncol],scale=TRUE)
  }else if (scaling=="NO"){
    PCs=prcomp(data[3:ncol],center=TRUE)
  }
  scores=data.frame(PCs[[5]])
  loadings=data.frame(PCs[[2]])
  m=dim(loadings)[1]

  #Calculation of Variance Explained by PC1, PC2 and PC3
  S=summary(PCs)
  Var=S[[1]]^2
  Var=Var/sum(Var)*100

  #Filtering The Loadings
  k=0
  for (i in 1:m){
    if (sqrt(loadings[i,1]^2+loadings[i,2]^2+loadings[i,3]^2)<load.filter){
      k=c(k,i)
    }
  }
  if (length(k)!=1){
    k=k[-1]
    loadings=loadings[-k,]
  }
  m=dim(loadings)[1]

  #Loadings Values Amplification
  m1=max(abs(scores$PC1))
  m2=max(abs(scores$PC2))
  m3=max(abs(scores$PC3))
  if (mag.fact=="AUTO"){
    mf=min(m1,m2,m3)
  }else if (mag.fact=="NO"){
    mf=1
  }else if (is.numeric(mag.fact)==TRUE){
    mf=mag.fact
  }
  loadings=loadings*mf

  #3D Biplot
  axx=list(range = c(-(m1+1),m1+1))
  axy=list(range = c(-(m2+1),m2+1))
  axz=list(range = c(-(m2+1),m2+1))

  #3D ScatterPlot
  fig <- plot_ly()
  fig <-fig %>% layout(scene = list(xaxis=axx,yaxis=axy,zaxis=axz))
  fig <- fig %>% add_trace(scores, x=scores[,1], y=scores[,2], z=scores[,3], color=data[[2]],
                           marker=list(size=5),
                           type="scatter3d", mode = "markers")
  V1=as.character(round(Var[[1]],digits=2))
  V2=as.character(round(Var[[2]],digits=2))
  V3=as.character(round(Var[[3]],digits=2))
  xtitle=paste("PC1 (",V1,"%)",sep="")
  ytitle=paste("PC2 (",V2,"%)",sep="")
  ztitle=paste("PC3 (",V3,"%)",sep="")
  fig <- fig %>% layout(scene = list(xaxis = list(title = xtitle),
                                     yaxis = list(title = ytitle),
                                     zaxis = list(title = ztitle)))
  n=length(data[[1]])

  #Generating Scores Annotations
  tl=list(showarrow = FALSE, #Template list
          x = 0,
          y = 0,
          z = 0,
          xanchor = "left",
          xshift = 4,
          yshift = 4,
          zshift = 0,
          opacity = 0.7,
          text = "",
          font = list(color = "black",size = 12))
  L=vector(mode = "list", length=n)
  for (i in 1:n){
    l=tl
    x=scores$PC1[i]
    y=scores$PC2[i]
    z=scores$PC3[i]
    text=as.character(data[[1]])[i]
    l[[2]]=x
    l[[3]]=y
    l[[4]]=z
    l[[10]]=text
    L[[i]]=l
  }

  #Generating Loadings Annotations
  tl=list(showarrow = FALSE, #Template list
          x = 0,
          y = 0,
          z = 0,
          xanchor = "left",
          xshift = 4,
          yshift = 4,
          zshift = 0,
          opacity = 0.7,
          text = "",
          font = list(color = "black",size = 10))
  for (i in 1:m){
    l=tl
    x=loadings$PC1[i]
    y=loadings$PC2[i]
    z=loadings$PC3[i]
    text=as.character(rownames(loadings))[i]
    l[[2]]=x
    l[[3]]=y
    l[[4]]=z
    l[[10]]=text
    L[[n+i]]=l
  }

  #Adding Overall Annotations
  fig <- fig %>% layout(scene = list(annotations=L))

  #Adding loadings to fig
  for (i in 1:m){
    x=c(0,loadings$PC1[i])
    y=c(0,loadings$PC2[i])
    z=c(0,loadings$PC3[i])
    fig <- fig %>%add_trace(x=x, y=y, z=z,
                            type="scatter3d", mode="lines",name=row.names(loadings)[i],
                            line = list(width=5),
                            opacity = 1,showlegend=FALSE)
  }
  return(fig)
}
