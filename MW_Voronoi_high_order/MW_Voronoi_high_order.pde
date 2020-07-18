ArrayList<Region> regions = new ArrayList<Region>();
float pSize;
int rN = 100;//number of regions
float basehue;
float pSW = 10;
int power = 2;
boolean render = false;

void setup(){
  size(500, 500);
  //fullScreen();
  colorMode(HSB, 360, 100, 100);
  basehue = random(360);
  for(int i = 0; i < rN; i++){
    int col = color(basehue, random(100), 100);
    PVector p = new PVector(random(width), random(height));
    regions.add(new Region(p, col));
  }
}

void keyPressed(){
  if(keyCode == UP){
    power++;
  }else if(keyCode == DOWN){
    power--;
  }
  if(key == 'r'){
    render = !render;
  }
  if(key == 's'){
    basehue = random(360);
    regions = new ArrayList<Region>();
    for(int i = 0; i < rN; i++){
      int col = color(basehue, random(100), 100);
      PVector p = new PVector(random(width), random(height));
      regions.add(new Region(p, col));
    }
  }
}

void draw(){
  background(255);
  noStroke();
  //float t = pSize;
  if(render){
    pSize = 1;
  }else{
    pSize = 4;
  }
  for(int x = 0; x < width; x+=pSize){
    for(int y = 0; y < height; y+=pSize){
      fill(nearestColor(power, new PVector(x, y)));
      rect(x, y, pSize, pSize);
    }
  }
  
  for(Region region : regions){
    region.show();
  }
}

int nearestColor(int val, PVector p){
  float minDist = Float.POSITIVE_INFINITY;
  int col = color(0);
  for(Region region : regions){
    float dst = dist(val, region.p, p)/region.w;
    if(minDist > dst){
      minDist = dst;
      col = region.col;
    }
  }
  return col;
}
public float dist(int pNorm, PVector a, PVector b){
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

class Region{
  PVector p;
  int col;
  float w;
  
  Region(PVector p, int col){
    this.p = p;
    this.col = col;
    this.w = random(0.5f, 2);
  }
  
  public void show(){
    stroke(col);
    strokeWeight(pSW);
    point(p.x, p.y);
  }
}
