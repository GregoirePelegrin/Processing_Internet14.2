class Cell {
  int row;
  int col;

  boolean first;
  boolean last;
  boolean current;
  boolean stacked;
  boolean visited;
  boolean pathed;
  boolean[] walls;

  Cell(int r, int c, boolean f, boolean l) {
    this.row = r;
    this.col = c;
  
    this.first = f;
    this.last = l;
    this.current = false;
    this.stacked = false;
    this.visited = false;
    this.pathed = false;

    this.walls = new boolean[4];    
    this.walls[0] = true;
    this.walls[1] = true;
    this.walls[2] = true;
    this.walls[3] = true;
  }

  void display() {
    noStroke();
    noFill();
    if(this.first){
      fill(255, 0, 0, 150);
    } else if(this.last){
      fill(0, 255, 0, 150);
    } else if(this.current){
      fill(0, 0, 255, 150);
    } else if(this.stacked){
      fill(150, 0, 0, 150);
    } else if(this.pathed){
      if(solved){
        fill(0, 255, 0);
      } else {
        fill(0);
      }
    } else if (this.visited) {
      fill(150, 0, 150, 150);
    }
    rect(this.row * sizeCell, this.col * sizeCell, sizeCell, sizeCell);
    
    stroke(255);
    strokeWeight(2);
    if (this.walls[0]) line(this.row * sizeCell, this.col * sizeCell, this.row * sizeCell, (this.col+1) * sizeCell); 
    if (this.walls[1]) line(this.row * sizeCell, this.col * sizeCell, (this.row+1) * sizeCell, this.col * sizeCell);
    if (this.walls[2]) line((this.row+1) * sizeCell, this.col * sizeCell, (this.row+1) * sizeCell, (this.col+1) * sizeCell); 
    if (this.walls[3]) line(this.row * sizeCell, (this.col+1) * sizeCell, (this.row+1) * sizeCell, (this.col+1) * sizeCell);
  }

  ArrayList<Cell> getNeighbours() {
    ArrayList<Cell> neighbours = new ArrayList<Cell>();
    if (this.row != 0 && !maze.get((this.row-1)*nbrCellWidth + this.col).visited) neighbours.add(maze.get((this.row-1)*nbrCellWidth + this.col));
    if (this.col != 0 && !maze.get(this.row*nbrCellWidth + this.col-1).visited) neighbours.add(maze.get(this.row*nbrCellWidth + this.col-1));
    if (this.row != nbrCellHeight-1 && !maze.get((this.row+1)*nbrCellWidth + this.col).visited) neighbours.add(maze.get((this.row+1)*nbrCellWidth + this.col));
    if (this.col != nbrCellWidth-1 && !maze.get(this.row*nbrCellWidth + this.col+1).visited) neighbours.add(maze.get(this.row*nbrCellWidth + this.col+1));    
    return neighbours;
  }
  
  boolean isNeighbour(Cell cell){
    boolean neighbour = false;
    if(this.row == cell.row+1 && this.col == cell.col && !this.walls[0]) neighbour = true;
    if(this.row == cell.row && this.col == cell.col+1 && !this.walls[1]) neighbour = true;
    if(this.row == cell.row-1 && this.col == cell.col && !this.walls[2]) neighbour = true;
    if(this.row == cell.row && this.col == cell.col-1 && !this.walls[3]) neighbour = true;
    return neighbour;
  }
}
