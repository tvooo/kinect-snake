import java.util.*;

ArrayList<Snake> snakes = new ArrayList<Snake>();

Food food;

int fieldSize = 15;

int windowSize = 300;
int gridSize = windowSize / fieldSize;

float speed;

boolean gameOver = false;
PFont Font = createFont("Courier New Bold",25, true);
PFont playerFont = createFont("Courier New Bold",16, true);

void setup(){
    size(int(windowSize), int(windowSize),P3D);
    speed = 100;
    speed = speed/frameRate;

    background(0);

    snakes.add(new Snake(1, 1, color(100, 200, 100)));
    snakes.add(new Snake(gridSize-2, gridSize-2, color(100, 100, 200)));

    food = new Food();

    gameOver = false;
}

void draw(){
        


  if(speed%10 == 0){
        background(0);
        drawGrid();
        runGame();
        textAlign(LEFT, TOP);
        textFont(playerFont);
        fill(snakes.get(0).fillColor);
        text("Green: " + snakes.get(0).snakeSize,windowSize*0.05,windowSize*0.05);
        fill(snakes.get(1).fillColor);
        text("Blue: " + snakes.get(1).snakeSize,windowSize*0.70,windowSize*0.05);
    }
    speed++;
}

void drawGrid() {
    stroke(255, 100);
    for( int x = 0; x < gridSize; x++ ) {
        line( x * fieldSize, 0, x * fieldSize, windowSize );
    }
    for( int y = 0; y < gridSize; y++ ) {
        line( 0, y * fieldSize, windowSize, y * fieldSize );
    }
}

void reset(){
    gameOver = false;
    snakes = new ArrayList<Snake>();
    snakes.add(new Snake(1, 1, color(100, 200, 100)));
    snakes.add(new Snake(gridSize-2, gridSize-2, color(100, 100, 200)));
}

void runGame(){
    if ( !gameOver ){
        for( Snake snake : snakes ) {
            if(food.posx == snake.posx && food.posy == snake.posy){
                snake.eat( food );
                food = new Food();
            }
            snake.move();
            snake.draw();
        }

        for ( Snake snake : snakes ) {
            for ( Snake otherSnake : snakes ) {
                if ( snake.collides(otherSnake) ) {
                    gameOver = true;
                }
            }
        }


        food.draw();
    } else {
        String modelString = "Game Over";
        stroke(255);
        fill(255);
        textAlign(CENTER, BOTTOM);
        textFont(Font);
        text(modelString,windowSize*0.5,windowSize*0.5);
    }
}

void keyPressed() {
    if(keyCode == UP) { snakes.get(0).moveUp(); }
    if(keyCode == DOWN) { snakes.get(0).moveDown(); }
    if(keyCode == LEFT) { snakes.get(0).moveLeft(); }
    if(keyCode == RIGHT) { snakes.get(0).moveRight(); }
    if(keyCode == 'W') { snakes.get(1).moveUp(); }
    if(keyCode == 'S') { snakes.get(1).moveDown(); }
    if(keyCode == 'A') { snakes.get(1).moveLeft(); }
    if(keyCode == 'D') { snakes.get(1).moveRight(); }
    if(keyCode == 'R') {reset();}
}

