class Segitiga{
  int a = 0, t = 0, b = 0, c = 0;
  Segitiga(int a, int b, int c, int t){
    this.a = a;
    this.b = b;
    this.c = c;
    this.t = t;
  }

  int get nilai_a{
    return a;
  }

  void set nilai_t(int t){
    this.t = t;
  }

  double getLuas(){
    return 0.5 * (a * t);
  }

  int getKeliling(){
    return a + b + c;
  }
}