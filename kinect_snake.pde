import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

import java.util.*;

ArrayList<Snake> snakes;
Food food;
AI ai;

Minim minim;

/* Config */
int fieldSize = 30;
int windowSize = 600;

/* Inits */
int gridSize = windowSize / fieldSize;
int specialFoodCounter = 1;

float speed;

boolean gameOver = false;
PFont font = createFont("Courier New Bold",25, true);
PFont playerFont = createFont("Courier New Bold",16, true);
AudioPlayer musicPlayer, soundPlayer;

void setup(){
    size(int(windowSize), int(windowSize),P3D);
    minim = new Minim(this);
    musicPlayer = minim.loadFile("tunnels.wav");
    soundPlayer = minim.loadFile("steal.wav");

    speed = 100;
    speed = speed/frameRate;

    background(0);
    food = new Food();
    reset();
    musicPlayer.loop();
}

void drawText() {
    textAlign(LEFT, TOP);
    textFont(playerFont);
    fill(snakes.get(0).fillColor);
    text("Green: " + snakes.get(0).snakeSize,windowSize*0.05,windowSize*0.05);
    fill(snakes.get(1).fillColor);
    text("Blue: " + snakes.get(1).snakeSize,windowSize*0.70,windowSize*0.05);
}

void draw(){
  if(speed%10 == 0){
        background(0);
        //drawGrid();
        runGame();
        drawText();
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
    snakes.get(0).moveDown();
    snakes.get(1).moveUp();
    ai = new AI(snakes.get(1), food);
}

void runGame(){
    if ( !gameOver ){
        ai.apply();

        food.draw();

        for( Snake snake : snakes ) {
            if(food.posx == snake.posx && food.posy == snake.posy){
                snake.eat( food );
                food = (++specialFoodCounter % 4 == 0) ? new SpecialFood() : new Food();
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
        food.draw();
        for( Snake snake : snakes ) {
            snake.draw();
        }
        soundPlayer.pause();
        textAlign(CENTER, CENTER);
        String modelString = "Game Over";
        stroke(255);
        fill(255);
        textFont(font);
        text(modelString,windowSize*0.5,windowSize*0.5);
    }
}

void keyPressed() {
    if(keyCode == LEFT) { snakes.get(0).goLeft(); }
    if(keyCode == RIGHT) { snakes.get(0).goRight(); }
    if(keyCode == 'A') { snakes.get(1).goLeft(); }
    if(keyCode == 'D') { snakes.get(1).goRight(); }
    if(keyCode == 'R') {reset();}
}

