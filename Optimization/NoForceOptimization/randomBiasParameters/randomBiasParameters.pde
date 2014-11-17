

int nEvaluations;
float step = 0.2;

float Econdition = 0.03;

int maxIter=1000;

PrintWriter out;
PImage Eimage;
boolean stop=false;
Relaxator R;

void setup(){
size(sz2,sz2,P2D);
//size(sz2,sz2);
//frameRate(10);
initEmap();
//paintEmap();
Eimage = get();

//R = new Relaxator(  0.25,  0.0  );
R = new Relaxator_2(  0.5,  0.0  );
R.paint();
nEvaluations = 0;

 dir_decay=0.1;
//   dir_comp=0.0;
   step= 0.02; 
out =  createWriter("out.txt");   

}

void draw(){
  set(0,0,Eimage);
  /*
  if ( !stop ){
    R.move();
    R.paint();
  }
  */
  
    //     print( dir_decay +"    " );
    // out.print( dir_decay +"    " );
    //     print( dir_comp +"    " );
    // out.print( dir_comp +"    " );
         print( step +"    " );
     out.print( step +"    " );
    RelaxStatistics();
         println( iter_average +"  "+ iter_min +"  "+  iter_max );
     out.println( iter_average +"  "+ iter_min +"  "+  iter_max );
     
  //save( nf(step,1,2)+".png");
 
  //dir_decay+=0.025; 
  //dir_comp+=0.1;
  step *= 1.2;
  //if (dir_decay>=0.95) {
  //if (dir_comp>4.0) {
  if (step>0.8) {
    out.flush();   out.close();
    noLoop();
  }
  
}

void mousePressed(){
  R.init( (mouseX-sz)/(float)sz, (mouseY-sz)/(float)sz );
}

void keyPressed(){
if(key==' '){ stop=!stop; // image(Eimage, 0, 0); 
}
if(key=='s'){ save( year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute()+"_"+second()+".png" );}
}
