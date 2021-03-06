% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mvQuad.R
\name{createNIGrid}
\alias{createNIGrid}
\title{creates a grid for numerical integration.}
\usage{
createNIGrid(dim = NULL, type = NULL, level = NULL,
  ndConstruction = "product", level.trans = NULL)
}
\arguments{
\item{dim}{number of dimensions}

\item{type}{quadrature rule (see Details)}

\item{level}{accuracy level (typically number of grid points for the underlying 1D quadrature rule)}

\item{ndConstruction}{character vector which denotes the construction rule
for multidimensional grids.
\describe{
\item{\code{product}}{for product rule, returns a "full grid" (default)}
\item{\code{sparse}}{for combination technique, leads to a regular "sparse grid".}}}

\item{level.trans}{logical variable denotes either to take the levels as number
of grid points (FALSE = default) or to transform in that manner that number of
grid points = 2^(levels-1) (TRUE). Alternatively \code{level.trans} can be a function, which takes (n x d)-matrix and returns
a matrix with the same dimensions (see the example; this feature is particularly useful for the 'sparse' construction rule,
to account for different importance of the dimensions).}
}
\value{
Returns an object of class 'NIGrid'. This object is basically an environment
containing nodes and weights and a list of features for this special grid. This
grid can be used for numerical integration (via \code{\link{quadrature}})
}
\description{
\code{createNIGrid} Creates a grid for multivariate numerical integration.
The Grid can be based on different quadrature- and construction-rules.
}
\details{
The following quadrature rules are supported (build-in).
\describe{
 \item{\code{cNC1, cNC2, ..., cNC6}}{closed Newton-Cotes Formula of degree 1-6 (1=trapezoidal-rule; 2=Simpson's-rule; ...),
 initial interval of integration: [0, 1]}
 \item{\code{oNC0, oNC1, ..., oNC3}}{open Newton-Cote Formula of degree 0-3 (0=midpoint-rule; ...),
 initial interval of integration: [0, 1]}
 \item{\code{GLe, GKr}}{Gauss-Legendre and Gauss-Kronrod rule for an initial interval of integration: [0, 1]}
 \item{\code{nLe}}{nested Gauss-Legendre rule for an initial interval of integration: [0, 1] (Knut Petras (2003). Smolyak cubature of given polynomial degree with few nodes for increasing dimension. Numerische Mathematik 93, 729-753)}
 \item{\code{GLa}}{Gauss-Laguerre rule for an initial interval of integration: [0, INF)}
 \item{\code{GHe}}{Gauss-Hermite rule for an initial interval of integration: (-INF, INF)}
 \item{\code{nHe}}{nested Gauss-Hermite rule for an initial interval of integration: (-INF, INF) (A. Genz and B. D. Keister (1996). Fully symmetric interpolatory rules for multiple integrals over infinite regions with Gaussian weight." Journal of Computational and Applied Mathematics 71, 299-309)}
 \item{\code{GHN}, \code{nHN}}{(nested) Gauss-Hermite rule as before but weights are multiplied by the standard normal density (\eqn{\hat(w)_i = w_i * \phi(x_i)}).}
 \item{\code{Leja}}{Leja-Points for an initial interval of integration: [0, 1]}}
The argument \code{type} and \code{level} can also be vector-value, different for each dimension (the later only for "product rule"; see examples)
}
\examples{
## 1D-Grid --> closed Newton-Cotes Formula of degree 1 (trapeziodal-rule)
myGrid <- createNIGrid(dim=1, type="cNC1", level=10)
print(myGrid)
## 2D-Grid --> nested Gauss-Legendre rule
myGrid <- createNIGrid(dim=2, type=c("GLe","nLe"), level=c(4, 7))
rescale(myGrid, domain = rbind(c(-1,1),c(-1,1)))
plot(myGrid)
print(myGrid)
myFun <- function(x){
   1-x[,1]^2*x[,2]^2
}
quadrature(f = myFun, grid = myGrid)
## level transformation
levelTrans <- function(x){
  tmp <- as.matrix(x)
  tmp[, 2] <- 2*tmp[ ,2]
  return(tmp)
}
nw <- createNIGrid(dim=2, type="cNC1", level = 3,
   level.trans = levelTrans, ndConstruction = "sparse")
plot(nw)
}
\references{
Philip J. Davis, Philip Rabinowitz (1984): Methods of Numerical Integration

F. Heiss, V. Winschel (2008): Likelihood approximation by numerical integration on sparse grids, Journal of Econometrics

H.-J. Bungartz, M. Griebel (2004): Sparse grids, Acta Numerica
}
\seealso{
\code{\link[=rescale.NIGrid]{rescale}}, \code{\link{quadrature}}, \code{\link[=print.NIGrid]{print}}, \code{\link[=plot.NIGrid]{plot}} and \code{\link[=size.NIGrid]{size}}
}

