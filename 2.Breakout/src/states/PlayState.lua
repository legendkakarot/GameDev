PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score
    self.ball = params.ball

    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(-90, -120)
end


function PlayState:update(dt)
    if self.paused then
        if love.keyboard.keysPressed['space'] then
            self.pause=true
            gSounds['pause']:play()
        else
            return
        end
    elseif love.keyboard.keysPressed['space'] then
        self.pause=true
        gSounds['pause']:play()
    end

    if self.ball:collison(self.paddle) then
        gSounds['paddle-hit']:play()
        self.ball.y = self.paddle.y - self.ball.width
        self.ball.dy = -self.ball.dy
        if self.ball.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then
            self.ball.dx = -50+ -(8  * (self.paddle.x + self.paddle.width / 2 - self.ball.x))
        
        elseif self.ball.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
            self.ball.dx = 50+ (8  * math.abs(self.paddle.x + self.paddle.width / 2 - self.ball.x))
        end
    end
    
    self.ball:update(dt)
    self.paddle:update(dt)
    
    for k,brick in pairs(self.bricks) do
        if brick.inPlay and self.ball:collison(brick) then
            self.score = self.score + 10
            brick:hit()
            if self.ball.dx>0 and self.ball.x + 2*scaling_factor<brick.x then
                
                self.ball.dx = -self.ball.dx
                self.ball.x = brick.x-8*scaling_factor

            elseif self.ball.dx<0 and  brick.x + brick.width< self.ball.x + 6*scaling_factor then
                
                self.ball.dx = -self.ball.dx
                self.ball.x = brick.x+32*scaling_factor

            elseif self.ball.y<brick.y then 
                
                self.ball.dy=-self.ball.dy
                self.ball.y=brick.y-self.ball.height
                
            else

                self.ball.dy=-self.ball.dy
                self.ball.y=brick.y+16*scaling_factor

            end
            self.ball.dy = self.ball.dy * 1.01
            
            break
            
        end
    end
    if self.ball.y >= WINDOW_HEIGHT then
        self.health = self.health - 1
        gSounds['hurt']:play()

        if self.health == 0 then
            gStateMachine:change('game-over', {
                score = self.score
            })
        else
            gStateMachine:change('serve', {
                paddle = self.paddle,
                bricks = self.bricks,
                health = self.health,
                score = self.score
            })
        end
    end
end

function PlayState:render()
    self.paddle:render()
    self.ball:render()
    for k,brick in pairs(self.bricks) do
        if brick.inPlay then
            brick:render()
        end
    end
    
    renderScore(self.score)
    renderHealth(self.health)

    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf("PAUSED", 0, WINDOW_HEIGHT / 2 - 16*scaling_factor, WINDOW_WIDTH, 'center')
    end
    
end