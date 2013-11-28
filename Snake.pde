class Snake {

    int posx, posy;
    int moveX, moveY;

    float speed;
    color fillColor;

    Segment[] segments;
    int snakeSize = 1;

    boolean nomNomMode = false;
    int nomNomCounter = 0;

    Snake( int x, int y, color col) {
        posx = x;
        posy = y;
        fillColor = col;
        speed = 100;
        speed = speed/frameRate;

        segments = new Segment[100];

        segments[0] = new Segment(this, posx, posy);
    }

    void eat( Food food ) {
        // Grow
        Segment lastSegment = segments[snakeSize - 1];
        // Attach new segment to last one, in opposite direction of moving
        segments[snakeSize] = new Segment(this, lastSegment.posx - moveX, lastSegment.posy - moveY);
        snakeSize++;

        if ( food instanceof SpecialFood ) {
            nomNomMode = true;
            nomNomCounter = 25;
            println("NOMNOMMODE ACTIVATED");
        }

        println("snakeSize1: " + snakes.get(0).snakeSize);
        println("snakeSize2: " + snakes.get(1).snakeSize);
    }

    void draw() {
        boolean head = false;
        fill(fillColor);
        for(int i = 0; i < snakeSize; i++) {
            head = nomNomMode && i == 0;
            segments[i].draw( head );
        }
    }

    void move() {
        posx += moveX + gridSize;
        posy += moveY + gridSize;
        posx %= gridSize;
        posy %= gridSize;

        for(int i = snakeSize-1; i > 0; i--){
            segments[i].move( segments[i-1].posx, segments[i-1].posy);
        }
        segments[0].move( posx, posy );

        if ( nomNomMode ) {
            if ( --nomNomCounter <= 0 ) {
                nomNomMode = false;
            }

        }
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

    /*
    < -1 : 0
    V  0 : 1
    >  1 : 0
    ^  0 : -1
    */
    void goLeft() {
        if ( moveX != 0 ) {
            moveY = -moveX;
            moveX = 0;
        } else {
            moveX = moveY;
            moveY = 0;
        }
    }

    void goRight() {
        if ( moveX != 0 ) {
            moveY = moveX;
            moveX = 0;
        } else {
            moveX = -moveY;
            moveY = 0;
        }
    }

    boolean collides( Snake otherSnake ) {
        boolean collision = false;
        for ( int i = 0; i < otherSnake.snakeSize; i++ ) {
            if ( this.posx == otherSnake.segments[i].posx &&
                 this.posy == otherSnake.segments[i].posy) {
                if ( !(this == otherSnake && i == 0)) {
                    collision = true;
                }
            }
        }
        return collision;
    }

    int collidesWhere( Snake otherSnake ) {
        int result = -1;
        for ( int i = 0; i < otherSnake.snakeSize; i++ ) {
            if ( this.posx == otherSnake.segments[i].posx &&
                 this.posy == otherSnake.segments[i].posy) {
                if ( !(this == otherSnake && i == 0)) {
                    result = i;
                }
            }
        }
        return result;
    }
};
