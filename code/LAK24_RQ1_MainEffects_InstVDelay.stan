data{
//Sample sizes
 int<lower=1> ncov;
 int<lower=1> nstud;
 int<lower=1> nteacher;
// int<lower=1> nclass;
 int<lower=1> nschool;
 

// indices
 int<lower=1,upper=nteacher> teacher[nstud]; 
 int<lower=1,upper=nschool> school[nstud]; 

// data data
 matrix[nstud,ncov] X;

 real Y[nstud];
 int Z[nstud];

}

parameters{

 //vector[nstud] studEff;
 vector[ncov] bY;
 
 real b1;

 real teacherEffY[nteacher];
 real teacherEffU[nteacher];
 real schoolEffU[nschool];
 real schoolEffY[nschool]; 

 real<lower=0> sigTchY; 
 real<lower=0> sigSclY;
 real<lower=0> sigY; 


}

model{
 vector[nstud] muY;
 // real trtEff_delay[nstud];
 // real trtEff_fh2t[nstud];
 // real trtEff_dragon[nstud];
// real sigYI[nstud];


 for(i in 1:nstud){
  muY[i]=teacherEffY[teacher[i]]+
        schoolEffY[school[i]]+
        Z[i]*b1;

        }
// }

 //priors
 //betaY~normal(0,2); 
 //betaU~normal(0,2); 

 // a1~normal(0,1);
 // b0_delay~normal(0,1);
 // b1_delay~normal(0,1);
 // b0_fh2t~normal(0,1);
 // b1_fh2t~normal(0,1); 
 // b0_dragon~normal(0,1);
 // b1_dragon~normal(0,1);


 schoolEffY~normal(0,sigSclY);
 teacherEffY~normal(0,sigTchY);


 Y~normal(muY+X*bY,sigY);
}

generated quantities{
// int<lower=0,upper=1> gradRep[nsecWorked];
 real Yrep[nstud];

// gradRep=bernoulli_logit_rng(linPred);
 for(i in 1:nstud)
 Yrep[i] = normal_rng(teacherEffY[teacher[i]]+schoolEffY[school[i]]+Z[i]*(b1)+X[i,]*bY,sigY);

}

