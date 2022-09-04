ServeState = Class{__includes=BaseState}

function ServeState:enter(params)
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score


    self.ball = Ball()
    self.ball.skin = math.random(7)
end

function ServeState:update(dt)
  
    self.paddle:update(dt)
    self.ball.x = self.paddle.x + (self.paddle.width / 2) - 4*scaling_factor
    self.ball.y = self.paddle.y - 8*scaling_factor

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
    
        gStateMachine:change('play', {
            paddle = self.paddle,
            bricks = self.bricks,
            health = self.health,
            score = self.score,
            ball = self.ball
        })
    end

end

function ServeState:render()
    self.paddle:render()
    self.ball:render()

    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    renderScore(self.score)
    renderHealth(self.health)

    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Press Enter to serve!', 0, WINDOW_HEIGHT / 2,
        WINDOW_WIDTH, 'center')
end