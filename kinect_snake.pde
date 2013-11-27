import java.util.*;

ArrayList<Snake> snakes = new ArrayList<Snake>();

Food food;

int windowSize = 400;
int fieldSize = windowSize / 10;

float speed;

boolean gameOver = false;
PFont Font = createFont("Arial",20, true);

void setup(){
    size(int(windowSize), int(windowSize),P3D);
    speed = 100;
    speed=speed/frameRate;

    background(0);

    snakes.add(new Snake(1, 1));
    snakes.add(new Snake(fieldSize-2, fieldSize-2));

    food = new Food();

    gameOver = false;
}

void draw(){
    if(speed%10 == 0){
        background(0);
        drawGrid();
        runGame();
    }
    speed++;
}

void drawGrid() {
    stroke(255, 100);
    for( int x = 0; x < fieldSize; x++ ) {
        line( x * 10, 0, x * 10, windowSize );
    }
    for( int y = 0; y < fieldSize; y++ ) {
        line( 0, y * 10, windowSize, y * 10 );
    }
}

void reset(){
    gameOver = false;
    for( Snake snake : snakes ) {
        snake = new Snake(fieldSize/2, fieldSize/2);
    }
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
        food.draw();
    } else {
        String modelString = "game over";
        textAlign (CENTER);
        textFont(Font);
        text(modelString,100,100,40);
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

