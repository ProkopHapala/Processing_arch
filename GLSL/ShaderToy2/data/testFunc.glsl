// Created by inigo quilez - iq/2013
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.


#ifdef GL_ES
precision highp float;
#endif

// Type of shader expected by Processing
#define PROCESSING_COLOR_SHADER

// Processing specific input
uniform float time;
uniform vec2 resolution;
uniform vec2 mouse;

// Layer between Processing and Shadertoy uniforms
vec3 iResolution = vec3(resolution,0.0);
float iGlobalTime = time;
vec4 iMouse = vec4(mouse,0.0,0.0); // zw would normally be the click status


inline float p4( float x, vec4 c){
	return c.x + x*( c.y + x*(c.z + c.w*x ) );
};

inline float logistic( float x, float c){
	return c*x*(1-x);
};

inline float sq(float x){
	return x*x;
}

inline float lorenz( float x, float c){
	return c/(x*x + c);
}

inline float testFunc( vec2 p ){

	float r2 = p.x*p.x + p.y*p.y; 
	//float ca = logistic( r2,  +3.5 );
	float ca = logistic( logistic( 0.25*r2,  +3.5 ), 2.5 );
	//float ca = r2;
	

	float sa = 1-ca;

	float a = ca*p.x - sa*p.y; 
	float b = sa*p.x + ca*p.y;

	float sigma = 0.001 + 0.05*r2;
	//return 1- 0.25*( lorenz(a,sigma) + lorenz(b,sigma) + lorenz(a+b,sigma) + lorenz(a-b,sigma) );
	//return 1- 0.5*( lorenz(a,sigma) + lorenz(b,sigma) );
	return 0.1+sq(a);

};


void main(void)
{
	vec2 p = 2*( gl_FragCoord.xy / iResolution.xy - vec2(0.5,0.5) );

	float f = testFunc( p*5 )*0.5;
    
	vec3 color = 0.1+vec3(f, f, f );

	gl_FragColor = vec4(color,1.0);
}
