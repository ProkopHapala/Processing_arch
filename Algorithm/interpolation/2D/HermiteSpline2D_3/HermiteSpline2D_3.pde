
int n = 7;
int nsub = 50;   float d = 1.0/nsub;

float [][][] ps = new float[n][n][9];

PImage img;
static float [] pout= {0,0,0};

void setup(){
  
  size( 600,600 );
  
  for (int i=0; i<ps.length; i++ ){
    for (int j=0; j<ps[0].length; j++ ){
      ps[i][j][0] = random(1.0);
      ps[i][j][3] = random(1.0);
      ps[i][j][6] = random(1.0);
      //ps[i][j][0] = 0.5;
      //ps[i][j][1] = random(-1.0,1.0);
      //ps[i][j][2] = random(-1.0,1.0);
    }    
  }
  
  for (int i=1; i<ps.length-1; i++ ){
    for (int j=1; j<ps[0].length-1; j++ ){
      ps[i][j][1] = 0.5*(ps[i+1][j][0] - ps[i-1][j][0]);
      ps[i][j][2] = 0.5*(ps[i][j+1][0] - ps[i][j-1][0]);
      ps[i][j][4] = 0.5*(ps[i+1][j][3] - ps[i-1][j][3]);
      ps[i][j][5] = 0.5*(ps[i][j+1][3] - ps[i][j-1][3]);
      ps[i][j][7] = 0.5*(ps[i+1][j][6] - ps[i-1][j][6]);
      ps[i][j][8] = 0.5*(ps[i][j+1][6] - ps[i][j-1][6]);
    }    
  }
  
  plotInterpolation();
  img = get(0, 0, width, height);
  //plotPoints();  
}

void draw(){

  if(mousePressed){    
    //background(255);
    //plotInterpolation();
    image( img, 0,0  );
    //plotPoints();
    //plotXscan();  
    //plotYscan(); 
  }
  
}

