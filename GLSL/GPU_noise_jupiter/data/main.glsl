

// ========================== FRACTALIZE FUNCTIONS

const float sc1 = 1.1;      const float amp1 = 0.8;
const float sc2 = sc1*sc1; const float amp2 = amp1*amp1;
const float sc3 = sc2*sc1; const float amp3 = amp2*amp1;
const float sc4 = sc3*sc1; const float amp4 = amp3*amp1;
const float sc5 = sc4*sc1; const float amp5 = amp4*amp1;
const float sc6 = sc5*sc1; const float amp6 = amp5*amp1;

float multiNoise(vec2 t){
	return 
	0.5   * noise_func( t)   +
	0.25  * noise_func( t*2) +
	0.125 * noise_func( t*4) +
	0.125 * noise_func( t*8)
	;
}

/*
const int      n = 100;
const float resc = (1.0/(1<<n));
*/

float multiNoise_logmap(in vec2 t){
	float amp=1;
	float f = noise_func( t );
	float sum = f;
	for (int i=0; i<niter; i++){
		f+= 4*f*(1-f);
		sum+=f*amp;
		amp*=amplitudeFactor;
	}
	return sum/10;
}


vec2 multiWarp(in vec2 t){
	float sc=1, amp=1;
	for (int i=0; i<niter; i++){
		t+= noise_map( t*sc )*amp;
		sc*=scaleFactor;amp*=amplitudeFactor;
	}
	return t;
}

vec2 multiWarpRot(in vec2 t){
	float sc=1, amp=amplitude0;
	vec2 dt = vec2(1,0);
	//vec2 dt = noise_map( t*sc );
	//t+=dt;
	for (int i=0; i<niter; i++){
		vec2 n = noise_map( t*sc )*amp;
		mat2 m = mat2( 1+n.x, -n.y, n.y, 1+n.x   );
		dt = m*dt;
		t += dt;
		sc*=scaleFactor;amp*=amplitudeFactor;
	}
	return t;
}


vec2 multiWarpRot2(in vec2 t, in vec2 dtseed){
	float sc=1, amp=amplitude0;
	vec2 dt = dtseed;
	//vec2 dt = noise_map( t*sc );
	//t+=dt;
	for (int i=0; i<niter; i++){
		vec2 n = noise_map( t*sc )*amp;
		mat2 m = mat2( 1+n.x, -n.y, n.y, 1+n.x   );
		dt = m*dt;
		t += dt;
		sc*=scaleFactor;amp*=amplitudeFactor;
	}
	return t;
}

vec2 multiWarp_logmap(in vec2 t){
	float amp=1;
	vec2 f = noise_map( t ) + vec2(0.5,0.5);
	t += f;
	for (int i=0; i<niter; i++){
		f = 4*f*(1-f);
		t+=f*amp;
		amp*=amplitudeFactor;
	}
	return t;
}



vec2 Warp3( vec2 t ){
  float amp=1.0;
  for (int i=0; i<niter; i++){
    t  += noise_map( t )*amp;
	t  *= scaleFactor;
    amp*= amplitudeFactor;
  };
  return t;
};


vec2 grid( in vec2 t ){  return fract(t); };

float dist( in vec2 v, in vec2 q ){ vec2 d=v-q; return distRange2/(distRange2+dot(d,d)); };

// ========================== MAIN

void main(void){
	vec2 q  = (gl_FragCoord.xy / resolution); 
	q  += mouse*0.01;
	//float f = noise_bilinear( q*40);
	//float f = multiNoise( q*40);
	q = (q - vec2(0.5,0.5))*rescale;
	//vec2 v  = multiWarp( q );
	//vec2 v  = multiWarp_logmap( q );
	//vec2 v  = multiWarp(q);
	//vec2 v  = multiWarpRot(q);
	vec2 dtseed = vec2( cos(time),sin(time) );
	//float r = 1+noise_func( q )*0.5;  dtseed*=r;
	vec2 v  = multiWarpRot2( q, dtseed );
	//vec2 v  = Warp3( q );
	//vec2 v  = Warp3( multiWarp(q) );
	//float f = multiNoise( v );
	//float f = noise_func( v );
	//float f = multiNoise_logmap( (q - vec2(0.5,0.5))*10 );
	//float f = dist(v,q);
    //gl_FragColor = vec4( f,f,f, 1.0 );
	//gl_FragColor = vec4( v,0, 1.0 );
	//gl_FragColor = vec4( grid(q) ,0,1);
	//gl_FragColor = vec4( grid(v)*ColorAmp ,0,1);
	gl_FragColor = vec4( sin(v*ColorAmp)*0.5 + vec2(0.5,0.5) ,0,1);
	//float f = noise_func( v ); gl_FragColor = vec4( f,f,f, 1.0 );
	//float f = dist(v,q); gl_FragColor = vec4( f,f,f, 1.0 );
	//gl_FragColor = vec4( (v-q)*ColorAmp ,0,1);
	
}
