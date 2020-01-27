class Circle{
  PVector center;
  float radius;
  
  Circle(PVector center, float radius){
    this.center = center;
    this.radius = radius;
  }
  
  boolean isContain(PVector p){
    return center.dist(p) < radius;
  }
  
  void show(){
    ellipse(center.x, center.y, radius*2, radius*2);
  }
}