
import java.util.Map;

//static double Gaccel_x   = 0.0981d;
//static double Gaccel_y   = 0.0981d;
//static double Gaccel_z   = 0.0981d;

//final static double [] Gaccel = { 0.0d,0.0d, 0.0d };
//final static double [] Gaccel = { 0.0d,-10.0d, 0.0d };
//final static double [] Gaccel = { 0.0d,0.0d, -10.0d };
final static double [] Gaccel = { 0.0d,0.0d, 0.0d };

static double k     = 1000.00d; 
static double kBend = 0.1d;

//static double damp     = 0.999d; 
static double dt       = 0.0001d;
static int    perFrame = 50;

Vertex [] verticles;
Edge   [] edges;


static int n1_=40;
static int n2_=20;
//static int [] fix_x = new int[]{ 0 };
//static int [] fix_y = new int[]{ 0 };
//static int [] fix_z = new int[]{ 0 };
//static int [] fix_x = new int[]{ 0, n2-1, (n1-1)*n2, n1*n2-1 };
//static int [] fix_y = new int[]{ 0, n2-1, (n1-1)*n2, n1*n2-1 };
//static int [] fix_z = new int[]{ 0, n2-1, (n1-1)*n2, n1*n2-1 };

/*
static int [] fix_x = new int[]{ 0, n2_-1, (n1_-1)*n2_ };
static int [] fix_y = new int[]{ 0, n2_-1, (n1_-1)*n2_ };
static int [] fix_z = new int[]{ 0, n2_-1, (n1_-1)*n2_ };
*/

static int [] fix_x,fix_y,fix_z;

double [] boundary_x0,boundary_y0,boundary_z0; 


static int sz = 400;
static float zoom = 100;
static float rotspeed = PI/50;
float fscale = 1.0;
float fbreak = 1.0;
static float  pitch =PI*0.5;
static float  yaw   =-PI*0.5;
//static float  pitch =;
//static float  yaw   =0;

boolean stop=false;


void setup(){
  size(2*sz,2*sz,P3D);
  colorMode(RGB,1.0);
  ortho();
   hint(DISABLE_DEPTH_TEST);
  //makePlate( 1, 1, n1_,n2_ );
  makeTube( 2.5, 0.25, n1_,n2_ );
  
  fix_x = new int[n2_]; fix_y = new int[n2_]; fix_z = new int[n2_];
  for (int i=0; i<n2_; i++ ){
    fix_x[i]=i; fix_y[i]=i; fix_z[i]=i;
  }
  
  //println( "fix_x: "+vec2string( fix_x ) );
  //println( "fix_y: "+vec2string( fix_y ) );
  //println( "fix_z: "+vec2string( fix_z ) );
  BoundaryInitialPos();
  //println( "boundary_x0: "+vec2string( boundary_x0 ) );
  //println( "boundary_y0: "+vec2string( boundary_y0 ) );
  //println( "boundary_z0: "+vec2string( boundary_z0 ) );
  println( "FIRE_dt = "+ FIRE_dt );
}

void draw(){
  translate(sz,sz,sz);
  scale(zoom,-zoom,zoom);
  rotateY( pitch   );
  rotateX( yaw );
  
  if(!stop){
    for (int i=0; i<perFrame; i++){
      for ( Vertex ver : verticles){ ver.cleanForce(); }
      
      for ( Edge ed : edges)     { ed.assertStrainForce(); }
      //for ( Edge ed : edges)     { ed.assertBendForce( i==0 );  }
      for ( Edge ed : edges)     { ed.assertBendForce( true );  }
      // external force
      for(int iv=(n1_-1)*n2_;iv<n1_*n2_;iv++){ verticles[iv].fx+=0; verticles[iv].fy+=0.3; verticles[iv].fz+=0;   }
      setBoundaryVF( );
      if( (frameCount==0)&&(i==0) ){ for ( Vertex ver : verticles){ ver.move(FIRE_dt); }      }
      else                         { move_FIRE();                                        }
      //print( FIRE_dt+" " );
      //for ( Vertex ver : verticles){ ver.move(dt); } 
      setBoundaryPos( );
    }
  }
 
  background(1.0);
  stroke(0.0,0.0,0.0); strokeWeight(0.01); for ( Edge   ed  : edges     ){ ed .paint();  }
  stroke(0.0,0.0,0.0); for ( Vertex ver : verticles ){ ver.paint(); } 
  
  //println("========="+frameCount);
  //println( FIRE_dt );
  //noLoop();
}


void keyPressed(){
  if(key=='4'){ pitch+=rotspeed; }
  if(key=='6'){ pitch-=rotspeed; }
  if(key=='8'){ yaw+=rotspeed; }
  if(key=='2'){ yaw-=rotspeed; }
  if(key=='+'){ zoom*=1.1;  }
  if(key=='-'){ zoom/=1.1;  }
  if(key==' '){ stop=!stop;  }
  if(key=='/'){ perFrame/=2; }
  if(key=='*'){ perFrame*=2; }
}
