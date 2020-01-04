//外積(cross)を用いて、三角形の内部にpがあるかを調べる。
//内側にある場合、外積のベクトルはすべて同じ向きになる。
public boolean IsInsideOfTriangle(Triangle triangle, PVector p)
{
    PVector A = triangle.A;
    PVector B = triangle.B;
    PVector C = triangle.C;

    //AB x BP, BC x CP, CA x AP
    PVector ABxBP = Cross(A, B , p);
    PVector BCxCP = Cross(B, C , p);
    PVector CAxAP = Cross(C, A , p);

    return (ABxBP.z >=0 && BCxCP.z >=0 && CAxAP.z>=0) || (ABxBP.z <=0 && BCxCP.z <=0 && CAxAP.z<=0);
}

public Triangle IsInsideOfTriangle(Deque<Triangle> triangles, PVector p)
{
    Triangle retTriangle = triangles.peek();
    Deque<Triangle> S = new LinkedList<Triangle>();

    while(triangles.size()>0)
    {
        Triangle checking = triangles.pop();
        if(IsInsideOfTriangle(checking, p))
        {
            retTriangle = checking;
            break;
        }
        else
        {
            S.push(checking);
        }
    }

    while(S.size() >0) triangles.push(S.pop());

    return retTriangle;
}