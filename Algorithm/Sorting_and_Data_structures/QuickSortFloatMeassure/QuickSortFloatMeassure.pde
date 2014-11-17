
float[] a = new float[10000000];

// 10 000 000 cisel trva asi 3600 ms
//  1 000 000 cisel trva asi  140 ms
//    100 000 cisle trva asi   16 ms

int sec;
int msec;

void setup() {
  

  for (int i = 0; i < a.length; i++) {
    a[i]=random(1);
  }
  
  sec = second();
  msec = millis();
  
  quickSort(a, 0, a.length-1);
  
  int time = 1000*(second()-sec)+millis()-msec;
  print (time);

}

int partition(float a[], int p, int r) {
  float x = a[r];
  int j = p - 1;
  for (int i = p; i < r; i++) {

    if (x <= a[i]) {
      j = j + 1;
      float temp = a[j];
      a[j] = a[i];
      a[i] = temp;
    }
  }
  a[r] = a[j + 1];
  a[j + 1] = x;

  return (j + 1);
}

void quickSort(float a[], int p, int r) {
  if (p < r) {
    int q = partition(a, p, r);
    quickSort(a, p, q - 1);
    quickSort(a, q + 1, r);
  }
}


