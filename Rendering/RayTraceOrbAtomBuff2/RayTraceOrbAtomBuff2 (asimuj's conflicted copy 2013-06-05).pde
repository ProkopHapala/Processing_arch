
final int sz=256;

int natoms = 40;
double3 []   atoms,atomsBuff;
double  [][] coefs,coefsBuff;

double accuracy = 0.01;
double dpos     = 0.25;
double isolevel = 0.01;
static double decay    = 0.5;
double Rcut = -decay*Math.log10(isolevel/natoms);

double zoom     = 8.0;
double Fzoom    = 20.0;

double zmin=-8;
double zmax=+5;

double3 lightDir;

static int atomEvals;
long t1; float T;
int ipass=0;

final int sups = 16; 

float c_shine   = 1.0;
float c_ambient = 0.2;
float c_diffuse = 0.8;

void setup(){
  size(2*sz,2*sz);
  colorMode(RGB,1.0);
  frameRate(100);
  
  lightDir = new double3( 1.0, 1.0, 2.0 ); lightDir.normalize();
  atoms = new double3[natoms];
  coefs = new double[natoms][4];
  ZBuff = new double[height][width];
  CBuff = new color [height][width];
  natomBuff = new int[height/sups+1][width/sups+1];
  iatomBuff = new int[height/sups+1][width/sups+1][natoms];
  //atomsBuff = new double3[height/sups][width/sups][];
  //coefsBuff = new double [height/sups][width/sups][][];
  atomsBuff = new double3 [natoms];
  coefsBuff = new double  [natoms][];
  for (int i=0;i<atoms.length; i++){
    atoms[i] = new double3( random(-5,5), random(-5,5), random(-5,5) );
    //atoms[i] = new double3( random(-5,5), random(-5,5), 0 );
    //atoms[i] = new double3( 4*(i&1)-1, 2*(i&2)-1, 0 );
    coefs[i] = new double[4]; 
    //coefs[i][0] = ((i&1)^((i&2)>>1)) - 0.5;
    coefs[i][0] = random(-1,1); 
    coefs[i][1] = random(-1,1); 
    coefs[i][2] = random(-1,1); 
    coefs[i][3] = random(-1,1); 
  }
  zmin =1000000; zmax =-1000000; 
  for (int i=0;i<atoms.length; i++){
    zmin = Math.min( zmin, atoms[i].z - Rcut );
    zmax = Math.max( zmax, atoms[i].z + Rcut );
  }
  for (int iy = 0; iy < height; iy++) {  for (int ix = 0; ix < width; ix++) {   
    ZBuff[iy][ix]=zmin;  }}  
  for (int jy = 0; jy < height/sups-1; jy++) {  for (int jx = 0; jx < width/sups-1; jx++) {
    natomBuff[jy][jx] = natoms; }}
  println(" Rcut "+Rcut +" zmin "+zmin+" zmax "+zmax);
  // temporary variables
  pos=new double3();  grad=new double3(); posd=new double3(); dp=new double3();
}

void draw(){
  //background(0);
  if( ipass==0 ){
    Render( 0, 0, sups, sups );       println( "  Full  Pass  nbuff_average= "+ ( nbuff_average/ ( width*height/ (sups*sups)   ) ) );
    findRelevantAtoms();              println( "  find  Pass  nbuff_average= "+ ( nbuff_average/ ( width*height/ (sups*sups)   ) ) );
    relevantAtomsInclusion( );        println( "  check Pass  nbuff_average= "+ ( nbuff_average/ ( width*height/ (sups*sups)   ) ) );
    noStroke();
    for (int iy = 0; iy < height-sups; iy+=sups) {       for (int ix = 0; ix < width-sups; ix+=sups) {
          fill(CBuff[iy][ix]); rect( ix-sups/2, iy-sups/2, sups,sups);   
          double ZZ = Math.min ( Math.min( ZBuff[iy][ix], ZBuff[iy+sups][ix+sups] ), Math.min( ZBuff[iy+sups][ix], ZBuff[iy][ix+sups] ) );
          for (int jy = 0; jy < sups; jy++) {     for (int jx = 0; jx < sups; jx++) { ZBuff[iy+jy][ix+jx] = ZZ; }}
      }}
  } else {
     stroke(0);
     Render( ipass%sups, (ipass/sups)%sups, sups, sups );
  }
  nbuff_average/=(width*height/(sups*sups));
  ipass++;
  //noLoop();
  if(ipass >= (sups*sups)) noLoop();
  println(" atomEvals = "+atomEvals+"  in " +T+ " [s] => " + ( 1e-6*atomEvals/T) + " Mops   nbuff_average= "+nbuff_average ); 
}
