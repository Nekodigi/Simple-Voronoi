DelaunayTriangulation delaunay;
int gvid = 0;//global vertex id

void setup(){
  size(600, 600);
  delaunay = new DelaunayTriangulation();
}

void draw(){
  background(51);
  //noFill();
  stroke(255);
  delaunay.show();
  fill(255, 100);
  ArrayList<Triangle> triangles = delaunay.getTriangles(true);
  for(Triangle t : triangles){
    //t.show();
  }
}

void mousePressed(){
  if(mouseButton == LEFT){
    delaunay.addPoint(mouseX, mouseY);
  }
}