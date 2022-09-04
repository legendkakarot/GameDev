Brick = Class{}

function Brick:init(x,y)
    self.x=x 
    self.y=y
    self.inPlay=true

    self.width=32*scaling_factor
    self.height=16*scaling_factor

    self.colour=1
    self.tier=0
end

function Brick: hit()
    if self.inPlay then
        gSounds['brick-hit-2']:play()

        self.inPlay = false
    end
end
    
function Brick:render()
    if self.inPlay then
        love.graphics.draw(gTextures['main'],
        gFrames['bricks'][1+((self.colour-1)*4)+self.tier],
        self.x,self.y,0,scaling_factor,scaling_factor)
    end
end 

