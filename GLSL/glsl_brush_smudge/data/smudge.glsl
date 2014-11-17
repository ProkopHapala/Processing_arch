#ifdef GL_ES
precision highp float;
#endif

// Type of shader expected by Processing
#define PROCESSING_COLOR_SHADER

// Processing specific input
uniform float time;
uniform vec2 resolution;
uniform vec2 mouse;
uniform vec2 mouseOld;
//uniform vec2 dmouse = (mouse - mouseOld); 

uniform sampler2D background;

void main(void)
{
    vec2 dmouse = (mouse - mouseOld);
	vec4 texColorOld = texture2D(background, (gl_FragCoord.xy-dmouse*0.1)/resolution.xy ).rgba;
	vec4 texColor    = texture2D(background,  gl_FragCoord.xy            /resolution.xy ).rgba;
    gl_FragColor   = mix(texColor, texColorOld, 0.5);
}
