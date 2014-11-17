

int nsteps =1000; 
int nsteps2=10000000; 
double dph  = 2.0d*Math.PI/nsteps;
double dph2 = 2.0d*Math.PI/nsteps2;

double2 v;

long startTime, endTime,duration;

void setup(){

  v=new double2(1.0d,0.0d); 
  startTime = System.nanoTime();
  for (int i=0; i<nsteps2; i++){ v.add(i*dph2/nsteps2); }
  endTime = System.nanoTime();
  duration = endTime - startTime;
  println(" v.add()         : " + v + "  "+ ((float)duration/nsteps2) +" ns/op " );
  
  v=new double2(1.0d,0.0d); 
  startTime = System.nanoTime();
  for (int i=0; i<nsteps2; i++){ v.rotate_d1(i*dph2/nsteps2); }
  endTime = System.nanoTime();
  duration = endTime - startTime;
  v=new double2(1.0d,0.0d); 
  for (int i=0; i<nsteps; i++){ v.rotate_d1(dph); } 
  println(" v.rotate_d1()   : " + v + "  "+ ((float)duration/nsteps2) +" ns/op " );
  
  v=new double2(1.0d,0.0d); 
  startTime = System.nanoTime();
  for (int i=0; i<nsteps2; i++){ v.rotate_verlet(i*dph2/nsteps2); }
  endTime = System.nanoTime();
  duration = endTime - startTime;
  v=new double2(1.0d,0.0d); 
  for (int i=0; i<nsteps; i++){ v.rotate_verlet(dph); } 
  println(" v.rotate_verlet()   : " + v + "  "+ ((float)duration/nsteps2) +" ns/op " );
  
  v=new double2(1.0d,0.0d); 
  startTime = System.nanoTime();
  for (int i=0; i<nsteps2; i++){ v.rotate_verlet2(i*dph2/nsteps2); }
  endTime = System.nanoTime();
  duration = endTime - startTime;
  v=new double2(1.0d,0.0d); 
  for (int i=0; i<nsteps; i++){ v.rotate_verlet2(dph); } 
  println(" v.rotate_verlet2()   : " + v + "  "+ ((float)duration/nsteps2) +" ns/op " );
  
  v=new double2(1.0d,0.0d); 
  startTime = System.nanoTime();
  for (int i=0; i<nsteps2; i++){ v.rotate_d3(i*dph2/nsteps2); }
  endTime = System.nanoTime();
  duration = endTime - startTime;
  v=new double2(1.0d,0.0d); 
  for (int i=0; i<nsteps; i++){ v.rotate_d3(dph); } 
  println(" v.rotate_d3()   : " + v + "  "+ ((float)duration/nsteps2) +" ns/op " );
  
  v=new double2(1.0d,0.0d); 
  startTime = System.nanoTime();
  for (int i=0; i<nsteps2; i++){ v.rotate_d3v(i*dph2/nsteps2); }
  endTime = System.nanoTime();
  duration = endTime - startTime;
  v=new double2(1.0d,0.0d); 
  for (int i=0; i<nsteps; i++){ v.rotate_d3v(dph); } 
  println(" v.rotate_d3v()   : " + v + "  "+ ((float)duration/nsteps2) +" ns/op " );
  
  v=new double2(1.0d,0.0d); 
  startTime = System.nanoTime();
  for (int i=0; i<nsteps2; i++){ v.rotate_d5(i*dph2/nsteps2); }
  endTime = System.nanoTime();
  duration = endTime - startTime;
  v=new double2(1.0d,0.0d); 
  for (int i=0; i<nsteps; i++){ v.rotate_d5(dph); } 
  println(" v.rotate_d5()   : " + v + "  "+ ((float)duration/nsteps2) +" ns/op " );
  
  v=new double2(1.0d,0.0d); 
  startTime = System.nanoTime();
  for (int i=0; i<nsteps2; i++){ v.rotate_d7(i*dph2/nsteps2); }
  endTime = System.nanoTime();
  duration = endTime - startTime;
  v=new double2(1.0d,0.0d); 
  for (int i=0; i<nsteps; i++){ v.rotate_d7(dph); } 
  println(" v.rotate_d7()   : " + v + "  "+ ((float)duration/nsteps2) +" ns/op " );
  
  /*
  v=new double2(1.0d,0.0d); 
  startTime = System.nanoTime();
  for (int i=0; i<nsteps2; i++){ v.rotate_tan1(i*dph2/nsteps2); }
  endTime = System.nanoTime();
  duration = endTime - startTime;
  v=new double2(1.0d,0.0d); 
  for (int i=0; i<nsteps; i++){ v.rotate_tan1(dph); } 
  println(" v.rotate_tan1()   : " + v + "  "+ ((float)duration/nsteps2) +" ns/op " );
   */
  v=new double2(1.0d,0.0d); 
  startTime = System.nanoTime();
  for (int i=0; i<nsteps2; i++){ v.rotate(i*dph2/nsteps2); }
  endTime = System.nanoTime();
  duration = endTime - startTime;
  v=new double2(1.0d,0.0d); 
  for (int i=0; i<nsteps; i++){ v.rotate(dph); }
  println(" v.rotate()      : " + v + "  "+ ((float)duration/nsteps2) +" ns/op " );

}
  

