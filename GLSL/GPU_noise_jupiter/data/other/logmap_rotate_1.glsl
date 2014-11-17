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
const float a = 0.1;
const float b = sqrt(1-a*a);
vec2 v = b*p + a*p.yx; return 4*v*(1-v);
}

vec2 mapSum(vec2 p){
	const int n = 10;
	vec2 sum=vec2(0,0);
	for (int i=0; i<n; i++){
		p  = map(p);
		sum+=p;
	}
	//return sum*(1.0/n);
	return p;
	//return p;
}


void main(void){
	vec2 q  = (gl_FragCoord.xy / resolution.xy); 
	vec2 f = mapSum( q*4 -vec2(2.0,2.0) );
    //gl_FragColor = vec4( 0.5+f.x*y, 0.0, 1.0 );
	float ff = 0.5+f.x*f.y;  gl_FragColor = vec4( ff,ff,ff, 1.0 );
}
