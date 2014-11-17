
class vector{
float x,y,z;
vector(float x_,float y_, float z_){
x=x_;y=y_;z=z_;
}

 String toString() {
   return "( "+x+" "+y+" "+z+")";
 }
}

class byX implements Comparator {
  int compare(Object a, Object b) {
    return  int(     (  ((vector)b).x - ((vector)a ).x  )* 10000000            );
    }
 }

class byY implements Comparator {
  int compare(Object a, Object b) {
    return int((  ((vector)b).y-((vector)a).y  ) *  10000000  );
    }
 }
 
static class byZ implements Comparator {
  int compare(Object a, Object b) {
    return int((    ((vector)b).y-((vector)a).y ) * 10000000 );
    }
 }

