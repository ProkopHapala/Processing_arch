

static class SuperEllipse{
static  float e1,e2;
static  float xmax, ymin;

static void init ( float e1_,float e2_,  float ymin_ ){
 e1 = e1_;  e2 = e2_;  ymin = ymin_;
 xmax= pow(  1.0  -  pow(ymin,e2),    1.0/e1  );
 println( "SuperEllipse:  e1= " +e1+"  e2= "+ e2 +"  ymin= "+ ymin  +"  xmax=  "+  xmax   );
}
  
static  float eval(float x){
   return pow(  1.0  -  pow(x*xmax,e1),    1.0/e2  );
}

}


