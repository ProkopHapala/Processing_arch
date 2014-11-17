class VisualKink{
float L1, L2;
float x,y;

Nod a,b;

VisualKink(Nod a, Nod b, float L1, float L2){
 this.a=a; this.b=b; this.L1=L1; this.L2=L2;
}

void update(){
  float dx = (float)(b.x-a.x);  float dy = (float)(b.y-a.y);
  float CC = dx*dx + dy*dy;
  float C  = sqrt(CC);
  dx/=C; dy/=C;
  if (CC < (L1+L2)){
    float L1L1 = L1*L1;
    float CL1 = 0.5*(CC + L1L1 - L2*L2)/C;
    float vv = L1L1 - (CL1*CL1);
    float v = sqrt(vv);
    //println( "L1= "+L1+" L2= "+L2+" C= "+C+" CL1= "+CL1+" v= "+v );
    x = (float)a.x + dx*CL1 - dy*v;
    y = (float)a.y + dy*CL1 + dx*v;
  }else{
    x = (float)a.x + dx*L1/C;
    y = (float)a.y + dy*L1/C;
  }
}

void view( World W ){
  line (W.x(a.x),W.y(a.y),W.x(x),W.y(y));
  line (W.x(b.x),W.y(b.y),W.x(x),W.y(y));
}

}
