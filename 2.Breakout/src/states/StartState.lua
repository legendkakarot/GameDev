
StartState = Class{__includes = BaseState}

local highlighted = 1

function StartState:update(dt)
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        highlighted = highlighted == 1 and 2 or 1
        gSounds['paddle-hit']:play()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gSounds['confirm']:play()

        if highlighted == 1 then
            gStateMachine:change('serve', {
                paddle = Paddle(1),
                bricks = LevelMaker.createMap(5),
                health = 3,
                score = 0
            })
        end
    end
end

function StartState:render()
    love.graphics.setColor(255/255, 0/255, 0/255, 255/255)
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf("BREAKOUT", 0, WINDOW_HEIGHT / 3,
        WINDOW_WIDTH, 'center')
     love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
    love.graphics.setFont(gFonts['medium'])
    if highlighted == 1 then
        love.graphics.setColor(103/255, 255/255, 255/255, 255/255)
    end
    love.graphics.printf("START", 0, WINDOW_HEIGHT / 2 + 70,
        WINDOW_WIDTH, 'center')

    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)

    if highlighted == 2 then
        love.graphics.setColor(103/255, 255/255, 255/255, 255/255)
    end
    love.graphics.printf("HIGH SCORES", 0, WINDOW_HEIGHT / 2 + 180,
        WINDOW_WIDTH, 'center')

    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
end