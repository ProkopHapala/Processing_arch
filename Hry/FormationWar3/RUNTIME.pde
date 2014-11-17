void draw(){
  background(0.8);
  
  // ===== Update scene
  if (!stopped){
    for (Regiment rg : Army1){     rg.move();     }
    for (Regiment rg : Army2){     rg.move();     }
  }
  
  // ===== Paint scene  

  pushMatrix();   // world space
  translate( cX, cY );
  scale    ( zoom  );
    pushMatrix();     // map view space
     scale ( mapScale );
     translate(-mapX0,-mapY0);
     //shape(mapView);   // replace this by bilinear interpolated texture????
     image(mapTexture,-0.5,-0.5);
    popMatrix();
    for (Regiment rg : Army1){ rg.paint(); }
    for (Regiment rg : Army2){ rg.paint(); }
    if(mouse.isDown[2]){ plotMap( altitude,  100, mouse.downPos[3], mouse.upPos[3] );  } 
  popMatrix();
 
  if(myArmy==Army1){ fill(0xFF0000FF); }else{  fill(0xFFFF0000); } noStroke(); rect(10,10,10,10);
  if(mouse.isDown[2]) mouse.paint( 2, 0x8000FF00 );
  ellipse( sX(myReg.Pcenter.x), sY(myReg.Pcenter.y), 5, 5 );
}

// ==== keyboard

void keyPressed(){
  if (key=='n'){ myReg=null; if(myArmy==Army1){myArmy=Army2;}else{ myArmy=Army1; }}
  if (key==' '){ stopped=!stopped;  }
  if (key=='+'){ dt*=timeZoomRate;  }
  if (key=='-'){ dt/=timeZoomRate;  }
  if (key=='f'){ myReg.facing*=-1; }
}
