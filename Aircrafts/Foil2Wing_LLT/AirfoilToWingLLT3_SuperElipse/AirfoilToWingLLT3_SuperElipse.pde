
import java.util.*;
import java.util.zip.ZipFile;
import java.util.zip.ZipEntry;
import java.util.Enumeration;
import java.io.*;

HashMap<String,Airfoil> AirfoilData = new HashMap();
Wing_input inWing1;
Wing_Sampled WingS1;


float Vinf = 2.5;
int iMouse = 0;
boolean recompute = true;

void setup(){
size (800,800);
smooth();
textFont(createFont("SansSerif.plain",11,false));
inWing1 = new Wing_input();
inWing1.updateFoils();
inWing1.updateGeom();
//Airfoil foil1 = new Airfoil("2304");
//Airfoil foil2 = new Airfoil("1302");
//Airfoil foil3 = new Airfoil("3306");
//Airfoil foil4 = new Airfoil("2308");
}

void draw(){
  /*
  // Plot airfoil polars
  for (int i=0; i<inWing1.foils[0].Re.length; i++){ 
    float cstep =  255.0/(float)inWing1.foils[0].Re.length;
    stroke( i*50,0,255-i*50  ); fill( i*50,0,255-i*50  );
    plotVsAlfa(inWing1.foils[0].L[i], 1.0);
    //stroke( i*50,255,255-i*50  );    plotVsAlfa(inWing1.foils[0].D[i], 10.0);
    
    line( sx( inWing1.foils[0].alfa0[i]*AlfaScale                    ) -400, 
          sy( 0                                                      ) +400,
          sx( (ALFA_STEP*100.0 + inWing1.foils[0].alfa0[i])*AlfaScale ) -400,
          sy(  ALFA_STEP*100.0 * inWing1.foils[0].CLslope[i]            ) +400 );
          
    text(   inWing1.foils[0].Re[i],20,20+i*20);
  }
  */
  
 // Generate and compute Wing
 if(recompute) { 
  background(255);
  line (400,800,400,0);    line (0,400,800,400);
  SuperEllipse.init( 3, 3,   0.20);
  WingS1 = new Wing_Sampled( 40, 20, 0, 0.5, inWing1 );
  WingS1.updateRe( Vinf );
  WingS1.Init_LLT();
  for (int ialfa=0; ialfa<10; ialfa++ ){
    WingS1.IntegrateAlfa( ialfa );
    WingS1.Solve_LLT( ialfa );
    fill(255,50); rect(0,0,400,400);
    WingS1.Plot( ialfa );
  }
  fill(0); inWing1.plot();
  fill(0);
  stroke( 128, 128, 0 );  plotPolar ( WingS1.ClP_tot, WingS1.CdP_tot );
  stroke(0 , 128,128  );  plotPolar ( WingS1.ClW_tot, WingS1.CdW_tot );
  stroke(0      );  plotPolar ( WingS1.Cl_tot, WingS1.Cd_tot );
  int n = WingS1.foil1.length/2;  
  int iRe1 = WingS1.iRe1[0];   int iRe2 = WingS1.iRe2[n]+1;
  println(" Re_tip > "+WingS1.foil1[0].Re[iRe1]+"   Re_root < "+WingS1.foil2[0].Re[iRe2]);
  stroke(0,0,255);  plotPolar ( WingS1.foil1[0].L[iRe1], WingS1.foil1[0].D[iRe1] );
  stroke(255,0,0);  plotPolar ( WingS1.foil2[n].L[iRe2], WingS1.foil2[n].D[iRe2] );
  recompute = false;
 }
 
 //noLoop();
}



void mousePressed(){
float drmin = 10000000;
for(int i=0;i<inWing1.chord.length;i++){
  float dx= sx(-inWing1.yChord[i]) - mouseX;     float dy= sy(inWing1.chord[i]) - mouseY;  float dr=sqrt(dx*dx+dy*dy);
  if(dr<drmin){iMouse=i;drmin=dr;}
}
//println(iMouse);
}


void mouseReleased(){
  float x = - (mouseX-400)/ 390.0; float y = (400-mouseY)/390.0; 
  //y=max(y,0);x=max(x,0);
  //if(iMouse==0){x=0.0;}
  inWing1.yChord[iMouse] = x;     
  inWing1.chord[iMouse]  = y; 
  inWing1.updateGeom();
  fill(255); rect(400,400,400,400);
  recompute = true;
}

