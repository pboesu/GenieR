% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RcppExports.R
\name{negllc_const}
\alias{negllc_const}
\title{Function to calculate the loglikelihood of a constant coalescent model}
\usage{
negllc_const(N0, t, A)
}
\arguments{
\item{N0}{A population size.}

\item{t}{A sampling and coalescent time vector.}

\item{A}{A lineages vector}
}
\value{
Sorted sampling times, coalescent times and sampling lineages.
}
\description{
Function to calculate the loglikelihood of a constant coalescent model
}
\examples{
library(ape)
t1=rcoal(20)
x=att(t1)
negllc_const(1, x$t, x$A)
}
\author{
Simon Frost (\email{sdwfrost@gmail.com})
}
