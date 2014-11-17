	
final int sz = 512;
final int nps=100000;

float [] ps;
NavierStokesSolver fluidSolver;

  double	visc = 0.0001;
  double	diff = 3.0;
  double	sc = 0.3;
  double limitVelocity = 200;
  double dt = 0.1;
  int oldMouseX = 1, oldMouseY = 1;

void setup() {
    fluidSolver = new NavierStokesSolver();
    //noiseMap(64.0d, fluidSolver.source );
    noiseMap(8.0d, fluidSolver.dens );
    //noiseMap(8.0d, fluidSolver.dens_ );
    ps = new float[4*nps];
    for (int i = 0; i < nps*4; i+=4) {
       float x1=0.1+random(0.8);  float y1=0.1+random(0.8);
       ps[i  ]=x1; ps[i+1]=y1; 
       ps[i+2]=x1+0.05*random(-1.0,1.0); ps[i+3]=y1+0.05*random(-1.0,1.0);
       //ps[i+2]=x1; ps[i+3]=y1;
    }
    size(sz, sz);
    colorMode( RGB, 1.0);
}

public void draw() {
  background(1);
   handleMouseMotion();
   noiseMap(8.0d, fluidSolver.dens );
   for (int i=0; i<2; i++){
     fluidSolver.tick(dt, visc, diff);
     moveWarp();
   }
   paintParticles();
   paintMap(fluidSolver.dens);
   //noLoop();
}

  private void handleMouseMotion() {
    int n = NavierStokesSolver.N;
    float cellHeight = height / n;
    float cellWidth = width / n;
    double mouseDx = mouseX - oldMouseX;
    double mouseDy = mouseY - oldMouseY;
    int cellX = (int) Math.floor(mouseX / cellWidth);
    int cellY = (int) Math.floor(mouseY / cellHeight);
    mouseDx = (abs((float) mouseDx) > limitVelocity) ? Math.signum(mouseDx) * limitVelocity : mouseDx;
    mouseDy = (abs((float) mouseDy) > limitVelocity) ? Math.signum(mouseDy) * limitVelocity : mouseDy;
    for (int ix=-5; ix<5; ix++){ for (int iy=-5; iy<5; iy++){
      int iix = cellX+ix+5;  int iiy = cellY+iy+5;
      float decay = 1.0/(ix*ix+iy*iy + 3); 
      fluidSolver.applyForce(iix%n, iiy%n, mouseDx*decay, mouseDy*decay);
    }}
    oldMouseX = mouseX;
    oldMouseY = mouseY;
  }

	

	


