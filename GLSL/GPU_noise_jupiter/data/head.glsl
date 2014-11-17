// Created by inigo quilez - iq/2013
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

#ifdef GL_ES
precision highp float;
#endif

// Type of shader expected by Processing
#define PROCESSING_COLOR_SHADER

// Processing specific input
uniform float time;
uniform vec2  resolution;
uniform vec2  mouse;
uniform int   niter;
uniform float scaleFactor;
uniform float amplitudeFactor;
uniform float amplitude0;
uniform float distRange2;
uniform float ColorAmp;
uniform float rescale;


