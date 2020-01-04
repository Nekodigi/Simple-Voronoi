void A_Star() {
  if (openSet.size() > 0) {
    Node winner = openSet.get(0);
    for (Node node : openSet) {
      if (node.f < winner.f) {
        winner = node;
      }
    }

    current = winner;
    openSet.remove(current);
    closedSet.add(current);
    for (Node neighbor : current.links) {
      if (!closedSet.contains(neighbor)) {
        float tempG = neighbor.g = current.g + heuristic(neighbor, current);
        if (openSet.contains(neighbor)) {
          if (tempG < neighbor.g) {
            neighbor.g = tempG;
          }
        } else {
          neighbor.g = tempG;
          openSet.add(neighbor);
        }
        neighbor.h = heuristic(neighbor, end);
        neighbor.calcF();
        neighbor.previous = current;
      }
    }
    if (current == end) {
      println("DONE");
      solving = false;
    }
  } else {
    println("NO SOLUTION");
    solving = false;
  }
  path = new ArrayList<Node>();
  Node temp = current;
  path.add(temp);
  while(temp.previous != null){
    path.add(temp.previous);
    temp = temp.previous;
  }
}