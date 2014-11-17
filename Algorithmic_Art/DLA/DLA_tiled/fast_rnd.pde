static int fast_rnd_seed;

final static int fast_rnd(){ 
  fast_rnd_seed = (214013*fast_rnd_seed+2531011);
  return (fast_rnd_seed>>16)&0x7FFF;
}
