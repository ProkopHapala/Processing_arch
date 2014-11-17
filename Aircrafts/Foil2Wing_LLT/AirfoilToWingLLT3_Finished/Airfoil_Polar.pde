
import java.util.Arrays;

float  ALFA_STEP = 0.1;

class Airfoil{

String name;

int   [] KnownUpTo;
float [] Re;
float [] CLslope;
float [] alfa0;

float [][] L;
float [][] D;
float [][] Cm;

float cL, cD;
float cCLslope, cAlfa0;

void interpolate(int iRe, float cRe, float alfa){
  float tRe=(cRe - Re[iRe])/(Re[iRe+1] - Re[iRe]);
  int ialfa = int(alfa / ALFA_STEP);
//  println(iRe+"  "+tRe+"  "+ alfa+" "+ialfa+"     "+KnownUpTo[iRe]);
  cL=Float.NaN; cD=Float.NaN;
  if(ialfa<(KnownUpTo[iRe]-1)){
    float talfa = (alfa-ialfa*ALFA_STEP)/ALFA_STEP;
  // println(cRe+"   "+tRe+"     ||     "+alfa+"  "+ talfa);
    float tt1 = (1.0-talfa)*(1.0-tRe);   // precompute bilinear interpolation coefficients
    float tt2 = (1.0-talfa)*     tRe ;
    float tt3 =      talfa *(1.0-tRe);
    float tt4 =      talfa *     tRe;
    cL =  tt1* L[iRe][ialfa]   + tt2 * L[iRe+1][ialfa]  + tt3* L[iRe][ialfa+1] + tt4*L[iRe+1][ialfa+1]; 
    cD =  tt1* D[iRe][ialfa]   + tt2 * D[iRe+1][ialfa]  + tt3* D[iRe][ialfa+1] + tt4*D[iRe+1][ialfa+1]; 
  }
}

void interpolateLinearLift(int iRe, float cRe){
  float tRe=(cRe - Re[iRe])/(Re[iRe+1] - Re[iRe]);
  cCLslope = (1.0-tRe)*CLslope[iRe]  +  tRe*CLslope[iRe+1];
  cAlfa0   = (1.0-tRe)*alfa0  [iRe]  +  tRe*alfa0  [iRe+1];
};

void LinearizeLift( int ialfa1, int ialfa2){
  CLslope = new float[Re.length];
  alfa0   = new float[Re.length];
  for (int iRe=0; iRe<Re.length; iRe++){
    if (L[iRe]!=null){
      CLslope[iRe] = ( L[iRe][ialfa2] - L[iRe][ialfa1] ) / (ALFA_STEP*(ialfa2 - ialfa1));
      alfa0[iRe]   =  ALFA_STEP*ialfa1 - L[iRe][ialfa1]/CLslope[iRe];  
      //println( Re[iRe]+"    "+  CLslope[iRe]+"   "+ alfa0[iRe]   ); 
    } else{
      CLslope[iRe] = Float.NaN; alfa0[iRe]= Float.NaN;
    }
  }
};


//   =========================
//      Load From Stream
//   =========================

void LoadFromStream( int iRe, InputStream stream  ){
  try {
    BufferedReader reader = new BufferedReader(new InputStreamReader(stream));
    String row;
    reader.readLine();  reader.readLine(); reader.readLine();
    row = reader.readLine(); name = splitTokens(row)[4];
    reader.readLine();   reader.readLine();  reader.readLine(); reader.readLine();
    row = reader.readLine(); Re[iRe] = float( splitTokens(row)[5])*1000000;
    //println( "name: "+name+" Re:  "+Re[iRe] );
    print( "   "+Re[iRe] );
    reader.readLine();   reader.readLine();  reader.readLine();
    L[iRe] = new float[101];   D[iRe] = new float[101]; Cm[iRe] = new float[101]; KnownUpTo[iRe]=0;   
    for(int i=0;i<101;i++){ L[iRe][i]=Float.NaN;  D[iRe][i]=Float.NaN; Cm[iRe][i]=Float.NaN;    }    
    while(( row = reader.readLine()) != null) {
      String [] words = splitTokens(row);
      if(words.length==7){
        float alfa = float(words[0]);
        int ii = round ( alfa / ALFA_STEP);
        if(ii<101){
          L[iRe][ii]  = float(words[1]);
          D[iRe][ii]  = float(words[2]);
          Cm[iRe][ii] = float(words[4]);
          KnownUpTo[iRe]++;
        } else{break;}
      }else{break;}
    }  
    } catch (IOException e) {
       println("Error: " + e);
    }
}

//   =========================
//      Load From Zip
//   =========================

void LoadFromZip() {
        print ("Loading Airfoil "+name+"  Re: "); 
        String zipname = dataPath("../../../Airfoil_Polars.zip");
        try {
            ZipFile zipFile = new ZipFile(zipname);
            Enumeration enumeration = zipFile.entries();
            int i=0;
            LinkedList<ZipEntry> entries = new LinkedList(); 
            while (enumeration.hasMoreElements()) {
                ZipEntry ze = (ZipEntry) enumeration.nextElement();
                  //print("Loading: " + zipEntry.getName() + "  ");
                  String fileName = ze.getName();
                  String foilName = fileName.substring(8,12);
                  //println (foilName +   "   "  +   Re);
                  if (   foilName.equals(name)){
                    //println ("===="+foilName +   "   "  +   Re);
                    entries.add(ze);
                    i++;   
                  }        
            }
            println("nRe: "+i);
            Re       = new float[i];
            KnownUpTo= new int[i];
            L  = new float[i][];
            D  = new float[i][];
            Cm = new float[i][];
            i =0;
            for (ZipEntry ze : entries){
                 InputStream stream = zipFile.getInputStream(ze);
                 LoadFromStream(i,stream);     
                 stream.close();
                 i++;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        println();
}

// ====================
//    Constructor
// ====================
Airfoil(String name){
  this.name = name;
  LoadFromZip();
  LinearizeLift( 2, 30);
  /*
  println(" ====== "+ name);
  for (int ialfa=0; ialfa<L[0].length;ialfa++){
    print (ALFA_STEP*ialfa+"   ");
    for (int i=0; i<Re.length;i++){
     //println(i+" "+Re[i]);
     print(L[iRe][ialfa]+"   ");
   }
   println();
  }
  */
}


}
