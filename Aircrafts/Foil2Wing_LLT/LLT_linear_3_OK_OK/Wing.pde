
class Wing{
  // paremters
  int N;
  double span;
  double c0;
  double AR;
  double S;
  double [] dS;
  double [] theta;
  double [] y;
  double [] chord;
  double [] twist;
  
  // Polar Variables
  int nAlfa;
  double slope;
  double [] alfa;
  double [] Cl_tot;
  double [] Cd_tot;
  
  double [][] Cl;
  double [][] alfa_induced;
  double [][] Cd;
  double [][] GlideRatio;
  
  // Temporary variables
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

  double cAlfa     = alfa[ialfa]; 
  double [] cCl    = Cl[ialfa];
  double [] cAlfaI = alfa_induced[ialfa];
  double [] cCd   = Cd[ialfa];
 
  //  Assemble system of linear equation for fourier coeficients  (An)  of vorticity
  // fowlows derivation in  http://en.wikipedia.org/wiki/Lifting-line_theory 
  for (int i=0; i<N-1; i++){
    for (int n=0; n<N-1; n++){
      	aij[i][n]  = sinNtheta[i][n] * (  sinNtheta[i][0] +     ((double)n*slope*chord[i]) / ( span * 4 )   );
    }         
    rhs[i] = sinNtheta[i][0] *  (cAlfa+twist[i]) *  (slope * chord[i]) / ( span * 4 ) ;   
  }
  
linSolve ( aij, rhs, An, index );

//for (int i=0; i<N-1; i++){   println(index[i]+"    "+An[i]); };

//   Analyze Results
//   Exctract Lift and Drag coefficients from fourier coefficients An
       Cl_tot[ialfa] = 0.0d;  Cd_tot[ialfa] = 0.0d;
double Cl_tot2       = 0.0d,  Cd_tot2       = 0.0d;
for (int i=0; i<N-1; i++){
    cCl[i]    = 0.0;
    cAlfaI[i] = 0.0; 
    for (int n=0; n<N-1; n++){
          cCl[i]    +=           An[n]* sinNtheta[i][n];
          cAlfaI[i] +=   (n+1) * An[n]* sinNtheta[i][n];
    }
    cCl[i]     *= 4*span/chord[i];
    cAlfaI[i]  /= sinNtheta[i][0];
    cCd[i]      = cCl[i] * cAlfaI[i]; 
    if(cCd[i] !=0.0d)  GlideRatio[ialfa][i] = cCl[i]/cCd[i];
    Cl_tot2+=cCl[i]*dS[i];
    Cd_tot2+=cCd[i]*dS[i];
  }
Cl_tot2/=S;   Cd_tot2/=S;


// Far field result for total lift and drag
Cl_tot[ialfa] = Math.PI* (span*span/S) * An[0];
for (int n=0; n<N-1; n++){ Cd_tot[ialfa] += (n+1)*An[n]*An[n]; }
Cd_tot[ialfa] *= Math.PI* (span*span/S);

//println( (span/c0) + "   "+ cCl[N/2] +" "+ cAlfaI[N/2]+" "+ GlideRatio[ialfa][N/2] );  

// Check if both ways of evaluation provide the same results
println( AR  +"  "+    Cl_tot[ialfa] + " "+ Cl_tot2 +"      "+ Cd_tot[ialfa] + " "+ Cd_tot2 +"      " );  
  
}


// ===============================================
//            Lift Line Theory  Initialization
// ===============================================

void Init_LLT(){
  aij   = new double[N-1][N-1]; 
  rhs   = new double[N-1];
  An    = new double[N-1];
  index = new int[N-1];
  sinNtheta = new   double [N-1][N-1]; 
  for (int i=0; i<N-1; i++){    for (int j=0; j<N-1; j++){
        //sinNtheta[i][j] = Math.sin(   (double)(j+1) * theta[i] );  
        sinNtheta[i][j] = Math.sin(   (double)(j+1) * (double)(i+1) * Math.PI /(double)N   );  
   }  }
}


// ======================================
//         Wing Initialization
// ======================================

Wing( int N, int nAlfa,double span, double c0){
  this.N=N; this.nAlfa = nAlfa;
  this.span = span;
  this.c0   = c0; 
  theta = new double[N];
  y     = new double[N];
  chord = new double[N];
  dS    = new double[N];
  twist = new double[N];
  
  double oy=0,oc=0;  S=0;
  for (int i=0;i<N;i++){
    theta[i] = (double)(i+1)*Math.PI/(double)N;
    //chord[i] = c0; 
    chord[i] = c0*  Math.sin(theta[i] ); 
    //chord[i] = c0* ( 1+Math.cos(2*theta[i] + PI)); 
    //chord[i] = c0*  (  Math.sin(theta[i] )    +     0.1*Math.sin(3*theta[i] )    ); 
    //chord[i] = c0*  Math.sqrt(Math.sin(theta[i] ));     
    y[i]       =  (span*0.5)* Math.cos(theta[i] ); 
    //println(i+" "+ y[i] + "  " +  chord[i] );
    dS[i] = 0.5d*( oc +  chord[i] )*( oy - y[i] );     oc = chord[i]; oy=y[i];
    S+=dS[i];
    AR = span*span/S;  
  }
  
//  println(   " c0= "+ c0+"  span= "+span+"  S= "+S+"  AR= " + AR    );
  
  // Polar Variables
  slope = 2*PI;
  alfa         = new double [nAlfa];
  Cl_tot       = new double [nAlfa];
  Cd_tot       = new double [nAlfa];
  Cl           = new double [nAlfa][N];
  alfa_induced = new double [nAlfa][N];
  Cd           = new double [nAlfa][N];
  GlideRatio   = new double [nAlfa][N];
  for (int ialfa=0;ialfa<nAlfa;ialfa++){
    alfa[ialfa] = ialfa * PI / 180.0;
  }
  
  Init_LLT();
}

// ========== Plot =====================

void plot(int ialfa){
  stroke(0);
  line (400,800,400,0);
  line (0,400,800,400);
  fill(0);        text("Chord"        , 10 , 10 );
  fill(255,0,0);  text("Cl"           , 10 , 20 );
  fill(0,255,0);  text("Alfa_induced" , 10 , 30 );
  fill(0,0,255);  text("Cd"           , 10 , 40 );
  for (int i=1; i<N;  i++){
    //println (i+" "+y[i]+"  "+chord[i]);
    //print (theta[i]);
    //point ( ( i/(float)N)*100,  (float)theta[i]*100 );
    strokeWeight(3);
    stroke(0);        point ( sx( y[i]   ),  sy(  chord[i]                  ) );
    stroke(255,0,0);  point ( sx( y[i]   ),  sy(  Cl[ialfa][i]              ) );
    stroke(0,255,0);  point ( sx( y[i]   ),  sy(  10*alfa_induced[ialfa][i] ) );
    stroke(0,0,255);  point ( sx( y[i]   ),  sy(  10*Cd[ialfa][i]           ) );
    
    strokeWeight(1);
    stroke(0);        line ( sx( y[i] ),  sy(  chord[i]                  ), sx( y[i-1] ),  sy(  chord[i-1]                  ) );
    stroke(255,0,0);  line ( sx( y[i] ),  sy(  Cl[ialfa][i]              ), sx( y[i-1] ),  sy(  Cl[ialfa][i-1]              ) );
    stroke(0,255,0);  line ( sx( y[i] ),  sy(  10*alfa_induced[ialfa][i] ), sx( y[i-1] ),  sy(  10*alfa_induced[ialfa][i-1] ) );
    stroke(0,0,255);  line ( sx( y[i] ),  sy(  10*Cd[ialfa][i]           ), sx( y[i-1] ),  sy(  10*Cd[ialfa][i-1]             ) );
    
    stroke(255,0,255);  line ( sx( y[i] ),  sy( 0.01* GlideRatio[ialfa][i]           ), sx( y[i-1] ),  sy(  0.01*GlideRatio[ialfa][i-1]             ) );
   
  }
}

}
