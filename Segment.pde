class Segment {

    int posx, posy;
    Snake snake;
    color fillColor;

    Segment(Snake snake, int x, int y) {
        this.snake = snake;
        fillColor = snake.fillColor;
        move(x, y);
    }

    void move(int x, int y) {
        posx = x % gridSize;
        posy = y % gridSize;
    }

    void draw( boolean head ) {
        fill(fillColor);
        noStroke();
        if ( head ) fill(255, 0, 0);
        rect(posx * fieldSize, posy * fieldSize, fieldSize, fieldSize);
    }
};
