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





void main(void)
{
	vec2 p = gl_FragCoord.xy / iResolution.xy;

    //vec2 cc = 1.1*vec2( 0.5*cos(0.1*iGlobalTime) - 0.25*cos(0.2*iGlobalTime), 
	//                    0.5*sin(0.1*iGlobalTime) - 0.25*sin(0.2*iGlobalTime) );

	//vec2 cc = vec2( -0.15652, -1.03225 );
	vec2 cc = vec2( -0.15652, +1.03225 );

	vec4 dmin = vec4(1000.0);
    vec2 z = (-1.0 + 2.0*p)*vec2(1.7,1.0);
	int i=0;
    for( i=0; i<32; i++ )    {
        z = cc + vec2( z.x*z.x - z.y*z.y, 2.0*z.x*z.y );
    }
    
	vec3 color = 0.5 + 0.5*vec3(z.x, z.y, 0 );

	gl_FragColor = vec4(color,1.0);
}
