
final int [] mdx = {-1, 0, 1, -1,  1,  -1, 0, 1}; 
final int [] mdy = {-1,-1,-1,  0,  0,   1, 1, 1};
 
 
boolean trace( int y0, int x0 ){
int x=x0; int y=y0;
if( F[x0][y0]>0 ){return false;}
for (int i=0; i<diffmax; i++){
  int rnd = int( random(mdx.length) );
  int ny=(y+mdy[rnd])%n;
  int nx=(x+mdx[rnd])%n;
  if (ny<0)ny=n-1; if (nx<0)nx=n-1;
  //println( rnd +" "+ (nx-x) +" "+ (ny-y) +" "+ x +" "+ y );
  if (F[nx][ny]>0){  F[x][y]=nparticles; nparticles++; return true; }
  x=nx;y=ny; 
}
return false;
};
