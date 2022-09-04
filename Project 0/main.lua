function love.load()
  target={}
  target.x=200
  target.y=200
  target.radius=50

  score=0
  timer=0

  gameFont=love.graphics.newFont(40)
    end
    
    function love.update(dt)
  
    end
    
    function love.draw()
    love.graphics.setColor(1,0,0)
    love.graphics.circle("fill", target.x,target.y,target.radius)
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(gameFont)
    love.graphics.print(score,0,1)

end

function love.mousepressed( x, y, button, istouch, presses )
  if distanceBetween(target.x,target.y,x,y)<=target.radius then
  if button==1 then
    score=score+1
    target.x=math.random(target.radius,love.graphics.getWidth()-target.radius)
    target.y=math.random(target.radius,love.graphics.getHeight()-target.radius)
  end

 end
end
function distanceBetween(x1,y1,x2,y2)
  return math.sqrt((x1-x2)^2+(y1-y2)^2)
end

