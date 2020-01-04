public class Triangle
{
    PVector A;
    PVector B;
    PVector C;

    Edge AB;
    Edge BC;
    Edge CA;
    Circle circum;

    color Color;

    public Triangle(PVector a, PVector b, PVector c)
    {
        A = a;
        B = b;
        C = c;
        AB = new Edge(A,B);
        BC = new Edge(B,C);
        CA = new Edge(C,A);

        colorMode(HSB,360,100,100,100);
        Color = color(random(360), 50, 100,20);
        circum = GetCircumscribedCircle(this);
    }
    
    public void Draw()
    {
        stroke(#000000);
        fill(Color);
        triangle(A.x, A.y, B.x, B.y, C.x, C.y);
    }
}