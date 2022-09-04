

require 'src/Dependencies'

function love.load()
    math.randomseed(os.time())

    love.window.setTitle('Breakout')
    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = false,
        vsync = true
        })

    gFonts = {
        ['small'] = love.graphics.newFont('fonts/font.ttf', 32),
        ['medium'] = love.graphics.newFont('fonts/font.ttf', 64),
        ['large'] = love.graphics.newFont('fonts/font.ttf', 128)
    }
    love.graphics.setFont(gFonts['small'])

    gTextures = {
        ['background'] = love.graphics.newImage('graphics/background.png'),
        ['main'] = love.graphics.newImage('graphics/breakout.png'),
        ['arrows'] = love.graphics.newImage('graphics/arrows.png'),
        ['hearts'] = love.graphics.newImage('graphics/hearts.png'),
        ['particle'] = love.graphics.newImage('graphics/particle.png')
    }
    
    gSounds = {
        ['paddle-hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['wall-hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static'),
        ['confirm'] = love.audio.newSource('sounds/confirm.wav', 'static'),
        ['select'] = love.audio.newSource('sounds/select.wav', 'static'),
        ['no-select'] = love.audio.newSource('sounds/no-select.wav', 'static'),
        ['brick-hit-1'] = love.audio.newSource('sounds/brick-hit-1.wav', 'static'),
        ['brick-hit-2'] = love.audio.newSource('sounds/brick-hit-2.wav', 'static'),
        ['hurt'] = love.audio.newSource('sounds/hurt.wav', 'static'),
        ['victory'] = love.audio.newSource('sounds/victory.wav', 'static'),
        ['recover'] = love.audio.newSource('sounds/recover.wav', 'static'),
        ['high-score'] = love.audio.newSource('sounds/high_score.wav', 'static'),
        ['pause'] = love.audio.newSource('sounds/pause.wav', 'static'),

        ['music'] = love.audio.newSource('sounds/music.wav', 'static')
    }

    gFrames = {
        ['paddles'] = GenerateQuadsPaddles(gTextures['main']),
        ['balls'] = GenerateQuadsBalls(gTextures['main']),
        ['bricks'] = GenerateQuadsBricks(gTextures['main']),
        ['hearts'] = GenerateQuads(gTextures['hearts'],10,9)
    }
    

    gStateMachine = StateMachine {
        ['start'] = function() return StartState() end,
        ['play'] = function() return PlayState() end,
        ['serve'] = function() return ServeState() end,
        ['game-over'] = function() return GameOverState() end
    }
    gStateMachine:change('start')

    love.keyboard.keysPressed = {}
end


function love.update(dt)

    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
end


function love.keypressed(key)
    if key=='escape' then
        love.event.quit()
    end
    love.keyboard.keysPressed[key] = true
end


function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end


function love.draw()
   
    local backgroundWidth = gTextures['background']:getWidth()
    local backgroundHeight = gTextures['background']:getHeight()

    love.graphics.draw(gTextures['background'], 
        0, 0, 
        0,
        WINDOW_WIDTH / (backgroundWidth - 1), WINDOW_HEIGHT / (backgroundHeight - 1))
    
  
    gStateMachine:render()
   
    displayFPS()
    
end


function displayFPS()
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5, 5)
    love.graphics.setColor(255, 255, 255, 255)
end

function renderHealth(health)

    local healthX = WINDOW_WIDTH - 100*scaling_factor
    

    for i = 1, health do
        love.graphics.draw(gTextures['hearts'], gFrames['hearts'][1], healthX, 4*scaling_factor,0,scaling_factor,scaling_factor)
        healthX = healthX + 11*scaling_factor
    end

    for i = 1, 3 - health do
        love.graphics.draw(gTextures['hearts'], gFrames['hearts'][2], healthX, 4*scaling_factor,0,scaling_factor,scaling_factor)
        healthX = healthX + 11*scaling_factor
    end
end
function renderScore(score)
    love.graphics.setFont(gFonts['small'])
    love.graphics.print('Score:', WINDOW_WIDTH - 80*scaling_factor, 5*scaling_factor)
    love.graphics.printf(tostring(score), WINDOW_WIDTH - 50*scaling_factor, 5*scaling_factor, 40*scaling_factor, 'right')
end