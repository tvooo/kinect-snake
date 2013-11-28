class Food {
    int posx;
    int posy;
    color fillColor;

    Food(int x, int y) {
        fillColor = color(255,0, 0);
        posx = x;
        posy = y;
    }

    Food() {
        posx = (int)random(1,gridSize);
        posy = (int)random(1,gridSize);
        fillColor = color(255,120, 50);
    }

    void draw() {
        fill(fillColor);
        rect(posx * fieldSize, posy * fieldSize, fieldSize, fieldSize);
    }

    void ateFood(){
        /*if(foodX == snakeX && foodY == snakeY){
            check = true;
            snakeSize++;
        }*/
    }
};
