\name{ortho.AIC}
\alias{ortho.AIC}
\title{ Function to compute AIC in the case of orthogonal explanatory variables. }
\description{
  This function compute corrected AIC for models with orthonormal and centered explanatory variables. Variables are sorted by their contribution to R2.
  It ensures that a model with k variables is the best one that can be obtained. By default, response variables are centered (model with intercept).
}
\usage{
ortho.AIC(Y, X, ord.var = FALSE)
}

\arguments{
  \item{Y}{ A matrix with response variables (univariate or multivariate response). }
  \item{X}{ A set of orthonormal and centered vectors. }
  \item{ord.var}{ A logical value indicating if the order of variables and cumulative R2 must be returned.}
}
\details{
  See the reference for the multivariate extension of corrected AIC. 
}
\value{
  A vector with corrected AIC if ord.var=FALSE. A list if ord.var=TRUE with:
  
  \item{AICc }{Values of corrected AIC.}
  \item{AICc0 }{Values of corrected AIC for the null model (only intercept).}
  \item{ord }{Order of variables to be enter in the model}
  \item{R2 }{Cumulative R2}
}
\references{ Godinez-Dominguez E. and Freire J. (2003) Information-theoretic approach for selection of spatial and temporal models of community organization. \emph{Marine Ecology - Progress Series} \bold{253}, 17--24.

 }
\author{ Stephane Dray }

\examples{
y <- matrix(rnorm(50),50,1)
x <- svd(scale(y \%*\% c(0.1,0.5,2,0,0.7)+matrix(rnorm(250),50,5)))$u
res <- ortho.AIC(y,x,ord.var=TRUE)
minAIC <- which.min(res$AICc)
nvar <- length(1:minAIC)+1 # number of orthogonal vectors + 1 for intercept
lm1 <- lm(y~x[,res$ord[1:minAIC]])
summary(lm1)$r.squared # R2
res$R2[minAIC] # the same

min(res$AICc) # corrected AIC
extractAIC(lm1) # classical AIC 
min(res$AICc)-2*(nvar*(nvar+1))/(nrow(x)-nvar-1) # the same

lm2 <- lm(y~1)

res$AICc0 # corrected AIC for the null model
extractAIC(lm2) # classical AIC 
res$AICc0-2*(1*(1+1))/(nrow(x)-1-1) # the same

}
\keyword{ models }
