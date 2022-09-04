WINDOW_WIDTH=1270
WINDOW_HEIGHT=650

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
recta={}
recta.x=50
recta.y=100
rectb={}
rectb.x=WINDOW_WIDTH-65
rectb.y=50
ball={}
ball.x=WINDOW_WIDTH / 2
ball.y=WINDOW_HEIGHT / 2
paddlespeed=20
player1Score=0
player2Score=0
ballDX =0
ballDY =0
smallfont = love.graphics.newFont(25)
bigfont=love.graphics.newFont(75)
gameState='start'

end

function love.update(dt)
    if love.keyboard.isDown( 's' ) then
        recta.y=math.min(WINDOW_HEIGHT-100,recta.y+paddlespeed)
        
    end
    if love.keyboard.isDown( 'w' ) then
        recta.y=math.max(0,recta.y-paddlespeed)
    end
    if love.keyboard.isDown( 'down' ) then
        rectb.y=math.min(WINDOW_HEIGHT-100,rectb.y+paddlespeed)
    end
    if love.keyboard.isDown( 'up' ) then
        rectb.y=math.max(0,rectb.y-paddlespeed)
        
    end
        if gameState == 'play' then
            ball.x = ball.x + ballDX * dt
            ball.y = ball.y + ballDY * dt
        end
    end





function love.keypressed(key)
  
    if key == 'escape' then
       
        love.event.quit()
 
    elseif key == 'o' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'
            
       
            ball.x = WINDOW_WIDTH / 2  
            ball.y = WINDOW_HEIGHT / 2  

           
            ballDX = math.random(2) == 1 and 200 or -200
            ballDY = math.random(-50, 50) * 1.5
        end
    end
end

function love.draw()
 
love.graphics.setFont(smallfont)
 love.graphics.printf("hello pong",0,200,WINDOW_WIDTH,'center')
 love.graphics.setFont(bigfont)
 love.graphics.print(tostring(player1Score), WINDOW_WIDTH / 3 - 50, 
 WINDOW_HEIGHT / 6)
love.graphics.print(tostring(player2Score), WINDOW_WIDTH / 2 + 300,
 WINDOW_HEIGHT / 6)
love.graphics.rectangle("fill",recta.x,recta.y,20,100)
love.graphics.rectangle("fill",rectb.x,rectb.y,20,100)
love.graphics.rectangle("fill",ball.x ,ball.y ,20,20)
end
