local lg = love.graphics 

local Trigrid = {}

function Trigrid.trigridify (x, y, width, height, numOfSegments)
    numOfSegments = numOfSegments or 4
    
    local endX, endY = x + width, y + height;
       
    local bottomDots = Trigrid.segmentLine (  x, endY,
                                endX, endY,
                                numOfSegments)                       
    local leftDots = Trigrid.segmentLine (  x, endY,
                                x + (width/2), y,
                                numOfSegments)
    
    
    local rightDots = Trigrid.segmentLine (  endX, endY,
                                x + (width/2), y,
                                numOfSegments)
    
    Trigrid.drawLinesBetweenPoints (leftDots, bottomDots)
    
    Trigrid.drawLinesBetweenPoints (leftDots, rightDots)
    
    Trigrid.drawLinesBetweenPoints (bottomDots, Trigrid.reversePointList(rightDots, 2))
end

function Trigrid.fullTrigridify (x, y, width, height, numOfSegments)
    numOfSegments = numOfSegments or 4
    
    local endX, endY = x + width, y + height;
    
    local topDots = Trigrid.segmentLine (  x, y,
                                endX, y,
                                numOfSegments)
    
    local bottomDots = Trigrid.segmentLine (  x, endY,
                                endX, endY,
                                numOfSegments)                       
    local leftDots = Trigrid.segmentLine (  x, y,
                                x, endY,
                                numOfSegments)
    
    
    local rightDots = Trigrid.segmentLine (  endX, y,
                                endX, endY,
                                numOfSegments)
    
    local revTopDots = Trigrid.reversePointList(topDots)
    
    local shiftedBottom = Trigrid.shiftPointList(bottomDots, 2, width * 0.5)
    for i = 1, #shiftedBottom, 2 do
        if shiftedBottom[i] > endX then
            shiftedBottom[i + 1] = y + height - ((height)/(shiftedBottom[i] - topDots[i])) * (shiftedBottom[i] - endX)

            shiftedBottom[i] = endX
        end
    end
    
    local leftShiftedBottom = Trigrid.shiftPointList(bottomDots, 2, width * -0.5)
    for i = 1, #leftShiftedBottom, 2 do
        if leftShiftedBottom[i] < x then
            leftShiftedBottom[i + 1] = y + height - ((height)/(leftShiftedBottom[i] - topDots[i])) * (leftShiftedBottom[i] - x)

            leftShiftedBottom[i] = x
        end
    end
    
    Trigrid.drawLinesBetweenPoints (Trigrid.removeEveryOtherPointInList(leftDots, 2), Trigrid.shiftPointList(Trigrid.reversePointList(bottomDots), 2, -width/2))
    
    Trigrid.drawLinesBetweenPoints (Trigrid.removeEveryOtherPointInList(rightDots, 2), Trigrid.shiftPointList(bottomDots, 2, width * 0.5))
    
    Trigrid.drawLinesBetweenPoints (topDots, shiftedBottom)
    
    Trigrid.drawLinesBetweenPoints (topDots, leftShiftedBottom)
    
    Trigrid.drawLinesBetweenPoints (leftDots, rightDots)

end

--... expects a list of numerical shifts to apply to each 
function Trigrid.shiftPointList (pointList, dimension, ...)
    dimension = dimension or 2
    
    local shifts = {...}
    local result = {} 
   
    for i = 1, #pointList, dimension do
        
        for j = 1, dimension do
            table.insert(result, pointList[i + j - 1] + (shifts[j] or 0))
        end
        
    end
    
    return result
end

function Trigrid.removeEveryOtherPointInList (pointList, dimension, parity)
    dimension = dimension or 2
    
    local result = {} 
   
    parity = parity == nil or parity
   
    for i = 1, #pointList, dimension do
        
        if parity then
            for j = 1, dimension do
            table.insert(result, pointList[i + j - 1])
            end
        end
        
        parity = not parity
        
    end
    
    return result
    
end

function Trigrid.reversePointList (pointList, dimension)
    dimension = dimension or 2
    
    local result = {} 
   
    for i = 1, #pointList, dimension do
        
        for j = dimension, 1, -1 do
            table.insert(result, 1, pointList[i + j - 1])
        end
        
    end
    
    return result
end

function Trigrid.gridify (x, y, width, height, numOfSegments)
    numOfSegments = numOfSegments or 4
    
    
    local endX, endY = x + width, y + height;
    
    local topDots = Trigrid.segmentLine (  x, y,
                                endX, y,
                                numOfSegments)
                            
    local bottomDots = Trigrid.segmentLine (  x, endY,
                                endX, endY,
                                numOfSegments)                       
    local leftDots = Trigrid.segmentLine (  x, y,
                                x, endY,
                                numOfSegments)
    
    local rightDots = Trigrid.segmentLine (  endX, y,
                                endX, endY,
                                numOfSegments)
    
    Trigrid.drawLinesBetweenPoints (topDots, bottomDots)
    
    Trigrid.drawLinesBetweenPoints (leftDots, rightDots)
    
end

function Trigrid.drawLinesBetweenPoints (points1, points2)
    for i = 1, math.min(#points1, #points2), 2 do
        lg.line(points1[i], points1[i + 1], points2[i], points2[i + 1]);
    end
end

function Trigrid.lerp (startVal, endVal, t)
    return startVal + t * (endVal-startVal)
end

function Trigrid.lerpPoint (x1, y1, x2, y2, t)
   return Trigrid.lerp(x1, x2, t), Trigrid.lerp(y1, y2, t)
end

--numOfSegments indicates the number of segements
--between the points that will be returned.
function Trigrid.segmentLine (x1, y1, x2, y2, numOfSegments)
    local t, newX, newY
    local points = {}
    
    --0, so we get the top end
    for step = 0, numOfSegments do
        t = step / numOfSegments;
        newX, newY = Trigrid.lerpPoint(x1, y1, x2, y2, t)
        table.insert(points, newX);
        table.insert(points, newY);
    end
    
    return points;
end

return Trigrid