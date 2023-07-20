local hero = {}

hero.images = {}
hero.images[1] = love.graphics.newImage("images/player_1.png")
hero.images[2] = love.graphics.newImage("images/player_2.png")
hero.images[3] = love.graphics.newImage("images/player_3.png")
hero.images[4] = love.graphics.newImage("images/player_4.png")

hero.imageCurrent = 1

hero.line = 1
hero.column = 1
hero.keyPressed = false

function hero.update(paramMap, dt)
    hero.imageCurrent = hero.imageCurrent + 5 * dt
    if math.floor(hero.imageCurrent) > #hero.images then
        hero.imageCurrent = 1
    end

    if love.keyboard.isDown("left", "up", "right", "down") then
        if hero.keyPressed == false then
            local old_column = hero.column
            local old_line = hero.line
            if love.keyboard.isDown("left") and hero.column > 1 then
                hero.column = hero.column - 1
            end
            if love.keyboard.isDown("up") and hero.line > 1 then
                hero.line = hero.line - 1
            end
            if love.keyboard.isDown("right") and hero.column < paramMap.MAP_WIDTH then
                hero.column = hero.column + 1
            end
            if love.keyboard.isDown("down") and hero.line < paramMap.MAP_HEIGHT then
                hero.line = hero.line + 1
            end
            local id = paramMap.GRID[hero.line][hero.column]
            if paramMap.IsSolid(id) then
                hero.column = old_column
                hero.line = old_line
            else
                paramMap.ClearFog2(hero.line, hero.column)
            end
            hero.keyPressed = true
        end
    else
        hero.keyPressed = false
    end
end

function hero.draw(paramMap)
    local x = (hero.column - 1) * paramMap.TILE_WIDTH
    local y = (hero.line - 1) * paramMap.TILE_HEIGHT
    love.graphics.draw(hero.images[math.floor(hero.imageCurrent)], x, y, 0, 2, 2)
end

return hero
