import java.util.*;

int n = 10;
vector [] myvecs = new vector[n];
vector [] xsorted = new vector[n];
vector [] ysorted = new vector[n];
vector [] zsorted = new vector[n];

void setup(){
for (int i = 0;i<n; i++){
myvecs[i]= new vector(random(1),random(1),random(1));
}


println (myvecs);

println("ordered ByX: ");
arrayCopy(myvecs,xsorted);
Arrays.sort(xsorted, new byX());
println (xsorted);

println("ordered ByY: ");
arrayCopy(myvecs,ysorted);
Arrays.sort(ysorted, new byY());
println (ysorted);

println("ordered ByZ: ");
arrayCopy(myvecs,zsorted);
Arrays.sort(zsorted, new byZ() );
println (zsorted);
}

