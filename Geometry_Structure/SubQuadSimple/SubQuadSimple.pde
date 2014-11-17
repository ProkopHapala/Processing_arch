
import java.util.*;

Tool tool;
SubQuadGrid grid;
Area [] areas; 

void setup(){
  size(800,800, P3D );
  noCursor();
  //tool = new LineTool();
  areas=new Area[4];
  areas[0] = new Area( 0, 0xFF000000, 0  ); 
  areas[1] = new Area( 0, 0xFFFF0000, 0  ); 
  areas[2] = new Area( 0, 0xFF00FF00, 0  ); 
  areas[3] = new Area( 0, 0xFF0000FF, 0  ); 
  tool = new OctTool();
  grid = new SubQuadGrid(50,50,    100,0.2,400,400 );
  //println( LEFT+" "+RIGHT+" "+CENTER );
}

void draw(){
  background(255);
  grid.updateCursor();
  grid.plotCursor();
  grid.plot();
  //noLoop();
  tool.plot();
  //println( frameRate );
}

void mouseClicked (  ){ tool.clicked();   }
//void mousePressed (  ){ tool.pressed();   }
//void mouseMoved   (  ){ tool.moved(); }
//void mouseReleased(  ){ tool.pressed();   }
//void mouseDragged (  ){ tool.dragged(); }

void keyPressed(){
  switch (key) {
    case '+': grid.scaleZoom( 1.2   ); break;
    case '-': grid.scaleZoom( 1/1.2 ); break;
    //case 's': saveLines( grid.lines, "lines.txt" ); break;
    //case 'l': grid.lines = loadLines("lines.txt" );  break;
    //case 'n': grid.lines = new LinkedList<GridLine>();
    case '8': grid.sy0+=10; break;
    case '2': grid.sy0-=10; break;
    case '4': grid.sx0-=10; break;
    case '6': grid.sx0+=10; break;
 }
 tool.onKey(key);
}
