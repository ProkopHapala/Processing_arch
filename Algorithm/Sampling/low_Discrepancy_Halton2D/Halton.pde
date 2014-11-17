float halton(int index, int base){
       float x = 0;
       float f = 1.0 / base;
       float ff = f;
       int i = index;
       while (i > 0) {
           x = x + ff * (i % base);
           i = floor( i / base);
           ff = ff * f;
       }
       return x;
   }
