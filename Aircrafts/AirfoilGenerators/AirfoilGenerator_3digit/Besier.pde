final float besier1(float x0, float x1,float x2,float t ){
float tt=1.0-t;
float x = tt*tt*x0 + 2*tt*t*x1  + t*t*x2;
//float x = tt*(tt*x0 + t*x1)  + t*(tt*x1 + t*x2);
return x;
}


final float besier_interpolate(float [] input, float [] output){
int nin = input.length;
int nout = output.length;
print (nin+" "+nout);
for(int i = 2;i<nin;i++){

}

return 0;
}

