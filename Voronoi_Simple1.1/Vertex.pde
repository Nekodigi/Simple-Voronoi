class Vertex{
  float x, y;
  int id;
  
  Vertex(float x, float y){
    this.x = x;
    this.y = y;
    id = gvid;
    gvid++;
  }
  
  PVector pv(){
    return new PVector(x, y);
  }
}