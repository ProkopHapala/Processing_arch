
import java.util.*;

Tool tool;
Grid grid;

void setup(){
  size(800,800);
  noCursor();
  tool = new LineTool();
  grid = new Grid(100,0.2,400,400 );
}

void draw(){
  background(255);
  grid.updateCursor();
  grid.plotCursor();
  grid.plot();
  //noLoop();
  tool.plot();
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
    case 's': saveLines( grid.lines, "lines.txt" ); break;
    case 'l': grid.lines = loadLines("lines.txt" ); break;
    case 'n': grid.lines = new LinkedList<GridLine>(); break;
    case '8': grid.sy0+=10; break;
    case '2': grid.sy0-=10; break;
    case '4': grid.sx0-=10; break;
    case '6': grid.sx0+=10; break;
 }
 tool.onKey(key);
}
