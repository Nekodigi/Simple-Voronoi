float baseColor = 0;
import processing.dxf.*;

boolean record;


int dispType = 0;
DelaunayTriangulation delaunay;
Voronoi voronoi = new Voronoi();

void setup(){
  size(600, 600, P3D);//because P3D is fast
  colorMode(HSB, 360, 100, 100, 100);
  baseColor = random(0, 360);
  delaunay = new DelaunayTriangulation();
}

void draw(){
  background(360);
  if (record) {
    beginRaw(DXF, "output.dxf");
  }
  //noFill();
  //stroke(255);
  noStroke();
  if(dispType == 0){
    delaunay.show();
  }
  ArrayList<Triangle> triangles = delaunay.getTriangles(true);
  ArrayList<PVector> points = delaunay.getPoints(false);
  if(points.size()>0){
    voronoi.setDatas(triangles, points);
  }
  if(dispType == 1){
    voronoi.show();//slow
  }
  if (record) {
    endRaw();
    record = false;
  }
  println(frameRate);
}

void mousePressed(){
  if(mouseButton == LEFT){
    delaunay.addPoint(mouseX, mouseY);
  }
}

void keyPressed(){
  if(key == 'r'){
    baseColor = random(0, 360);
    delaunay = new DelaunayTriangulation();
  }else if (key == 'd'){
    dispType++;
    if(dispType >= 2){
      dispType = 0;
    }
  }
  if (key == 'e') {
    record = true;
  }
}