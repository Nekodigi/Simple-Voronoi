float dist(int pNorm, PVector a, PVector b){
  float dx = b.x - a.x; float dy = b.y - a.y;
  return abs(ipow(dx, pNorm)) + abs(ipow(dy, pNorm));
}

float ipow(float x, int p){
  float result = x;
  for(int i = 1 ; i < p; i++){
    result *= x;
  }
  return result;
}