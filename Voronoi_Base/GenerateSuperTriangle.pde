public Triangle GenerateSuperTriangle()
{
    PVector center = new PVector(width/2, height/2);
    float radius = PVector.dist(center, new PVector(width, height));

    return  new Triangle(
        new PVector(center.x - radius*sqrt(3), center.y - radius),
        new PVector(center.x + radius*sqrt(3), center.y - radius),
        new PVector(center.x, center.y + 2*radius)
    );

}