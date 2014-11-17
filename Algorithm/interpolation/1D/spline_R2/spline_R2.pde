/*

purpose of this spline interpolation is dependence on squere of radius, without explicit computation of radius using 
squere root 

*/


float splineR2( float r2 ){
 return sq(1.0-r2);
}

float interR2( float ar2, float br2,   float fa, float fb ){
 float wa = 1.0/(ar2+0.00001); 
 float wb = 1.0/(br2+0.00001);
 return  ( fa*wa + fb*wb ) / (wa + wb);
}


void setup(){
size (512,512);


for (int i=0;i<512;i++){
 stroke(0  ,0  ,0  ); point(i,1+ 256* splineR2( sq(i/512.0) )    );
 stroke(255,0  ,0  ); point(i, 1+ 256*interR2 ( sq(i/512.0),  sq((512-i)/512.0), 1, 0 ) );
}


for (int i=0;i<512;i++){

}






}
