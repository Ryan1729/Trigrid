local Trigrid = require "Trigrid"

local lg = love.graphics 

function love.load(arg)
    if arg and arg[#arg] == "-debug" then require("mobdebug").start() end
end

function love.update (dt)
  
end

function love.draw ()
  
    local startX, startY = 65, 15
    local xOff = startX + 196
    local yOff = startY + 235
    local endX, endY = 224, 380
    
    lg.setColor( 3, 220, 67, 255 )
    Trigrid.gridify(startX, startY, xOff, yOff, 4)
    
    Trigrid.gridify(startX, startY + 300, xOff, yOff, 10)
    
    lg.setColor( 249, 240, 19, 255 )
    Trigrid.fullTrigridify(startX, startY, xOff, yOff, 4)
    
    Trigrid.fullTrigridify(startX, startY + 300, xOff, yOff, 10)
    
end
