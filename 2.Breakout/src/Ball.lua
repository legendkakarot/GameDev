Ball = Class{}

function Ball:init(skin)
    
    self.width=8*scaling_factor
    self.height=8*scaling_factor

    self.skin=skin
end

function Ball:collison(target)
    if self.x>target.x+target.width or self.x+self.width<target.x then
        return false
    end
    if self.y>target.y+target.height or self.y+self.height<target.y then
        return false
    end
    return true
end

function Ball:update(dt)
    self.x=self.x+self.dx*scaling_factor*dt
    self.y=self.y+self.dy*scaling_factor*dt

    if self.x <= 0 then
        self.x = 0
        self.dx = -self.dx
        gSounds['wall-hit']:play()
    end

    if self.x > WINDOW_WIDTH - 8*scaling_factor then
        self.x = WINDOW_WIDTH - 9*scaling_factor
        self.dx = -self.dx
        gSounds['wall-hit']:play()
    end

    if self.y <= 0 then
        self.y = 0
        self.dy = -self.dy
        gSounds['wall-hit']:play()
    end
end

function Ball:render()
    love.graphics.draw(gTextures['main'], gFrames['balls'][self.skin],
    self.x, self.y,0,scaling_factor,scaling_factor)
end