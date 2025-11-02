class Lingkaran {
  double phi = 3.14;
  double r = 0;

  Lingkaran(double r) {
    this.r = r;
  }

  double get nilai_r {
    return r;
  }

  double getLuas() {
    return phi * (r * r);
  }

  double getKeliling() {
    return 2 * phi * r;
  }
}
