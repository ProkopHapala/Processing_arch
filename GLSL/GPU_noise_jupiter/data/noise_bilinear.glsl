

// ========================== NOISE BILINEAR

vec4 mymod  (vec4 x) {  return x - floor(x * (1.0 / 214013.0)) * 214013.0; }
vec4 rndFunc(vec4 x) {  return mymod(((x)+2531011)*x);                }

vec2 mymod(vec2 x)   {  return x - floor(x * (1.0 / 214013.0)) * 214013.0; }
vec2 rndFunc(vec2 x) {  return mymod(((x)+2531011)*x);                 }

float mymod  (float x) { return x - floor(x * (1.0 / 214013.0)) * 214013.0; }
float rndFunc(float x) { return mymod(((x)+2531011)*x);                 }

float noise_func( vec2 t){
	vec2 it = floor(t);
	vec2 dt = t - it;
	vec2 mt = 1.0 - dt; 
	vec4 xs = it.xxxx + vec4(0,1,0,1);
	vec4 ys = it.yyyy + vec4(0,0,1,1);
	vec4 fs = rndFunc( rndFunc( xs*110 + ys ) )*(1.0/327670.0);
	return mt.y*(mt.x*fs.x+dt.x*fs.y ) + dt.y*(mt.x*fs.z+dt.x*fs.w);
}

vec2 noise_map( vec2 t){
	vec2 it = floor(t);
	vec2 dt = t - it;
	vec2 mt = 1.0 - dt; 
	vec4 xs = it.xxxx + vec4(0,1,0,1);
	vec4 ys = it.yyyy + vec4(0,0,1,1);
	vec4 h1 = rndFunc( rndFunc( xs*110 + ys ) )         *(1.0/327670.0);
	vec4 h2 = rndFunc( rndFunc( xs*110 + ys + 100 ) )   *(1.0/327670.0);
    return mix(mix( vec2(h1.x,h2.x), vec2(h1.y,h2.y),dt.x),
               mix( vec2(h1.z,h2.z), vec2(h1.w,h2.w),dt.x),dt.y);
	/*
	return vec2( 
		mt.y*(mt.x*fs1.x+dt.x*fs1.y ) + dt.y*(mt.x*fs1.z+dt.x*fs1.w) - 0.2,
		mt.y*(mt.x*fs2.x+dt.x*fs2.y ) + dt.y*(mt.x*fs2.z+dt.x*fs2.w) - 0.5
	);
	*/
}

