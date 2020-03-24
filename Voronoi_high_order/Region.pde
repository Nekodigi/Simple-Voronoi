class Region{
  PVector p;
  color col;
  
  Region(PVector p, color col){
    this.p = p;
    this.col = col;
  }
  
  void show(){
    stroke(col);
    strokeWeight(pSW);
    point(p.x, p.y);
  }
}