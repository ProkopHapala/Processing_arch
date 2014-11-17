float[] a = new float[1000];

void setup() {
 
  for (int i = 0; i < a.length; i++) {
    a[i]=random(1);
  }
  
  quickSort(a, 0, a.length-1);

  for (int i = 0; i < a.length; i++) {
    print (a[i]+" ");
  }

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


