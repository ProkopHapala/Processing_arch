

float zoom=20;
int ngrid=20;

Lattice2D lat1,lat2;


void setup(){
  size(800,800);
  translate(400,400);
  lat1 = new Lattice2D( 1.0, PI/3 );
  //lat2 = new Lattice2D( sqrt(3)/2, PI/3 );
  //lat2.rotate(PI/6);
  
  //lat2 = new Lattice2D( lat1, 1, 1/2.0 );
  //lat2 = new Lattice2D( lat1, 1, 1/3.0 );
  //lat2 = new Lattice2D( lat1, 1, 1/4.0 );
  //lat2 = new Lattice2D( lat1, 1, 1/5.0 );
  
  lat2 = new Lattice2D( lat1, 1, 2.0/5.0 );
  
  
  //lat2 = new Lattice2D( lat1, 1/4.0, 3/4.0 );
  //lat2 = new Lattice2D( lat1, 1/4.0, 2/4.0 );
  
  //lat2 = new Lattice2D( lat1, 1/3.0, 2/3.0 );
  //lat2 = new Lattice2D( lat1, 4/3.0, 1 );
  
  //lat2 = new Lattice2D( lat1, 1/2, 2/3.0 );
  //lat2 = new Lattice2D( lat1, 4/3, 1 );
  
  
  //stroke(0,0,255);  lat2.plotVecs(); 
  //stroke(255,0,0); lat1.plotVecs(); 

  //stroke(0,0,255); lat2.plotLines();  
  //stroke(255,0,0); lat1.plotLines();
  
  //strokeWeight(2);
  stroke(0,0,255); lat2.plotTriGrid();  
  stroke(255,0,0); lat1.plotTriGrid();
   

 stroke(0,0,255); strokeWeight(7); lat2.plotPoints();
 stroke(255,0,0); strokeWeight(4); lat1.plotPoints();   


   
}
