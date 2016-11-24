######MCMC updates for constant model based on negllc_const#####
MCMC_const=function(phy,start,lower,upper,sig,run){
  ##initial set up##
  x=att(phy)
  n=start
  lik=negllc_const(n,t=x$t,A=x$A)
  output=matrix(0,ncol=2,nrow=run)
  left=max(lower,1e-20)
  right=min(upper,1e+20)
  Acc=0

   for (i in 1:run){
     #######updating N0#######
    logn=log(n)
    lognN=rnorm(1,logn,sig)
    nN=exp(lognN)
    ######new likelihood######
    likN=negllc_const(nN,t=x$t,A=x$A)
    #######rejection sampling######
    accn=exp(-likN+lik)*nN/n
    u=runif(1)
    if (u<accn && nN<right && nN>left){
      n=nN
      lik=likN
      Acc=Acc+1
    }
  output[i,]=c(n,lik)
    }

  print(Acc)
return(output)

}

######MCMC updates for exponential model based on negllc_expo####
MCMC_expo=function(phy,start,lower,upper,sig,run){
  x=att(phy)
  n=start[1]
  r=start[2]
  lik=negllc_expo(start,t=x$t,A=x$A)
  output=matrix(0,ncol=3,nrow=run)
if (length(upper)==1) {
  n.left=max(lower,1e-20)
  n.right=min(upper,1e+20)
  r.left=max(lower,1e-10)
  r.right=min(upper,1e+20)
}
  if (length(upper)==2){
    n.left=max(lower[1],1e-20)
    n.right=min(upper[1],1e+20)
    r.left=max(lower[2],1e-10)
    r.right=min(upper[2],1e+20)
  }
  Acc=c(0,0)
  for (i in 1:run){
    #######updating N0#######
    logn=log(n)
    lognN=rnorm(1,logn,sig)
    nN=exp(lognN)
    ######new likelihood######
    likN=negllc_expo(c(nN,r),t=x$t,A=x$A)
    #######rejection sampling######
    accn=exp(-likN+lik)*nN/n
    u=runif(1)
    if (u<accn && nN<n.right && nN>n.left){
      n=nN
      lik=likN
      Acc[1]=Acc[1]+1
    }
    ########updating r######
    logr=log(r)
    logrN=rnorm(1,logr,sig/2)
    rN=exp(logrN)
    ######new likelihood#######
    likN=negllc_expo(c(n,rN),t=x$t,A=x$A)
    #####rejection sampling#######
    accr=exp(-likN+lik)*rN/r
    u=runif(1)
    if (u<accr && rN<r.right && rN>r.left){
      r=rN
      lik=likN
      Acc[2]=Acc[2]+1
    }
output[i,]=c(n,r,lik)

  }
  print(Acc)
  return(output)
}

######MCMC updates for expansion model based on negllc_expan####
MCMC_expan=function(phy,start,lower,upper,sig,run){
  x=att(phy)
  n=start[1]
  r=start[2]
  alpha=start[3]
  lik=negllc_expan(start,t=x$t,A=x$A)
  output=matrix(0,ncol=4,nrow=run)
  if (length(upper)==1) {
    n.left=max(lower,1e-20)
    n.right=min(upper,1e+20)
    r.left=max(lower,1e-10)
    r.right=min(upper,1e+20)
    alpha.left=max(lower,1e-50)
    alpha.right=min(upper,1)
  }
  if (length(upper)==3){
    n.left=max(lower[1],1e-20)
    n.right=min(upper[1],1e+20)
    r.left=max(lower[2],1e-10)
    r.right=min(upper[2],1e+20)
    alpha.left=max(lower[3],1e-50)
    alpha.right=min(upper[3],1)
  }
  Acc=c(0,0,0)
  for (i in 1:run){
    #######updating N0#######
    logn=log(n)
    lognN=rnorm(1,logn,sig)
    nN=exp(lognN)
    ######new likelihood######
    likN=negllc_expan(c(nN,r,alpha),t=x$t,A=x$A)
    #######rejection sampling######
    accn=exp(-likN+lik)*nN/n
    u=runif(1)
    if (u<accn && nN<n.right && nN>n.left){
      n=nN
      lik=likN
      Acc[1]=Acc[1]+1
    }
    ########updating r######
    logr=log(r)
    logrN=rnorm(1,logr,sig/2)
    rN=exp(logrN)
    ######new likelihood#######
    likN=negllc_expan(c(n,rN,alpha),t=x$t,A=x$A)
    #####rejection sampling#######
    accr=exp(-likN+lik)*rN/r
    u=runif(1)
    if (u<accr && rN<r.right && rN>r.left){
      r=rN
      lik=likN
      Acc[2]=Acc[2]+1
    }
    #######updating alpha#####
    logalpha=log(alpha)
    logalphaN=rnorm(1,logalpha,sig)
    alphaN=exp(logalphaN)
    #####new likelihood#######
    likN=negllc_expan(c(n,r,alphaN),t=x$t,A=x$A)
    ######rejection sampling#####
    acca=exp(-likN+lik)*alphaN/alpha
    u=runif(1)
    if (u<acca && alphaN<alpha.right && alphaN>alpha.left){
    alpha=alphaN
    lik=likN
    Acc[3]=Acc[3]+1
      }

    output[i,]=c(n,r,alpha,lik)

  }
  print(Acc)
  return(output)
}


######MCMC updates for logistic model based on negllc_log####
MCMC_log=function(phy,start,lower,upper,sig,run){
  x=att(phy)
  n=start[1]
  r=start[2]
  c=start[3]
  lik=negllc_log(start,t=x$t,A=x$A)
  output=matrix(0,ncol=4,nrow=run)
  if (length(upper)==1) {
    n.left=max(lower,1e-20)
    n.right=min(upper,1e+20)
    r.left=max(lower,1e-10)
    r.right=min(upper,1e+10)
    c.left=max(lower,1e-30)
    c.right=min(upper,100000)
  }
  if (length(upper)==3){
    n.left=max(lower[1],1e-20)
    n.right=min(upper[1],1e+20)
    r.left=max(lower[2],1e-10)
    r.right=min(upper[2],1e+10)
    c.left=max(lower[3],1e-30)
    c.right=min(upper[3],100000)
  }
  Acc=c(0,0,0)
  for (i in 1:run){
    #######updating N0#######
    logn=log(n)
    lognN=rnorm(1,logn,sig)
    nN=exp(lognN)
    ######new likelihood######
    likN=negllc_log(c(nN,r,c),t=x$t,A=x$A)
    #######rejection sampling######
    accn=exp(-likN+lik)*nN/n
    u=runif(1)
    if (u<accn && nN<n.right && nN>n.left){
      n=nN
      lik=likN
      Acc[1]=Acc[1]+1
    }
    ########updating r######
    logr=log(r)
    logrN=rnorm(1,logr,sig/2)
    rN=exp(logrN)
    ######new likelihood#######
    likN=negllc_log(c(n,rN,c),t=x$t,A=x$A)
    #####rejection sampling#######
    accr=exp(-likN+lik)*rN/r
    u=runif(1)
    if (u<accr && rN<r.right && rN>r.left){
      r=rN
      lik=likN
      Acc[2]=Acc[2]+1
    }
    #######updating c#####
    logc=log(c)
    logcN=rnorm(1,logc,sig*2)
    cN=exp(logcN)
    #####new likelihood#######
    likN=negllc_log(c(n,r,cN),t=x$t,A=x$A)
    ######rejection sampling#####
    acca=exp(-likN+lik)*cN/c
    u=runif(1)
    if (u<acca && cN<c.right && cN>c.left){
      c=cN
      lik=likN
      Acc[3]=Acc[3]+1
    }

    output[i,]=c(n,r,c,lik)

  }
  print(Acc)
  return(output)
}


######MCMC updates for step model based on negllc_step####
MCMC_step=function(phy,start,lower,upper,sig,run){
  x=att(phy)
  n=start[1]
  f=start[2]
  X=start[3]
  lik=negllc_step(start,t=x$t,A=x$A)
  output=matrix(0,ncol=4,nrow=run)
  if (length(upper)==1) {
    n.left=max(lower,1e-20)
    n.right=min(upper,1e+20)
    f.left=max(lower,1e-10)
    f.right=min(upper,1e+10)
    X.left=max(lower,1e-20)
    X.right=min(upper,1e+20)
  }
  if (length(upper)==3){
    n.left=max(lower[1],1e-20)
    n.right=min(upper[1],1e+20)
    f.left=max(lower[2],1e-10)
    f.right=min(upper[2],1e+10)
    X.left=max(lower[3],1e-20)
    X.right=min(upper[3],1e+20)
  }
  Acc=c(0,0,0)
  for (i in 1:run){
    #######updating N0#######
    logn=log(n)
    lognN=rnorm(1,logn,sig)
    nN=exp(lognN)
    ######new likelihood######
    likN=negllc_step(c(nN,f,X),t=x$t,A=x$A)
    #######rejection sampling######
    accn=exp(-likN+lik)*nN/n
    u=runif(1)
    if (u<accn && nN<n.right && nN>n.left){
      n=nN
      lik=likN
      Acc[1]=Acc[1]+1
    }
    ########updating r######
    logf=log(f)
    logfN=rnorm(1,logf,sig)
    fN=exp(logfN)
    ######new likelihood#######
    likN=negllc_step(c(n,fN,X),t=x$t,A=x$A)
    #####rejection sampling#######
    accr=exp(-likN+lik)*fN/f
    u=runif(1)
    if (u<accr && fN<f.right && fN>f.left){
      f=fN
      lik=likN
      Acc[2]=Acc[2]+1
    }
    #######updating c#####
    logX=log(X)
    logXN=rnorm(1,logX,sig)
    XN=exp(logXN)
    #####new likelihood#######
    likN=negllc_step(c(n,f,XN),t=x$t,A=x$A)
    ######rejection sampling#####
    acca=exp(-likN+lik)*XN/X
    u=runif(1)
    if (u<acca && XN<X.right && XN>X.left){
      X=XN
      lik=likN
      Acc[3]=Acc[3]+1
    }

    output[i,]=c(n,f,X,lik)

  }
  print(Acc)
  return(output)
}
######MCMC updates for piecewise expansion model based on negllc_pexpan####
MCMC_pexpan=function(phy,start,lower,upper,sig,run){
  x=att(phy)
  n=start[1]
  r=start[2]
  alpha=start[3]
  lik=negllc_pexpan(start,t=x$t,A=x$A)
  output=matrix(0,ncol=4,nrow=run)
  if (length(upper)==1) {
    n.left=max(lower,1e-20)
    n.right=min(upper,1e+20)
    r.left=max(lower,1e-10)
    r.right=min(upper,1e+10)
    alpha.left=max(lower,1e-50)
    alpha.right=min(upper,1)
  }
  if (length(upper)==3){
    n.left=max(lower[1],1e-20)
    n.right=min(upper[1],1e+20)
    r.left=max(lower[2],1e-10)
    r.right=min(upper[2],1e+10)
    alpha.left=max(lower[3],1e-50)
    alpha.right=min(upper[3],1)
  }
  Acc=c(0,0,0)
  for (i in 1:run){
    #######updating N0#######
    logn=log(n)
    lognN=rnorm(1,logn,sig)
    nN=exp(lognN)
    ######new likelihood######
    likN=negllc_pexpan(c(nN,r,alpha),t=x$t,A=x$A)
    #######rejection sampling######
    accn=exp(-likN+lik)*nN/n
    u=runif(1)
    if (u<accn && nN<n.right && nN>n.left){
      n=nN
      lik=likN
      Acc[1]=Acc[1]+1
    }
    ########updating r######
    logr=log(r)
    logrN=rnorm(1,logr,sig/2)
    rN=exp(logrN)
    ######new likelihood#######
    likN=negllc_pexpan(c(n,rN,alpha),t=x$t,A=x$A)
    #####rejection sampling#######
    accr=exp(-likN+lik)*rN/r
    u=runif(1)
    if (u<accr && rN<r.right && rN>r.left){
      r=rN
      lik=likN
      Acc[2]=Acc[2]+1
    }
    #######updating alpha#####
    logalpha=log(alpha)
    logalphaN=rnorm(1,logalpha,sig)
    alphaN=exp(logalphaN)
    #####new likelihood#######
    likN=negllc_pexpan(c(n,r,alphaN),t=x$t,A=x$A)
    ######rejection sampling#####
    acca=exp(-likN+lik)*alphaN/alpha
    u=runif(1)
    if (u<acca && alphaN<alpha.right && alphaN>alpha.left){
      alpha=alphaN
      lik=likN
      Acc[3]=Acc[3]+1
    }

    output[i,]=c(n,r,alpha,lik)

  }
  print(Acc)
  return(output)
}



######MCMC updates for piecewise logistic model based on negllc_plog####
MCMC_plog=function(phy,start,lower,upper,sig,run){
  x=att(phy)
  n=start[1]
  r=start[2]
  alpha=start[3]
  lik=negllc_plog(start,t=x$t,A=x$A)
  output=matrix(0,ncol=4,nrow=run)
  if (length(upper)==1) {
    n.left=max(lower,1e-20)
    n.right=min(upper,1e+20)
    r.left=max(lower,1e-10)
    r.right=min(upper,1e+10)
    alpha.left=max(lower,1e-15)
    alpha.right=min(upper,1e+15)
  }
  if (length(upper)==3){
    n.left=max(lower[1],1e-20)
    n.right=min(upper[1],1e+20)
    r.left=max(lower[2],1e-10)
    r.right=min(upper[2],1e+10)
    alpha.left=max(lower[3],1e-15)
    alpha.right=min(upper[3],1e+15)
  }
  Acc=c(0,0,0)
  for (i in 1:run){
    #######updating N0#######
    logn=log(n)
    lognN=rnorm(1,logn,sig)
    nN=exp(lognN)
    ######new likelihood######
    likN=negllc_plog(c(nN,r,alpha),t=x$t,A=x$A)
    #######rejection sampling######
    accn=exp(-likN+lik)*nN/n
    u=runif(1)
    if (u<accn && nN<n.right && nN>n.left){
      n=nN
      lik=likN
      Acc[1]=Acc[1]+1
    }
    ########updating r######
    logr=log(r)
    logrN=rnorm(1,logr,sig/2)
    rN=exp(logrN)
    ######new likelihood#######
    likN=negllc_plog(c(n,rN,alpha),t=x$t,A=x$A)
    #####rejection sampling#######
    accr=exp(-likN+lik)*rN/r
    u=runif(1)
    if (u<accr && rN<r.right && rN>r.left){
      r=rN
      lik=likN
      Acc[2]=Acc[2]+1
    }
    #######updating alpha#####
    logalpha=log(alpha)
    logalphaN=rnorm(1,logalpha,sig)
    alphaN=exp(logalphaN)
    #####new likelihood#######
    likN=negllc_plog(c(n,r,alphaN),t=x$t,A=x$A)
    ######rejection sampling#####
    acca=exp(-likN+lik)*alphaN/alpha
    u=runif(1)
    if (u<acca && alphaN<alpha.right && alphaN>alpha.left){
      alpha=alphaN
      lik=likN
      Acc[3]=Acc[3]+1
    }

    output[i,]=c(n,r,alpha,lik)

  }
  print(Acc)
  return(output)
}