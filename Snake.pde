class Snake {

    int posx, posy;
    int moveX, moveY;

    float speed;
    color fillColor;

    Segment[] segments;
    int snakeSize = 1;

    Snake( int x, int y) {
        posx = x;
        posy = y;
        speed = 100;
        speed = speed/frameRate;
        fillColor = color(255,255,192);

        segments = new Segment[100];

        segments[0] = new Segment(this, posx, posy);
    }

    void eat( Food food ) {
        // Grow
        Segment lastSegment = segments[snakeSize - 1];
        // Attach new segment to last one, in opposite direction of moving
        segments[snakeSize] = new Segment(this, lastSegment.posx - moveX, lastSegment.posy - moveY);
        snakeSize++;
        println("snakeSize: " + snakeSize);
    }

    void draw() {
        fill(fillColor);
        for(int i = 0; i < snakeSize; i++) {
            segments[i].draw();
        }
    }

    void move() {
        posx += moveX;
        posy += moveY;

        for(int i = snakeSize-1; i > 0; i--){
            segments[i].move( segments[i-1].posx, segments[i-1].posy);
        }
        segments[0].move( posx, posy );
    }

    void moveUp() {
        if ( moveY == 1 ) return;
        moveX = 0;
        moveY = -1;
    }

    void moveDown() {
        if ( moveY == -1 ) return;
        moveX = 0;
        moveY = 1;
    }

    void moveLeft() {
        if ( moveX == 1 ) return;
        moveX = -1;
        moveY = 0;
    }

    void moveRight() {
        if ( moveX == -1 ) return;
        moveX = 1;
        moveY = 0;
    }
};
