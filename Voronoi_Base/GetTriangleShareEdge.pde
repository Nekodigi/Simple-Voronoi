public Triangle GetTriangleShareEdge(Triangle ABC, Edge AB, Deque<Triangle> triangles)
{
  Triangle ADB = ABC;//仮置
  PVector A = AB.start;
  PVector B = AB.end;

  boolean detected = false;
  Deque<Triangle> S = new LinkedList<Triangle>();

  while (triangles.size() > 0)
  {
    Triangle checking = triangles.pop();
    //三角形がABを含むものかを調べる
    if (Contains(checking, AB))
    {
      if (IsEqual(checking, ABC))
      {
        //ABCと同じやつだった場合
        S.push(checking);
      } else
      {
        PVector D = GetVertexPoint(checking, AB);
        color Color = checking.Color;
        ADB = new Triangle(A, D, B);
        ADB.Color = Color;
        break;
      }
    } else
    {
      //条件に合わなかった場合
      S.push(checking);
    }
  }


  while (S.size() >0) triangles.push(S.pop());

  return ADB;
}

public Triangle GetTriangleShareEdgeND(Triangle ABC, Edge AB, Deque<Triangle> triangles)
{
  Triangle ADB = ABC;//仮置
  PVector A = AB.start;
  PVector B = AB.end;

  for (Triangle checking : triangles)
  {
    //三角形がABを含むものかを調べる
    if (Contains(checking, AB) && !IsEqual(checking, ABC))
    {
      PVector D = GetVertexPoint(checking, AB);
      color Color = checking.Color;
      ADB = new Triangle(A, D, B);
      ADB.Color = Color;
      break;
    }
  }
  return ADB;
}