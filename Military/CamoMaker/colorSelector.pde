

color rndColor(color [] colors, float [] mapping ){
 float f = random(1.0);
 float ff = 0; int i=0;
 for ( i=0; ff<f; i++ ){ ff+=mapping[i]; }
 return colors[i-1]; 
}
