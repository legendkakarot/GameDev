WINDOW_WIDTH=1270
WINDOW_HEIGHT=650
Class= require"class"
require "Ball"
require"Paddle"
function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
love.window.setTitle("PONG")
math.randomseed(os.time())
paddlespeed=10
player1Score=0
player2Score=0
ball = Ball(WINDOW_WIDTH / 2,WINDOW_HEIGHT / 2,20,20)
fellow1=Paddle(50,100,20,100)
fellow2=Paddle(WINDOW_WIDTH-65,50,20,100)
sounds = {
    ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
    ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
    ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static')
}
smallfont = love.graphics.newFont(25)
bigfont=love.graphics.newFont(75)
gameState='start'

end

function love.update(dt)
    if love.keyboard.isDown( 's' ) then
        fellow1.dy=paddlespeed
        
    end
    if love.keyboard.isDown( 'w' ) then
        fellow1.dy=-paddlespeed
    end
    if love.keyboard.isDown( 'down' ) then
        fellow2.dy=paddlespeed
    end
    if love.keyboard.isDown( 'up' ) then
        fellow2.dy=-paddlespeed
        
    end
    if gameState=='serve' then
        ball.dy=math.random(-50,50)
        if servingplayer==0 then
            ball.dx=math.random(200,300)
        else ball.dx=-math.random(200,300)
        end
    end

        if gameState == 'play' then
            if ball.x>=WINDOW_WIDTH then
                player1Score=player1Score+1
                servingplayer=0
                sounds['score']:play()
                if player1Score==5 then
                    winner=1
                    gameState='over'
                    
                else gameState='serve'
                    ball:reset()
                end
            end
            if ball.x<=-ball.width then
                player2Score=player2Score+1
                servingplayer=1
                sounds['score']:play()
                if player2Score==5 then
                    gameState='over'
                    winner=2
                    
                else gameState='serve'
                    ball:reset()
                end
            end
            if ball:collision(fellow1) then
                ball.dx=-ball.dx*1.1
                ball.x=ball.x+5
                if ball.dy < 0 then
                    ball.dy = -math.random(10, 200)
                else
                    ball.dy = math.random(10, 200)
                end
                
            sounds['paddle_hit']:play()
            end
            if ball:collision(fellow2) then
                ball.dx=-ball.dx*1.1
                ball.x=ball.x-5
                if ball.dy < 0 then
                    ball.dy = -math.random(10, 200)
                else
                    ball.dy = math.random(10, 200)
                end
                
                
            sounds['paddle_hit']:play()
            end
            if ball.y<=0 then
                ball.y=ball.height
                ball.dy=-ball.dy
                sounds['wall_hit']:play()
            end
            if ball.y>=WINDOW_HEIGHT then
                ball.y=WINDOW_HEIGHT-ball.height
                ball.dy=-ball.dy
                sounds['wall_hit']:play()
            end
           ball:update(dt)
        end
        fellow2:update(dt)
        fellow1:update(dt)
    end





function love.keypressed(key)
  
    if key == 'escape' then
       
        love.event.quit()
 
    elseif key == 'o' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        elseif  gameState=='serve'then
            gameState='play'
        elseif gameState=='over'then
            gameState='serve'
            player1Score=0
            player2Score=0
            if winner==1 then
                servingplayer=1
                ball:reset()
            else servingplayer=0
                ball:reset()

            end

    else
            gameState = 'start'
            
       ball:reset()
        end
    end
end

function love.draw()
    love.graphics.setFont(bigfont)
    love.graphics.setColor(1,1,1)
    if gameState=='serve' then
        if servingplayer==0 then
            love.graphics.printf("Serve: Player 1",0,WINDOW_HEIGHT-200,WINDOW_WIDTH,'center')
        else
            love.graphics.printf("Serve: Player 2",0,WINDOW_HEIGHT-200,WINDOW_WIDTH,'center')
        end
    end
    if gameState=='over' then
        if winner==1 then
            love.graphics.printf("Winner: Player 1",0,WINDOW_HEIGHT-200,WINDOW_WIDTH,'center')
        else
            love.graphics.printf("Winner: Player 2",0,WINDOW_HEIGHT-200,WINDOW_WIDTH,'center')
        end
        love.graphics.setFont(smallfont)
        love.graphics.printf("Press Enter to play again!",0,WINDOW_HEIGHT/4,WINDOW_WIDTH,'center')
    end
love.graphics.setFont(smallfont)
 love.graphics.printf("hello pong",0,200,WINDOW_WIDTH,'center')
 love.graphics.setFont(bigfont)
 love.graphics.print(tostring(player1Score), WINDOW_WIDTH / 3 - 50, 
 WINDOW_HEIGHT / 6)
love.graphics.print(tostring(player2Score), WINDOW_WIDTH / 2 + 300,
 WINDOW_HEIGHT / 6)
fellow1:render()
fellow2:render()
ball:render()
showFPS()
end
function showFPS()
    love.graphics.setFont(smallfont)
    love.graphics.setColor(0,1,0)
    love.graphics.print("FPS "..tostring(love.timer.getFPS()),WINDOW_WIDTH/2-40,WINDOW_HEIGHT-75)
 end