

class Wing_Sampled{

// sampled points  
int N;  
float [] y;        // span-wise coordinate
float [] chord;    // chord
float [] twist;    // twist
Airfoil [] foil1,foil2;  
float [] tFoil; 
int [] iRe1,iRe2;        // teporary store found Reynolds number for the two sections
float  [] Re;      // teporary store found Reynolds number for the two sections
  float [] dS;
  float [] theta;



float AR;
float S;
float span;
float c0;

// Polar variables
int nAlfa;
float alfaMin,alfaStep;

float [] ClP_tot; float []  CdP_tot;
float [] ClW_tot; float []  CdW_tot;
float [] Cl_tot;  float []  Cd_tot;
float [][] ClP;   float [][] CdP;
float [][] ClW;   float [][] CdW;
float [][] Cl;    float [][] Cd;
float [][] alfaI;
float [] alfa0;   float [] CLslope;

//  float [][] alfa_induced;



  // LLT Temporary variables
  double [][] sinNtheta; 
  
  double [][] aij; // coefficient matrix
  double [] rhs;   // right hand side
  double [] An;    // Fourier coefficent vector, we are solving for
  int [] index;    // ordering index from fourier

// ===============================================
//            Lift Line Theory Solver 
// ===============================================

void Solve_LLT( int ialfa){
  
/*  
 Lift line theory, see references on  
 http://en.wikipedia.org/wiki/Lifting-line_theory 
 http://www.desktop.aero/appliedaero/potential3d/liftingline.html
 http://web.aeromech.usyd.edu.au/aero/liftline/liftline.pdf
*/
  double cAlfa     = getAlfa(ialfa); 
  //  Assemble system of linear equation for fourier coeficients  (An)  of vorticity
  // fowlows derivation in  http://en.wikipedia.org/wiki/Lifting-line_theory 
  for (int i=0; i<N-1; i++){     // loop over sections
    
    for (int n=0; n<N-1; n++){   // loop over fourier coefficients
      	aij[i][n]  = sinNtheta[i][n] * (  sinNtheta[i][0] +     ((double)n*CLslope[i]*chord[i]) / ( span * 4 )   );
    }         
    rhs[i] = sinNtheta[i][0] *  (cAlfa-alfa0[i]+twist[i]) *  (CLslope[i]*chord[i]) / ( span * 4 ) ;   
  }
  
linSolve ( aij, rhs, An, index );

//for (int i=0; i<N-1; i++){   println(index[i]+"    "+An[i]); };

//   Analyze Results
//   Exctract Lift and Drag coefficients from fourier coefficients An
double Cl_tot2       = 0.0d,  Cd_tot2       = 0.0d;
for (int i=0; i<N-1; i++){
    ClW  [ialfa][i] = 0.0;
    alfaI[ialfa][i] = 0.0; 
    for (int n=0; n<N-1; n++){
          ClW   [ialfa][i] +=          An[n]* sinNtheta[i][n];
          alfaI[ialfa][i] +=   (n+1) * An[n]* sinNtheta[i][n];
    }
    alfaI[ialfa][i]  /= sinNtheta[i][0];
    ClW[ialfa][i]    *= 4*span/chord[i];
    CdW[ialfa][i]     = ClW[ialfa][i] * alfaI[ialfa][i]; 
    Cl[ialfa][i] = min( ClW[ialfa][i], ClP[ialfa][i] );
    Cd[ialfa][i] = CdW[ialfa][i] + CdP[ialfa][i];
    //println( i+"    "+   alfaI[ialfa][i] +"   "+ ClW[ialfa][i] +"    "+ CdW[ialfa][i]   +"      ||    "+   ClP[ialfa][i] +"    "+ CdP[ialfa][i]  );
  } 


// Far field result for total lift and drag
ClW_tot[ialfa] =  PI* (span*span/S) * (float)An[0];    CdW_tot[ialfa]=0.0;
for (int n=0; n<N-1; n++){ CdW_tot[ialfa] += (n+1)*(float)(An[n]*An[n]);  }
CdW_tot[ialfa] *= PI* (span*span/S);

// compute total coefficients
Cl_tot[ialfa] = min (  ClW_tot[ialfa],  ClP_tot[ialfa] ); 
Cd_tot[ialfa] = CdW_tot[ialfa] + CdP_tot[ialfa];

//println( (span/c0) + "   "+ cCl[N/2] +" "+ cAlfaI[N/2]+" "+ GlideRatio[ialfa][N/2] );  

// Check if both ways of evaluation provide the same results
//println( AR  +"  "+    Cl_tot[ialfa] + " "+ Cl_tot2 +"      "+ Cd_tot[ialfa] + " "+ Cd_tot2 +"      " );  
//println( ialfa+" AR="+AR  +"  ClW= "+  ClW_tot[ialfa] + "  CdW= "+ CdW_tot[ialfa] );  
println( ialfa+"  "+ClW_tot[ialfa]+"  "+ CdW_tot[ialfa]+"   ||  "+ClP_tot[ialfa]+"  "+CdP_tot[ialfa]+"  ||  "+Cl_tot[ialfa]+"  "+Cd_tot[ialfa]  );
  
}


// ===============================================
//            Lift Line Theory  Initialization
// ===============================================

void Init_LLT(){
  aij   = new double[N][N-1]; 
  rhs   = new double[N-1];
  An    = new double[N-1];
  index = new int[N-1];
  sinNtheta = new   double [N-1][N-1]; 
  for (int i=0; i<N-1; i++){    for (int j=0; j<N-1; j++){
        //sinNtheta[i][j] = Math.sin(   (double)(j+1) * theta[i] );  
        sinNtheta[i][j] = Math.sin(   (double)(j+1) * (double)(i+1) * Math.PI /(double)N   );  
   }  }
}


//   ==========================
//      updateRe
//   ==========================

void updateRe( float Vinf ){
  alfa0   = new float[y.length];
  CLslope = new float[y.length];  
for (int i=0;i<y.length; i++){   
 // println(i);
  Re[i]  =   evalRe( Vinf, chord[i]  ); 
 // print (foil1[i].Re);
 // print (foil2[i].Re);
  iRe1[i] = -(Arrays.binarySearch(foil1[i].Re,Re[i])+2); 
  iRe2[i] = -(Arrays.binarySearch(foil2[i].Re,Re[i])+2);
  //println( i+"  "+ iRe1[i] + "   " + iRe2[i]  ); 
  //println( Re[i]+"   f1: "+ foil1[i].Re[iRe1[i]]+" -- " + foil1[i].Re[iRe1[i]+1] +"   f1: "+ foil2[i].Re[iRe2[i]]+" -- " + foil2[i].Re[iRe2[i]+1]  ); 
  // evaluate linearized lift coefficients for LLT computation
  foil1[i].interpolateLinearLift( iRe1[i],  Re[i]); 
  foil2[i].interpolateLinearLift( iRe2[i],  Re[i]); 
  alfa0  [i] = (1.0-tFoil[i])*foil1[i].cAlfa0   + tFoil[i]*foil1[i].cAlfa0;
  CLslope[i] = (1.0-tFoil[i])*foil1[i].cCLslope + tFoil[i]*foil1[i].cCLslope;
  //println( Re[i]+"    "+  CLslope[i]+"   "+ alfa0[i]   );
};
}

//  ==========================
//     IntegrateAlfa()
//  ==========================

final float getAlfa(int ialfa){
  return  alfaMin + alfaStep*ialfa;
};

void IntegrateAlfa( int ialfa ){
for (int i=0;i<y.length; i++){               // interpolate on each section
  foil1[i].interpolate( iRe1[i],  Re[i], getAlfa(ialfa)+twist[i]);    // set up temporary variables of airfoil
  foil2[i].interpolate( iRe2[i],  Re[i], getAlfa(ialfa)+twist[i]);    // set up temporary variables of airfoil
  ClP[ialfa][i] = (1.0-tFoil[i])*foil1[i].cL   +  tFoil[i]*foil2[i].cL;
  CdP[ialfa][i] = (1.0-tFoil[i])*foil1[i].cD   +  tFoil[i]*foil2[i].cD;
  

  // println(i+" "+tFoil[i]+ "    "+foil1[i].cL +"    "+ foil2[i].cL);
  //println(i+" "+Cl[ialfa][i] +"    "+ Cd[ialfa][i]);
}
ClP_tot[ialfa] = 0;   CdP_tot[ialfa] = 0;
for (int i=1;i<y.length; i++){   // integrate by trapezoid rule forces on area between sections
  float dy = (y[i]-y[i-1]);
  ClP_tot[ialfa]+= 0.5*(ClP[ialfa][i]*chord[i]   +    ClP[ialfa][i-1]*chord[i-1])*dy;
  CdP_tot[ialfa]+= 0.5*(CdP[ialfa][i]*chord[i]   +    CdP[ialfa][i-1]*chord[i-1])*dy;
}  
ClP_tot[ialfa] /=S;   CdP_tot[ialfa] /=S;
}


// =========================================
//       constructor
// =========================================
Wing_Sampled( int N, int nAlfa, float alfaMin,  float alfaStep, Wing_input WI ){
  this.N=N; this.nAlfa = nAlfa; this.alfaMin = alfaMin;  this.alfaStep = alfaStep;
  span = WI.span;
  c0   = WI.c0;
  
  theta   = new float[N];
  y       = new float[N];
  chord   = new float[N];
  dS      = new float[N];
  twist   = new float[N];
  Re    = new float[N];
  tFoil = new float[N];
  iRe1  = new int[N];     iRe2  = new int[N];
  foil1 = new Airfoil[N]; foil2 = new Airfoil[N];
  
  float oy=0,oc=0;  S=0;
  for (int i=0;i<N;i++){
    theta[i] = (i+1)*PI/(float)N;
    y[i]       = -(span*0.5)* cos(theta[i] ); 
    //println(theta[i]+" "+span+" "+cos(theta[i])+" "+y[i]);
    //y[i]    =  i*span/(float)(N-1);
    //chord[i]  = WI.getChord( y[i] );
    chord[i]  = c0*SuperEllipse.eval( 2.0*abs(y[i])/span);
    twist[i]  = WI.getTwist( y[i] );
    WI.interFoil(y[i]);
    foil1[i] = WI.cFoil1;
    foil2[i] = WI.cFoil2;
    tFoil[i]= WI.tFoil;
    dS[i] = 0.5*( oc + chord[i] )*( y[i] - oy );    
    oc = chord[i];
    oy=y[i];
    S+=dS[i];
  //println( i+" "+theta[i] + " " + y[i] + "  "+chord[i] );
  }
  println(" S= " +S + " [m^2] ");
  AR = span*span/S;  
  
  println(   " c0= "+ c0+"  span= "+span+"  S= "+S+"  AR= " + AR    );
  
  // Polar Variables
  ClP_tot       = new float [nAlfa];    CdP_tot      = new float [nAlfa];      
  ClW_tot       = new float [nAlfa];    CdW_tot      = new float [nAlfa];  
  Cl_tot        = new float [nAlfa];    Cd_tot       = new float [nAlfa];       
  ClP           = new float [nAlfa][N]; CdP          = new float [nAlfa][N];
  ClW           = new float [nAlfa][N]; CdW          = new float [nAlfa][N];
  Cl            = new float [nAlfa][N];  Cd          = new float [nAlfa][N];
  alfaI         = new float [nAlfa][N];
  for (int ialfa=0; ialfa<nAlfa;ialfa++){     
   ClP_tot[ialfa]=Float.NaN;CdP_tot[ialfa]=Float.NaN;ClW_tot[ialfa]=Float.NaN;CdW_tot[ialfa]=Float.NaN;
   Cl_tot[ialfa]=Float.NaN;Cd_tot[ialfa]=Float.NaN;
   for (int i=0;i<N; i++){
     ClP[ialfa][i]=Float.NaN; CdP[ialfa][i]=Float.NaN; ClW[ialfa][i]=Float.NaN; CdW[ialfa][i]=Float.NaN;
     alfaI[ialfa][i]=Float.NaN;
   } 
  }
//  alfa0         = new float [N]; CLslope         = new float [N];
//  for (int i=0;i<N; i++){ alfa0[i] = float.NaN;  CLslope[i] = float.NaN; }
} 


// ==============================================
//    Plot Wing
// =============================================

void Plot(int ialfa){
  stroke(0);
  fill(0);        text("Chord"        , 10 , 10 );
  fill(255,0,0);  text("Cl"           , 10 , 20 );
  fill(0,255,0);  text("Alfa_induced" , 10 , 30 );
  fill(0,0,255);  text("Cd"           , 10 , 40 );
  for (int i=1; i<N;  i++){
    //println (i+" "+y[i]+"  "+chord[i]);
    //print (theta[i]);
    //point ( ( i/(float)N)*100,  (float)theta[i]*100 );
    //println( i+"  "+theta[i]+" "+y[i]+"  "+chord[i]+"   "+ClP[ialfa][i] +"    "+ CdP[ialfa][i]  );
    strokeWeight(3);
    stroke(0);        point ( sx( -y[i]   ),  sy(  chord[i]                  ) );
    stroke(255,0,0);  point ( sx( -y[i]   ),  sy(  ClP[ialfa][i]              ) );
    stroke(0,0,255);  point ( sx( -y[i]   ),  sy(  10*CdP[ialfa][i]           ) );
    
    strokeWeight(1);
    stroke(0);        line ( sx( -y[i] ),  sy(  chord[i]                  ), sx( -y[i-1] ),  sy(  chord[i-1]                  ) );
    stroke(255,0,0);  line ( sx( -y[i] ),  sy(  ClP[ialfa][i]              ), sx( -y[i-1] ),  sy(  ClP[ialfa][i-1]              ) );
    stroke(0,0,255);  line ( sx( -y[i] ),  sy(  10*CdP[ialfa][i]           ), sx( -y[i-1] ),  sy(  10*CdP[ialfa][i-1]             ) );
    stroke(255,0,0);  line ( sx( -y[i] ),  sy(  Cl[ialfa][i]              ), sx( -y[i-1] ),  sy(  Cl[ialfa][i-1]              ) );
    stroke(0,0,255);  line ( sx( -y[i] ),  sy(  10*Cd[ialfa][i]           ), sx( -y[i-1] ),  sy(  10*Cd[ialfa][i-1]             ) );
  }
}  
}


