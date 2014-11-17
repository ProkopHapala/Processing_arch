
final static int sz=500;
final static int sz2int = Integer.MAX_VALUE/sz;

Nod A = new Nod();
float [][] buff;

int nNods;
int nFilled;
int ops;

float ox,oy;
float fps=0;


void setup(){
 size(sz,sz); 
 buff = new float [sz][sz];
 println(Integer.SIZE);
 println(Integer.MAX_VALUE );
 fillTree(A);
}

void draw(){
ops = 0;
  println("===========");
background(0);
int start = millis();
render(mouseX-sz*0.5,mouseY-sz*0.5);
int end = millis();
//fps = int(0.9*fps + 0.1f*1000.0f/(end-start));
fps = 1000.0f/(end-start);

println(n+" "+nNods + "  "+ nFilled+" ops: "+ops+" fps:"+fps);
}
