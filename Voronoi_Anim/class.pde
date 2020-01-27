class Cell{
  PVector point;
  color col;
  float[] ranges;
  PVector[] vertices;
  boolean[] solved;
  
  Cell(PVector point, int Nvertices, float hue){
    this.point = point;
    ranges = new float[Nvertices];
    vertices = new PVector[Nvertices];
    solved = new boolean[Nvertices];
    this.col = color((hue+random(50))%360, random(100), 100);
  }
  
  void calcVertices(){
    for(int i = 0; i < ranges.length; i++){
      float range = ranges[i];
      float theta = map(i, 0, ranges.length, 0, TWO_PI);
      vertices[i] = new PVector(point.x+cos(theta)*range, point.y+sin(theta)*range);
    }
  }
  
  void update(float speed){
    calcVertices();
    for(int i = 0; i < ranges.length; i++){
      if(!solved[i]){
        for(Cell cell : cells){
          if(cell != this && dist(vertices[i].x, vertices[i].y, cell.point.x, cell.point.y) < dist(vertices[i].x, vertices[i].y, point.x, point.y)){
            solved[i] = true;
          }
        }
        ranges[i] += speed;
      }
    }
  }
  
  void show(){
    fill(col);
    beginShape();
    for(int i = 0; i < ranges.length; i++){
      vertex(vertices[i].x, vertices[i].y);
    }
    endShape();
  }
}