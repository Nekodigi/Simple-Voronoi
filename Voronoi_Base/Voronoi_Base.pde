import java.util.Deque;
import java.util.LinkedList;

DelaunayTriangulation diagram;
int dispMode = 0;

void setup()
{
    size(1000,1000);
    diagram = new DelaunayTriangulation();
}

void draw()
{
    background(#FFFFFF);
    // noFill();
    // stroke(#000000);
    // strokeWeight(3);

    diagram.Draw();
}

void keyPressed(){
  if(key == 'd'){
    dispMode++;
    if(dispMode >= 3){
      dispMode = 0;
    }
  }
}

void mousePressed()
{
    if(mouseButton == LEFT)
    {
        diagram.AddPoint(new PVector(mouseX,mouseY));
    }
    if(mouseButton == RIGHT)
    {
        diagram.Finalize();
    }
}

void point(float x, float y)
{
    strokeWeight(3);
    ellipse(x, y, 10, 10);
}