ArrayList<Cell> maze;
Creator creator;
ArrayList<Cell> stack;

int nbrCellWidth;
int nbrCellHeight;
float sizeCell;

boolean creationMode;
ArrayList<Cell> playerPath;
boolean solved;

void setup() {
  size(901, 901);
  frameRate(60);

  maze = new ArrayList<Cell>();
  nbrCellWidth = 5;
  nbrCellHeight = 5;
  sizeCell = min(width/nbrCellWidth, height/nbrCellHeight);
  for (int i=0; i<nbrCellWidth; i++) {
    for (int j=0; j<nbrCellHeight; j++) {
      Cell cell = new Cell(i, j, false, false);
      if (i == 0 && j == 0) cell.first = true;
      if (i == nbrCellWidth-1 && j == nbrCellHeight-1) cell.last = true;
      maze.add(cell);
    }
  }
  creator = new Creator();
  stack = new ArrayList<Cell>();
  creationMode = true;
  playerPath = new ArrayList<Cell>();
  playerPath.add(maze.get(0));
  solved = false;
}

void draw() {
  background(0);

  if (creationMode) {
    creator.nextStep();
  } else {
    solvingDisplay();
    if (playerPath.get(playerPath.size()-1).last) solved = true;
  }
  for (Cell cell : maze) {
    cell.display();
  }
}

void removeWall(Cell c1, Cell c2) {
  if (c1.row - c2.row == -1) {
    c1.walls[2] = false;
    c2.walls[0] = false;
  } else if (c1.row - c2.row == 1) {
    c1.walls[0] = false;
    c2.walls[2] = false;
  } else if (c1.col - c2.col == -1) {
    c1.walls[3] = false;
    c2.walls[1] = false;
  } else if (c1.col - c2.col == 1) {
    c1.walls[1] = false;
    c2.walls[3] = false;
  }
}

void solvingDisplay() {
  fill(0, 150, 150, 200);
  rect(floor(mouseX/sizeCell)*sizeCell, floor(mouseY/sizeCell)*sizeCell, sizeCell, sizeCell);
}

void mouseDragged() {
  if (!creationMode) {
    Cell current = getCell(mouseX, mouseY);
    if (current != null && current.isNeighbour(playerPath.get(playerPath.size()-1))) {
      playerPath.add(current);
      current.pathed = true;
    }
  }
}

void mouseClicked() {
  if (!creationMode) {
    boolean erase = false;
    Cell current = getCell(mouseX, mouseY);
    for (Cell cell : playerPath) {
      if (current == cell) {
        erase = true;
        break;
      }
    }
    if (erase) {
      Cell eraser = playerPath.remove(playerPath.size()-1);
      eraser.pathed = false;
      while (eraser != current) {
        eraser = playerPath.remove(playerPath.size()-1);
        eraser.pathed = false;
      }
      playerPath.add(eraser);
      eraser.pathed = true;
    }
  }
}

Cell getCell(int x, int y) {
  Cell cell;
  try {
    cell = maze.get(floor(x/sizeCell)*nbrCellWidth + floor(y/sizeCell));
  } 
  catch(IndexOutOfBoundsException e) {
    return null;
  }
  return cell;
}
