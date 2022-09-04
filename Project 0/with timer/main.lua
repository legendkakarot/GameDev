function love.load()
  target={}
  target.x=200
  target.y=200
  target.radius=50
  check=true
  score=0
  timer=0
  limit=20
  count=1

  gameFont=love.graphics.newFont(40)
    end
    
    function love.update(dt)
      if check then
      timer=timer+dt

      if timer>count then
        timer=timer%count
        limit=limit-1

        if limit==0 then
            check=false
        end
    end
  end
    end
    
    
    function love.draw()
      if check then
    love.graphics.setColor(1,0,0)
    love.graphics.circle("fill", target.x,target.y,target.radius)
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(gameFont)
    love.graphics.print('Score: '..tostring(score),0,1)
     love.graphics.setColor(1,1,1)
    love.graphics.setFont(gameFont)
     love.graphics.print('Timer: '..tostring(limit),600,1)
    
  end
  if  not check then
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(gameFont)
    love.graphics.print("your final score is:"..tostring(score),200,100)
    love.graphics.print("press space to play again",175,200)
  end
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

function love.keypressed(key)
  if key==('space') then 
    check=true
    score=0
    limit=20
  end
end

 