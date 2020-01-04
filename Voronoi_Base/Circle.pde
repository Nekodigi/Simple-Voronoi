public class Circle
{
    PVector center;
    float radius;

    public Circle(PVector c, float r)
    {
        center = c;
        radius = r;
    }

    public void Draw()
    {
        ellipse(center.x, center.y, radius*2, radius*2);
    }
}