class Creator {
  Cell current;

  Creator() {
    this.current = maze.get(0);
    this.current.visited = true;
    this.current.current = true;
  }

  void nextStep() {
    ArrayList<Cell> neighbours = current.getNeighbours();

    if (neighbours.size() != 0) {
      this.current.stacked = true;
      stack.add(this.current);
      int next = floor(random(neighbours.size()));
      removeWall(this.current, neighbours.get(next));
      this.current.current = false;
      this.current = neighbours.get(next);
      this.current.visited = true;
      this.current.current = true;
    } else if (stack.size() != 0) {
      this.current.current = false;
      this.current.stacked = false;
      this.current = stack.remove(stack.size()-1);
      this.current.current = true;
    } else {
      creationMode = false;
    }
  }
}
