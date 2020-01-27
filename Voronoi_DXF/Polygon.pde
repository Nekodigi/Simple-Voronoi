class Polygon{
  PVector origin;
  ArrayList<Edge> edges = new ArrayList<Edge>();
  ArrayList<PVector> vertices = new ArrayList<PVector>();
  color col;
  
  Polygon(PVector origin){
    this.origin = origin;
    col = color(baseColor, random(0, 100), 100);
  }
  
  void resetVertex(){
    vertices = new ArrayList<PVector>();
  }
  
  void addVertex(PVector p){
    vertices.add(p);
  }
  
  void show(){
    fill(col);
    beginShape();
    for(int i = 0; i < vertices.size(); i++){
      PVector p = vertices.get(i);
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
  }
}