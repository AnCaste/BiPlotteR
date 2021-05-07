#' @title ScreePlot
#'
#' @description Generates an interactive two-dimensional bar chart. The height
#' of each bar shows the variance explained by the corresponding principal
#' component.
#'
#' @param data A data frame containing the data matrix. The data frame  has to
#' have the same structure of the input data frame of Biplot3D and Biplot 2D
#' functions. See Biplot3D and Biplot 2D help pages for further details.
#' @param scaling Do you wish to scale your data prior to PC calculation?
#' Set "YES" if you do; otherwise set "NO". The latter choice is set as default.
#'
#' @return An interactive screeplot bar chart as a Plotly object.
#'
#' @import plotly
#'
#' @importFrom stats prcomp
#'
#' @examples
#' \dontrun{
#'
#' > ScreePlot(data,scaling="NO")
#' # Here, a screeplot bar chart is generated after performing the Principal
#' Component Analysis (PCA) on centered data.
#'
#' }
#'
#' @export

ScreePlot=function(data,scaling="NO"){
  ncol=dim(data)[2]
  #Principal Component Analysis
  if (scaling=="YES"){
    PCs=prcomp(data[3:ncol],scale=TRUE)
  }else if (scaling=="NO"){
    PCs=prcomp(data[3:ncol],center=TRUE)
  }
  S=summary(PCs)
  Var=S[[1]]^2
  Var=Var/sum(Var)*100
  Var=as.character(Var)
  SP=plot_ly(y=Var,x=colnames(S[[6]]), histfunc='sum', type = "histogram",name="Scree Plot",
             marker = list(color = "rgba(0, 0, 255, 0.7)"))
  SP=SP%>%layout(yaxis=list(title="Explained Variance (%)",type='linear'),
                 xaxis=list(title="Principal Components",categoryorder = "array",
                            categoryarray = colnames(S[[6]])),bargap=0.6)
  return(SP)
}
