class Persegi{
  int p = 0, l = 0, s = 0;
  int luas = 0;
  Persegi(int p, int l, int s){
    this.p = p;
    this.l = l;
    this.s = s;
  }

  int get nilai_p{
    return p;
  }

  void set nilai_l(int l){
    this.l = l;
  }

  void set nilai_s(int s){
    this.s = s;
  }

  int getLuas(){
    return p * l;
  }

  int getKeliling(){
    return 4 * s;
  }
}