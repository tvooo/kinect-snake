class AI {

    Snake snake;
    Food food;

    AI( Snake snake, Food food ) {
        this.snake = snake;
        this.food = food;
    }

    void setFood( Food food ) {
        this.food = food;
    }

    void apply() {
        if ( snake.moveX != -1 && food.posx > snake.posx ) {
            snake.moveRight();
        }

        if ( snake.moveX != 1 && food.posx < snake.posx ) {
            snake.moveLeft();
        }

        if ( snake.moveY != -1 && food.posy > snake.posy ) {
            snake.moveDown();
        }

        if ( snake.moveY != 1 && food.posy < snake.posy ) {
            snake.moveUp();
        }
    }
};
