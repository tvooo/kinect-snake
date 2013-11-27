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
        posx = (int)random(1,fieldSize);
        posy = (int)random(1,fieldSize);
    }

    void draw() {
        fill(fillColor);
        rect(posx * 10, posy * 10, 10, 10);
    }

    void ateFood(){
        /*if(foodX == snakeX && foodY == snakeY){
            check = true;
            snakeSize++;
        }*/
    }
};
