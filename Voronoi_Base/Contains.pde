public boolean Contains(Circle circle, PVector p)
{
    return circle.center.dist(p) < circle.radius;
}

public boolean Contains(Triangle triangle, PVector p)
{
    return Contains(GetCircumscribedCircle(triangle),p);
}

public boolean Contains(Triangle triangle, Edge e)
{
    return IsEqual(triangle.AB, e) || IsEqual(triangle.BC, e) || IsEqual(triangle.CA, e);
}