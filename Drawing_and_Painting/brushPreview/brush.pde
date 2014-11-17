final int maxn = 1000;
int i = 0;
float [] xs = new float[maxn];
float [] ys = new float[maxn];

class Brush{
  void start(){
  i=0;
  xs[i]=mouseX; ys[i]=mouseY;
  i++;
  }
  void go(){
  xs[i]=mouseX; ys[i]=mouseY;
   gui.beginDraw();
   gui.point(mouseX,mouseY);
   gui.endDraw();
   i++;
   println(i);
  }
  
  void finish(){
   gui.beginDraw();
   gui.background(0x00FFFFFF);
   gui.endDraw();
   
   println("canvas");
   canvas.beginDraw();
   canvas.beginShape();
   for(int ii=0;ii<i; ii++){
   canvas.vertex(xs[ii],ys[ii]);
   //canvas.curveVertex(xs[ii],ys[ii]);
   }
   canvas.endShape();
   canvas.endDraw();
   println("end");
   i=0;
   
  }
  

}
