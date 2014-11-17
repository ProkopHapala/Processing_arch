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


const int n = 8;
const float a = 0.1;
const float b = 1-a; const float c = 4-a;


vec2 map( vec2 p ){ return c*p*(1 - b*p - a*p.yx); }   // tilted 2D logistic map
vec2 mapSum(vec2 p){ for (int i=0; i<n; i++){  p  = map(p); } return p; }

void main(void){
	vec2 q  = (gl_FragCoord.xy / resolution.xy);
	q = fract( q*4 -vec2(2.0,2.0) );
	q = q*(1-a*q.x*q.y);
	vec2 f = mapSum( q );
    gl_FragColor = vec4( 0.5+f.xy, 0.0, 1.0 );
	//float ff = 0.5+f.x*f.y;  gl_FragColor = vec4( ff,ff,ff, 1.0 );
}
