# Trigrid
Dynamically drawing triangular grids in lua / LÖVE

This implementation relies on LÖVE, but onl to the extent that it expects a line method that works like the one LÖVE provides. Switching out the method should be easily done by changing the line assiging lg in Trigrid.lua and importing into another framework.

# Method listings
Trigrid.gridify (x, y, width, height, numOfSegments)

This draws a square grid within the defined box with the number of boxes along each side corresponding to the numOfSegments parameter

Trigrid.trigridify (x, y, width, height, numOfSegments)

This draws a triangle grid within a triangle in the defined box with triangles along each side corresponding to the numOfSegments parameter, (that is, that many triagles with the flat sides touching the top and bottom edges).

Trigrid.fullTrigridify (x, y, width, height, numOfSegments)

This draws a triangle grid within the entire defined box with triangles along each side corresponding to the numOfSegments parameter, (that is, that many triagles with the flat sides touching the top and bottom edges).
Lack of a good example of code that does this is what caused me to post this repo in the first place.

The rest of the methods are pretty much helper methods, mostly to do with manipulating flat tables of points.


