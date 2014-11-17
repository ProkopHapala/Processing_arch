

class Mouse{
  boolean [] isDown;
  int lastDown,lastUp;
  PVector [] downPos,upPos;
  Mouse(){
    isDown    = new boolean[4];
    downPos   = new PVector[4];
    upPos     = new PVector[4];
    for(int i=0;i<4;i++){       downPos[i]= new PVector();  upPos[i]= new PVector();   }
  }
  void pressed(MouseEvent e){
     //println(e);
     int button = e.getButton();
     int ibutton=-1;
     switch(button){
       case LEFT:   ibutton = 1; break;
       case RIGHT:  ibutton = 2; break;
       case CENTER: ibutton = 3; break;
     }
     println (button+" "+ibutton);
     isDown [ibutton] = true;
     downPos[ibutton].set(  wX(e.getX()), wY(e.getY()),0);
     println( ibutton+" "+downPos[ibutton] );
     downPos[0] = downPos[ibutton];
     isDown [0] = true;
     lastDown = ibutton;
  }
  
  void released(MouseEvent e){
     int button = e.getButton();
     int ibutton=-1;
     switch(button){
       case LEFT:   ibutton = 1; break;
       case RIGHT:  ibutton = 2; break;
       case CENTER: ibutton = 3; break;
     }
     isDown[ibutton] = false;
     upPos [ibutton].set(  wX(e.getX()),wY(e.getY()),0);
     upPos[0] = upPos[ibutton];
     if (!( isDown[0] || isDown[1] || isDown[2] )) isDown[0] = false;
     lastUp = ibutton;
  }
  
  void paint( int button, color c ){
    stroke(c);
    //point( sX(downPos[button].x), sY(downPos[button].y)  );
    line( sX(downPos[button].x) , sY(downPos[button].y),   mouseX, mouseY);
  }
  
  String toString(){
    String s;
    s = lastDown+" "+lastUp+" | ";
    for(int i=0;i<4;i++){ s = s + isDown[i]  +" "; } s = s+" | ";
    for(int i=0;i<4;i++){ s = s + downPos[i] +" "; } s = s+" | ";
    for(int i=0;i<4;i++){ s = s +   upPos[i] +" "; }
    return s;
  }
}


// =========  Runtime handling

Mouse mouse;

void mousePressed(MouseEvent e) {
  mouse.pressed(e);
  int button = e.getButton(); 
  if(button==LEFT){     cmd_SelectArmy();    }
}

void mouseReleased(MouseEvent e) {
  mouse.released(e);
  int button = e.getButton(); 
  if(button==RIGHT){   if(myReg!=null) myReg.cmd_move( mouse.downPos[2], mouse.upPos[2] );   }
}

// ======== Mouse Commands

void cmd_SelectArmy(){
  float rbest = 1000000000.0;
  println( mouse.downPos[1] );
  //ellipse( sX( mouse.downPos[1].x ), sY( mouse.downPos[1].y ), 5,5  );
  for (Regiment reg : myArmy){
     float r2 = distSq ( reg.Pcenter, mouse.downPos[1] );
     if ( r2<rbest ){ rbest=r2; myReg = reg; }
  } 
}


