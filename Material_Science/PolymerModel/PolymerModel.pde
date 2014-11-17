
//========== Setup

double damp = 0.8;
double dt = 1.0;

double iMass   = 1.0;
double k_inter = 0.05;
double k_intra = 0.2;

int perFrame = 100;

// ========= Settings

double [][] Xs,Fs,Vs,Ds;
int    []   crosslinks;

//========== Main loop

void setup(){
  size(400,400);
  makeChains( 20, 20, 1.0 );
  makeCrossLinks();
  println("====== Setup Done ");
}

void draw(){
  background(200);
  for(int i=0; i<perFrame; i++) step(); 
  plotLinks();
  //noLoop();
}

//========== Subroutines

void boundary_F(){
  for (int ichain = 0; ichain<Fs.length; ichain++){ 
    Fs[ichain][Fs[ichain].length-1] += 0.05;
  }
};

void boundary_X(){
  for (int ichain = 0; ichain<Xs.length/2; ichain++){ 
    Xs[ichain][0] = 0;
  }
};


void makeChains( int nChains, int n, double d0 ){
  Xs = new double[nChains][n];
  Fs = new double[nChains][n];
  Vs = new double[nChains][n];
  Ds = new double[nChains][n];
  for (int ichain = 0; ichain<Xs.length; ichain++){ 
    double [] xs  = Xs[ichain];
    double [] d0s = Ds[ichain]; 
    double d = 0;
    for (int i = 0; i<xs.length; i++){
      d0s[i]=d0; xs[i]=d;
      d+=d0;
    }
  }
}

void makeCrossLinks(){
  int n = Xs[0].length;
  crosslinks = new int[ 4*(Xs.length-1)*n ];
  int ilink=0;
  for (int ichain = 1; ichain<Xs.length; ichain++){ 
    for (int i = 0; i<n; i++){
      crosslinks[ilink     ] = ichain-1;  // ichain 
      crosslinks[ilink + 1 ] = i;         // i
      crosslinks[ilink + 2 ] = ichain;     // jchain
      crosslinks[ilink + 3 ] = i;         // j 
      //println( ilink+" "+crosslinks[ilink     ]+" "+crosslinks[ilink+1     ]+" "+crosslinks[ilink + 2 ]+" "+crosslinks[ilink + 3 ] ); 
      ilink+=4;
    }
  }; 
}
