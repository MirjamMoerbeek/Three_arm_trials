f.optdes <- function(alpha,power,
                     mean.T,mean.M,mean.P,
                     vartot.T,vartot.M,vartot.P,ICC.T,ICC.M,ICC.P,var.MvsP,
                     c2T,c2MP,c1T,c1M,c1P,
                     kT.min,kT.max,kMP.min,kMP.max,nT.min,nT.max,nMP.min,nMP.max,
                     minimize){

  
  results=NULL
  for(kT in kT.min:kT.max) {
    for(kMP in kMP.min:kMP.max){
      for(nT in nT.min:nT.max){
        for(nMP in nMP.min:nMP.max){
          for(nM in 1:nMP){
          var.e0.T=vartot.T*(1-ICC.T)
          var.u0.T=vartot.T*ICC.T
          var.e0.P=vartot.P*(1-ICC.P)
          var.u0.P=vartot.P*ICC.P
          var.e0.M=var.e0.P
          var.e1.M=0
          covar.e01.M=(vartot.M*(1-ICC.M)-var.e0.M)/2
          var.u0.M=var.u0.P
          var.u1.M=var.MvsP
          covar.u01.M=(vartot.M*ICC.M-var.u0.M-var.u1.M)/2
          
          nP=nMP-nM
          var.TM<-(var.e0.T+nT*var.u0.T)/(nT*kT)+(var.e0.M+var.e1.M+2*covar.e01.M+nM*(var.u0.M+var.u1.M+2*covar.u01.M))/(nM*kMP)
          var.TP<-(var.e0.T+nT*var.u0.T)/(nT*kT)+(var.e0.P+nP*var.u0.P)/(nP*kMP)
          var.MP<-(var.e0.M+var.e1.M+2*covar.e01.M)/(kMP*nM)+var.e0.M/(kMP*nP)+var.u1.M/kMP
          costs<-(c2T+c1T*nT)*kT+(c2MP+c1M*nM+c1P*nP)*kMP
          totalN<-nT*kT+(nM+nP)*kMP
          power.TM<-pnorm(abs(mean.T-mean.M)/sqrt(var.TM)-qnorm(1-alpha/2))
          power.TP<-pnorm(abs(mean.T-mean.P)/sqrt(var.TP)-qnorm(1-alpha/2))
          power.MP<-pnorm(abs(mean.M-mean.P)/sqrt(var.MP)-qnorm(1-alpha/2))
          if(power.TM>power&power.TP>power&power.MP>power)
            results<-rbind(results,cbind(kT,kMP,nT,nMP,nM,nP,totalN,costs,power.TM,power.TP,power.MP)) 
          }
        }
      }
    }
  }

  if(minimize=="1"){
    mincosts<-min(results[,8])
    index=which(results[,8]==mincosts)
    results=rbind(NULL,results[index,])} 
  
  else{
    minN<-min(results[,7])
    index=which(results[,7]==minN)
    results=rbind(NULL,results[index,])}
  
  
  if(is.null(results)==TRUE)
   {kT=NA
    kMP=NA
    nT=NA
    nMP=NA
    nM=NA
    nP=NA
    totalN=NA
    costs=NA
    power.TM=NA
    power.TP=NA
    power.MP=NA
    
    results<-rbind(results,cbind(kT,kMP,nT,nMP,nM,nP,totalN,costs,power.TM,power.TP,power.MP)) 
  } 
  
  return(results)
 
}