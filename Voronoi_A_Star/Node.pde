class Node{
  PVector pos;
  ArrayList<Node> links = new ArrayList<Node>();
  Node previous;
  float f;
  float g;
  float h;
  
  Node(PVector pos){
    this.pos = pos;
    if(pos == null){
      print("null errpr");
    }
  }
  
  void tryAddLink(Node tn){
    for(Node node : links){
      if(isSame(tn.pos, node.pos)){
        return;
      }
    }
    links.add(tn);
  }
  
  void replaceLinks(ArrayList<Node> nodes){
    resetLinks();
    for(Node node : nodes){
      links.add(node);
    }
  }
  
  void resetLinks(){
    links = new ArrayList<Node>();
  }
  
  void show(){
    show(color(360));
  }
  
  void show(color col){
    stroke(0);
    for(Node link : links){
      if(link == null){
        print("null");
        print(links.size());
      }
      line(pos.x, pos.y, link.pos.x, link.pos.y);
    }
    fill(col);
    noStroke();
    ellipse(pos.x, pos.y, 20, 20);
  }
  
  void calcF(){
    f = g + h;
  }
}