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
        posx = x;
        posy = y;
    }

    void draw() {
        rect(posx * 10, posy * 10, 10, 10);
    }
};
