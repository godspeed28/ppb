class Kubus {
  int s = 0;
  Kubus(int s) {
    this.s = s;
  }
  int get nilai_s {
    return s;
  }

  int getLuas() {
    return 6 * (s * s);
  }

  int getVolume() {
    return s * s * s;
  }

  int getKeliling() {
    return 12 * s;
  }
}
