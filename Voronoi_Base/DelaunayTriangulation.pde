public class DelaunayTriangulation
{
  Deque<PVector> points = new LinkedList<PVector>();
  Deque<Triangle> diagram = new LinkedList<Triangle>();
  Triangle superTriangle;

  public DelaunayTriangulation()
  {
    superTriangle = GenerateSuperTriangle();
    diagram.add(superTriangle);
  }

  void Draw()
  {
    // superTriangle.Draw();
    for (PVector p : points) point(p.x, p.y);
    for (Triangle t : diagram)
    {
      switch(dispMode) {
      case 0:
        //Voronoi 
        line(t.circum.center, GetTriangleShareEdgeND(t, t.AB, diagram).circum.center);
        line(t.circum.center, GetTriangleShareEdgeND(t, t.BC, diagram).circum.center);
        line(t.circum.center, GetTriangleShareEdgeND(t, t.CA, diagram).circum.center);
        break;
      case 1:
        t.Draw();
        break;
      default:
        t.Draw();
        noFill();
        stroke(Contains(t.circum, new PVector(mouseX, mouseY))? #F00000 : #000000, 100);
        stroke(Contains(t.circum, new PVector(mouseX, mouseY))? #F00000 : #A0A0A0, 100);
        t.circum.Draw();
        break;
      }
    }
  }

  void AddPoint(PVector p)
  {
    points.add(p);
    Triangulation(p);
  }

  void Finalize()
  {
    //diagramから、superTriangleの各頂点を含む三角形を除外する
    Deque<Triangle> S = CopyStackOf(diagram);
    diagram.clear();
    while (S.size()>0)
    {
      Triangle checking = S.pop();
      if (!IsSharingPoint(checking, superTriangle))
      {
        diagram.push(checking);
      }
    }
  }

  void Triangulation(PVector p)
  {
    //diagramと同じ内容のスタックを組む。
    Deque<Triangle> baseTriangles = CopyStackOf(diagram);

    //分割後の三角形を格納するスタック
    Deque<Triangle> newTriangles = new LinkedList<Triangle>();

    //pを含む三角形ABCを探す
    Triangle ABC = IsInsideOfTriangle(baseTriangles, p);

    for (Triangle t : Divide(baseTriangles, ABC, p)) newTriangles.push(t);

    while (baseTriangles.size()>0) newTriangles.push(baseTriangles.pop());

    //新しい三角形達でdiagramを更新
    diagram = CopyStackOf(newTriangles);
  }

  Deque<Triangle> Divide(Deque<Triangle> baseTriangles, Triangle checking, PVector p)
  {
    //pがABCの内側にあるため、ABP, BCP, CAPに分割
    Deque<Triangle> divided = new LinkedList<Triangle>();
    divided.push(new Triangle(checking.A, checking.B, p));
    divided.push(new Triangle(checking.B, checking.C, p));
    divided.push(new Triangle(checking.C, checking.A, p));

    Deque<Triangle> newTriangles = new LinkedList<Triangle>();
    //新しくできた三角形の集合dividedに対して処理を行っていく。
    //三角形をABPとして考える。pの対角辺である辺ABを共有する三角形ADBをbaseTrianglesから探す。
    //戻すトライアングル
    while (divided.size()>0)
    {
      Triangle ABC = divided.pop();
      Edge AB = GetOppositeEdge(ABC, p);
      Triangle ADB = GetTriangleShareEdge(ABC, AB, baseTriangles);
      if (IsEqual(ABC, ADB))
      {
        println("isnt special");
        newTriangles.push(ABC);
        //println(IsEqual(p, GetVertexPoint(ADB, AB)));
        println(IsEqual(ABC, ADB));
        continue;
      }

      PVector D = GetVertexPoint(ADB, AB);
      if (Contains(ABC, D))
      {
        //FLIP
        println("flip");
        Deque<Triangle> FlipedTriangles = Flip(ADB, AB, p);
        for (Triangle t : FlipedTriangles) divided.push(t);
      } else
      {
        println("call");
        newTriangles.push(ABC);
        newTriangles.push(ADB);
      }
    }

    return newTriangles;
  }

  Deque<Triangle> Flip(Triangle ADB, Edge AB, PVector p)
  {
    Deque<Triangle> FlipedTriangles = new LinkedList<Triangle>();

    PVector D = GetVertexPoint(ADB, AB);
    PVector A = AB.start;
    PVector B = AB.end;

    FlipedTriangles.push(new Triangle(A, D, p));
    FlipedTriangles.push(new Triangle(D, B, p));

    return FlipedTriangles;
  }

  Deque<Triangle> CopyStackOf(Deque<Triangle> stack)
  {
    Deque<Triangle> returnTriangles = new LinkedList<Triangle>();

    for (Triangle item : stack)
    {
      returnTriangles.push(item);
    }
    return returnTriangles;
  }
}