// Created by inigo quilez - iq/2013
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.


#ifdef GL_ES
precision highp float;
#endif
#define PROCESSING_COLOR_SHADER
uniform float time;
uniform vec2 resolution;
uniform vec2 mouse;


//vec2 map( vec2 p ){ return 4*p*(1-p); }

vec2 map( vec2 p ){ 
	float r2 = 1/(0.4+dot(p,p));
	return p*(1-p)*r2*(1-r2); 
}

vec2 mapSum(vec2 p){
	vec2 sum=vec2(0,0);
	for (int i=0; i<10; i++){
		p  = map(p);
		sum+=p;
	}
	return sum;
}


void main(void){
	vec2 q  = (gl_FragCoord.xy / resolution.xy); 
	vec2 f = mapSum( q*4 -vec2(2.0,2.0) );
    gl_FragColor = vec4( 0.5+f.xy, 0.0, 1.0 );
}
