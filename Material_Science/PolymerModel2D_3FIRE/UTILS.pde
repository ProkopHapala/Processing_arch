float x2s(double x){ return ((float)x)*zoom+sz; }
double s2x(float x){ return (x-sz)/zoom; }



int numInBin( Atom a ){
  int count=0;
  while( a != null ){ print(a.id+" ");  count++;    a = a.next;   }
  print("          ");
  return count;
}

void drawWalls(){
  noFill(); 
  fill(255);
  stroke(0);
  rect( x2s(wall_left), x2s(wall_down), x2s(wall_right), x2s(wall_up)  );
};
