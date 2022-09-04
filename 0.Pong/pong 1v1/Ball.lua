
Ball = Class{}

function Ball:init(x, y, radius)
    self.x = x
    self.y = y
    
    self.radius=radius
    
    self.dx = math.random(2) == 1 and -500 or 500
    self.dy = math.random(-50, 50)
end


function Ball:reset()
    self.x = WINDOW_WIDTH / 2 
    self.y = WINDOW_HEIGHT / 2 
    self.dx = math.random(2) == 1 and -500 or 500
    self.dy = math.random(-200, 200)
end


function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:render()
    love.graphics.circle('fill', self.x, self.y, self.radius)
end

function Ball:collision(Paddle)
    if self.x-self.radius > Paddle.x + Paddle.width or Paddle.x > self.x + self.radius then
        return false
    end

    if self.y-self.radius > Paddle.y + Paddle.height or Paddle.y > self.y + self.radius then
        return false
    end 

    return true
    
     
end