public Edge GetOppositeEdge(Triangle triangle, PVector point)
{
    if(IsEqual(point, triangle.A))
    {
        return triangle.BC;
    }
    else if(IsEqual(point, triangle.B))
    {
        return triangle.CA;
    }
    else
    {
        return triangle.AB;
    }
}