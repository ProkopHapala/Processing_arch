
import java.io.*;
 
int iShader = 34;
PShader [] shaders;
String  [] shaderNames;

void setup() {
  size(800, 800, P2D);
  noStroke();
  loadShaders();
  println( " ==== "+ shaderNames[iShader] );  
}

void draw() {
  background(0);
  shader(shaders[iShader]); 
  shaders[iShader].set("resolution", float(width), float(height));
  shaders[iShader].set("mouse", float(mouseX), float(mouseY));
  shaders[iShader].set("time", (float)(millis()/1000.0));
  rect(0, 0, width, height);
  frame.setTitle("frame: " + frameCount + " - fps: " + frameRate);     
}

void keyPressed(){
 if (key==']'){ iShader=(iShader+shaders.length+1)%shaders.length;  println(" Current shader is: "+  shaderNames[ iShader ] ); }
 if (key=='['){ iShader=(iShader+shaders.length-1)%shaders.length;  println(" Current shader is: "+  shaderNames[ iShader ] ); }
}

void loadShaders(){
  ArrayList<File> files    = listFilesInFolder( new File (sketchPath, "data"), ".glsl" );
  int nfiles         = files.size();
  shaders     = new PShader [nfiles ];
  shaderNames = new String  [nfiles ];
  int i = 0;
  for( File f : files){ 
   String name = f.getName(); 
   shaderNames [i] = name.substring(0,name.length()-5); 
   System.out.print( i+" "+shaderNames [i]+"   " );
   shaders     [i] = loadShader( name );
   println(" ");
   i++; 
  } 
}

// ========  find all *.glsl files ============
  ArrayList<File> listFilesInFolder(final File folder, String extension) {
    ArrayList<File> list = new ArrayList(); 
    File [] files = folder.listFiles();
    for (final File fileEntry : files ) {
       String name = fileEntry.getName();
       if (  name.toLowerCase().endsWith(extension) ) {
            //System.out.println( name );
            list.add( fileEntry );
       }     
    }
    return list;
  }

