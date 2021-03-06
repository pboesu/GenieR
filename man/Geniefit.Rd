% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Geniefit.R
\name{Geniefit}
\alias{Geniefit}
\title{A function to fit coalescent models to a given phylogenetic tree.}
\usage{
Geniefit(phy, Model, start, upper, lower, Rcpp = F, MCMC = F, sig = 0.1,
  run = 10000)
}
\arguments{
\item{phy}{A phylogenetic tree.}

\item{Model}{A Model choice from const (constant population size), expo (exponetial growth),expan (expansion growth), log (logistic growth), step (piecewise constant), pexpan (piecewise expansion growth) and plog (piecewise logistic growth).}

\item{start}{Initial values for the parameters to be optimized over.}

\item{lower, }{upper Bounds on the variables.}

\item{Rcpp}{Calculation is based on C++ code when it is True and on R code when it is False.}

\item{MCMC}{MCMC simulation is run when it is true, and not run when it is False. The default prior is uniform given the lower and upper.}

\item{sig}{MCMC simulation step size.}

\item{run}{Number of MCMC simulation.}
}
\value{
Parameters estimation of a given model, loglikelihood and AIC
}
\description{
A function to fit coalescent models to a given phylogenetic tree.
}
\examples{
library(ape)
t1=rcoal(20)
Geniefit(t1,Model="expo",start=c(100,.1),upper=Inf,lower=0)
Geniefit(t1,Model="expo",start=c(100,.1),upper=Inf,lower=0,Rcpp=T)
###a MCMC simulation included##
f=Geniefit(t1,Model="expo",start=c(100,.1),upper=Inf,lower=0,MCMC=T,sig=.1,run=10000)
acf(f$MCMC.simulation)
}
\author{
Fei Xiang (\email{xf3087@gmail.com})
}
