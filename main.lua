local Trigrid = require "Trigrid"

local lg = love.graphics 

local offset = 300

function love.load(arg)
    --uncomment to live code with ZeroBraneStudio
    if arg and arg[#arg] == "-debug" then require("mobdebug").start() end
    
    --inital values
    local topLeftX, topLeftY = 65, 15
    local bottomRightX = topLeftX + 196
    local bottomRightY = topLeftY + 235
    
    -- the values added here adjust the stretch and squash
    topLeftXBounce = bouncerMaker(1, topLeftX, topLeftX + 28)
    topLeftYBounce = bouncerMaker(1, topLeftY, topLeftY + 6)
    bottomRightXBounce = bouncerMaker(1, bottomRightX, bottomRightX + 15)
    bottomRightYBounce = bouncerMaker(1, bottomRightY, bottomRightY + 57)
    
    segmentBounce = bouncerMaker(1, 0, 10)
end

function love.update (dt)
    
end

function love.draw ()
    
    --moving values
    local topLeftX, topLeftY = topLeftXBounce(), topLeftYBounce()
    local bottomRightX = bottomRightXBounce()
    local bottomRightY = bottomRightYBounce()
    
    lg.setColor( 3, 220, 67, 255 )
    
    --square grids
    Trigrid.gridify(topLeftX, topLeftY, bottomRightX, bottomRightY, 4)
    
    Trigrid.gridify(topLeftX, topLeftY + offset, bottomRightX, bottomRightY, 7)
    
    lg.setColor( 249, 240, 19, 255 )
    Trigrid.fullTrigridify(topLeftX, topLeftY, bottomRightX, bottomRightY, 4)
    
    Trigrid.fullTrigridify(topLeftX, topLeftY + offset, bottomRightX, bottomRightY, 7)
        
    Trigrid.fullTrigridify(400, 300, 365, 262, segmentBounce())
    
end

function bouncerMaker(step, startOfInterval, endOfInterval)
	local startOfInterval = startOfInterval or 1
	local endOfInterval = endOfInterval or 10
	local step = step or 1
	local countUp = true
	local counter = startOfInterval
	return function ()
			if countUp then
				counter = counter + step
			else 
				counter = counter - step
			end
			if counter >= endOfInterval or counter <= startOfInterval then 
			countUp = not countUp
			end
			return counter
		end
end