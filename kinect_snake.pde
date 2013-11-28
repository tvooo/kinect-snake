import java.util.*;

ArrayList<Snake> snakes;

Food food;
AI ai;

int fieldSize = 30;

int windowSize = 600;
int gridSize = windowSize / fieldSize;

int specialFoodCounter = 1;

float speed;

boolean gameOver = false;
PFont Font = createFont("Arial",20, true);

void setup(){
    size(int(windowSize), int(windowSize),P3D);
    speed = 100;
    speed = speed/frameRate;

    background(0);
    food = new Food();
    reset();
}

void draw() {
    if(speed%10 == 0){
        background(0);
        //drawGrid();
        runGame();
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
    ai = new AI(snakes.get(1), food);
}

void runGame(){
    if ( !gameOver ){
        ai.apply();

        food.draw();

        for( Snake snake : snakes ) {
            if(food.posx == snake.posx && food.posy == snake.posy){
                snake.eat( food );
                food = (++specialFoodCounter % 3 == 0) ? new SpecialFood() : new Food();
                ai.setFood( food );
            }
            snake.move();
            snake.draw();
        }

        for ( Snake snake : snakes ) {
            for ( Snake otherSnake : snakes ) {
                if ( snake.collides(otherSnake) ) {
                    if ( snake.nomNomMode ) {
                        otherSnake.snakeSize = snake.collidesWhere(otherSnake);
                    } else {
                        gameOver = true;
                    }
                }
            }
        }
    } else {
        String modelString = "game over";
        stroke(255);
        fill(255);
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

