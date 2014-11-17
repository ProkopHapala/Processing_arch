// Created by inigo quilez - iq/2013
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.


#ifdef GL_ES
precision highp float;
#endif
#define PROCESSING_COLOR_SHADER
uniform float time;
uniform vec2 resolution;
uniform vec2 mouse;


const int n = 6;
const float sa = 0.1;                   // sin(alfa)
const float ca = sqrt( 1-sa*sa );       // cos(alfa)
const float  c = 1.0/(ca+sa);             // size of rotated square relative to bounding square 

const mat2 rotmat = mat2( ca, -sa, sa, ca );

//vec2 w_logMap( vec2 p ){ return 6*p*p*(1 - p);  }   // logistic map
vec2 w_logMap( vec2 p ){ return 4*p*(1 - p);  }   // logistic map
vec2 w_rot   ( vec2 p ){ return ca*p+sa*p.yx; }   // rotate
//vec2 w_rot   ( vec2 p ){ return rotmat*p; }   // rotate

vec2 mapSum(vec2 p){ 
	vec2 sum = 0;
	for (int i=0; i<n; i++){
		vec2 p0 = p;  
		p = w_logMap(p);
		//p = w_logMap(p);
		//p = p*0.8 + 0.2*p0.yx;
		p = w_rot(p)*c;              // scale down to stay in <0,1> interval
		sum *= 1.1;
		sum += p;
	} 
//return sum*(1.0/(n*(2<<n)));
//return sum*(1.0/n)-0.5;
return p; 
}

void main(void){
	vec2 q  = (gl_FragCoord.xy / resolution.xy);
	q = q*4 -vec2(2.0,2.0);   // zoom out
	q = fract( q );           // make periodic 
	vec2 f = mapSum( q );
    gl_FragColor = vec4( f.xy, 0.0, 1.0 );
	//float ff = 0.5+f.x*f.y;  gl_FragColor = vec4( ff,ff,ff, 1.0 );
}
