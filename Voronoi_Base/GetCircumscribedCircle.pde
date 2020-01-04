public Circle GetCircumscribedCircle(Triangle triangle)
{
    float x1 = triangle.A.x;
    float y1 = triangle.A.y;
    float x2 = triangle.B.x;
    float y2 = triangle.B.y;
    float x3 = triangle.C.x;
    float y3 = triangle.C.y;

    float c = 2.0 * ((x2 - x1) * (y3 - y1) - (y2 - y1) * (x3 - x1));
    float x = ((y3 - y1) * (x2 * x2 - x1 * x1 + y2 * y2 - y1 * y1)+(y1 - y2) * (x3 * x3 - x1 * x1 + y3 * y3 - y1 * y1))/c;
    float y = ((x1 - x3) * (x2 * x2 - x1 * x1 + y2 * y2 - y1 * y1)+(x2 - x1) * (x3 * x3 - x1 * x1 + y3 * y3 - y1 * y1))/c;

    PVector center = new PVector(x, y);
    float r = PVector.dist(center, triangle.A);

    return new Circle(center, r);
}