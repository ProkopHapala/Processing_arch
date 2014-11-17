
import java.util.*;

final int sz = 512;
final int n = 40000;
 
private List<Particle> particles;
Random rand = new Random();
byte [][] Bs; 
 
void setup(){
 particles = new LinkedList<Particle>();
 size ( 512,512 );
 Bs = new byte[sz][sz]; 
 for (int i =0; i<10; i++) { Bs[sz/2 + i][sz/2]=1; }
 for (int i = 0; i < n; i++) {       particles.add( new Particle() );   }
}
 
public void draw() {
 for (int i=0; i<100; i++){
   for (Iterator<Particle> it = particles.iterator(); it.hasNext();) {
     if ( it.next().move() ) { it.remove(); }
   }
 }
 if (particles.isEmpty()) {noLoop();}
}
 
