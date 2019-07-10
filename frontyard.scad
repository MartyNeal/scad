// -*- mode: scad; orgstruct-heading-prefix-regexp: "// " -*-
wallHeight = 96;

// * Garage
garageDoor = [196, 1.02, 83];
garageDoorEnclosing = [garageDoor.x + 36 * 2, 1, wallHeight];

difference() {
    union() {
        translate([0,-1,0])
            cube(garageDoorEnclosing);

        color("red")
            translate([36,-1.01,0])
            cube(garageDoor);
    }
    
    for (i = [0,1,2,3]) {
        translate([43+46.5*i, -1.05, 45])
            cube([43, 1.09, 17]);
    }
}


// * Driveway
driveway = [18*12+2, (22*12+4) + (7*12+9), 1];
color("lightgrey")
translate([24,0, -1])
cube(driveway);

// ** Triangle
color("lightgrey")
translate([24+driveway.x,0,-1]) {
    linear_extrude(height=1.01)
    polygon(points=[[0,0], [120, 0], [0,70]]);
}

// * Path
module path_small() {
    function redish() = [rands(.7,.9,1)[0],rands(.1,.2,1)[0],rands(.1,.2,1)[0]];
    color(redish())
    cube([16,24,1]);
 
    color(redish())
    translate([16,0,0])
    cube([24,16,1]);

    color(redish())
    translate([0,24,0])
    cube([16,8,1]);

    color(redish())
    translate([16,16,0])
    cube([16,16,1]);

    color(redish())
    translate([32,16,0])
    cube([8,16,1]);

    color(redish())
    translate([0,32,0])
    cube([24,16,1]);
    
    color(redish())
    translate([24,32,0])
    cube([16,16,1]);
}
translate([-16,0,-1])
path_small();

translate([-56,0,-1])
path_small();

color("brown")
translate([-56,48,-1])
cube([80,220,1]);
// 

// * Porch
color("lightgrey")
translate([garageDoorEnclosing.x, -northEntryWall.y, -1])
cube([doorEntryWall.x+183.1, northEntryWall.y,1]);

// ** Railings
numFrontRails = 17;
numSideRails = 9;
color([.5,.5,.5])
translate([garageDoorEnclosing.x + doorEntryWall.x,-4,5]) {
    // bottom front
    cube([numFrontRails * 10.5,4,4]);

    // top front
    translate([0,0,30.5])
    cube([numFrontRails * 10.5,4,4]);

    // front pickets
    for (i = [0 : numFrontRails])
        translate([i*10.5,0,0])
            cube([4,4,34.5]);

    // bottom left
    translate([numFrontRails * 10.5,-numSideRails * 10.3,0])
    cube([4,numSideRails*10.5,4]);

    // top left
    translate([numFrontRails * 10.5,-numSideRails * 10.3,30.5])
    cube([4,numSideRails*10.5,4]);

    // left pickets
    translate([numFrontRails * 10.5,0,0])
        for (i = [0 : numSideRails])
            translate([0,-10.3*i,0])
                cube([4,4,34.5]);

    translate([0,0,-5]) {
    // front right foot
        cube([4,4,5]);
    // front left foot
        translate([numFrontRails*10.5,0])
        cube([4,4,5]);
    // left back foot
        translate([numFrontRails*10.5,-numSideRails*10.3])
        cube([4,4,5]);
    }
}

// * Yard
yard = [32*12+1, 22*12+4,1];
color("grey")
translate([driveway.x+24, 0, -1])
cube(yard);
// ** Arborvida
color("green")
translate([houseSouthSide.x+49,0,0])
cube([60,268,144]);
// ** barkdust bed
*color("brown")
translate([garageDoorEnclosing.x + doorEntryWall.x,0,-1])
linear_extrude(height=1.01)
polygon(points=[[0,0],
                [10, 20],
                [20, 28],
                [30, 35],
                [40, 37],
                [50, 39],
                [60, 40],
                [70, 41],
                [80, 42],
                [90, 43],
                [100, 43],
                [110, 43],
                [120, 42],
                [130, 41],
                [140, 39],
                [150, 35],
                [160, 28],
                [170, 20],
                [180, 0]
            ]);

// ** new path
module foo(x,y,x1,y1) {
    translate([x,y])
        cube([x1,y1,1]);
}

// top line
*translate([25+driveway.x,0,-1])
linear_extrude(height=2.01)
polygon(points=[
[80,24],
[80,32],
[72, 32],
[72, 40],
[64, 40],
[64, 48],
[64, 56],                
[56, 56],
[56, 64],
[56, 72],
[48, 72],
[48, 80],
[48, 88],
[48, 96],
[48, 104],
[56, 104],
[56, 112],
[56, 120],
[64, 120],
[64, 128],
[72, 128],
[80, 128],
[80, 136],
[88, 136],
[96, 136],
[96, 144],
[104, 144],
[112, 144],
[120, 144],
[120, 136],
[128, 136],
[136, 136],
[136, 128],
[144, 128],
[152, 128],
[152, 120],
[160, 120],
[168, 120],
[168, 112],
[176, 112],
[184, 112],
[184, 104],
[192, 104],
[200, 104],
[200, 96],
[208, 96],
[216, 96],
[216, 88],
[224, 88],
[232, 88],
[232, 80],
[240, 80],
[248, 80],
[248, 72],
[256, 72],
[264, 72],
[264, 64],
[272, 64],
[272, 56],
[280, 56],
[280, 48],
[288, 48],
[288, 40],
[288, 32],
[296, 32],
[296, 24],
[296, 16],
[304, 16],
[304, 8],
[304, 0],
[120, 0]
            ]);

// bottom line
*translate([55+driveway.x,0,-1])
linear_extrude(height=2.01)
polygon(points=[
[48,268],
[48,260],
[48,252],
[56,252],
[56,244],
[64,244],
[64,236],
[72,236],
[72,228],
[80,228],
[80,220],
[88,220],
[96,220],
[96,212],
[104,212],
[112,212],
[112,204],
[120,204],
[128,204],
[128,196],
[136,196],


[350,268]
]);


*translate([25+driveway.x,0]) {
    foo(0,100,16,16);
}

// * Sidewalk
sidewalk = [46,46,1];
function greyish() = rands(.8,.9,3);
for (i = [0 : 8]){
    color(greyish())
        translate([24 + driveway.x + i*sidewalk.x, 22*12+4, -1])
        cube(sidewalk);
}

for (i = [0 : 1]) {
    color(greyish())
        translate([26-47*2 + i*sidewalk.x, 22*12+4, -1])
        cube(sidewalk);
}



// * Planter Strip
color("green")
translate([24+driveway.x, 22*12+4 + sidewalk.y, -1])
cube([100+6,47,1]);

color("red")
translate([24+driveway.x + 100+6, 22*12+4 + sidewalk.y, -1])
cube([96+6,47,1]);

color("green")
translate([24+driveway.x + 100 +96+12, 22*12+4 + sidewalk.y, -1])
cube([114+6,47,1]);

// neighbors river rock on our property
color("red")
translate([24+driveway.x + 100 +96+18+114, 22*12+4 + sidewalk.y, -1])
cube([86,47,1]);

// * Entry Walls

translate([0,-35*12,0])
cube([1,35*12,wallHeight]);

northEntryWall = [1, 217];
doorEntryWall = [95,1];
southEntryWall = [1, 120];
northBaySide = [30, 1];
southBaySide = [31, 1];
sideBayWindowEnclosure = [8+18+8, 1];
bayWindowEnclosure = [7+60+7, 1];
houseSouthSide = [
    garageDoorEnclosing.x +
    doorEntryWall.x +
    northBaySide.x +
    cos(45) * sideBayWindowEnclosure.x +
    bayWindowEnclosure.x +
    cos(45) * sideBayWindowEnclosure.x +
    southBaySide.x,
    -northEntryWall.y + southEntryWall.y
    ];

translate([garageDoorEnclosing.x, -northEntryWall.y, 0]) {
    translate([-1,0,0])
    cube([1, northEntryWall.y, wallHeight]);
    translate([0, -1, 0])
    cube([doorEntryWall.x,1,wallHeight]);
    translate([doorEntryWall.x,0,0]) {
        cube([1, southEntryWall.y, wallHeight]);
        translate([0,southEntryWall.y,0]) {
            translate([0,-1,0])
            cube([northBaySide.x, 1, wallHeight]);
            translate([30,0,0]) {
                rotate([0,0,45]) {
                    translate([0,-1,0])
                    cube([sideBayWindowEnclosure.x,1,wallHeight]);
                    translate([sideBayWindowEnclosure.x,0,0]) {
                        rotate([0,0,-45]) {
                            translate([0,-1,0])
                            cube([bayWindowEnclosure.x,1,wallHeight]);
                            translate([bayWindowEnclosure.x,0,0]) {
                                rotate([0,0,-45]) {
                                    translate([0,-1,0])
                                    cube([sideBayWindowEnclosure.x,1,wallHeight]);
                                    translate([sideBayWindowEnclosure.x,0,0]) {
                                        rotate([0,0,45]) {
                                            translate([0,-1,0])
                                            cube([southBaySide.x, 1, wallHeight]);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

// * Notes

/*
100 // driveway to bricks 
96 // bricks
114 // bricks to neighbors

42 // planter strip width
39 // side path width
63 // side path length

338 
26 of neighbors river rock on our property
12 of arborvida at edge of yard

106 // south of center line of driveway
108 // north of center line of driveway
10 // wider than south of garage door
11 // wider than north of garage door

*/

// * Bezier curves
/* 
        Bernstein Basis Functions 

        For Bezier curves, these functions give the weights per control point. 

*/ 
function BEZ03(u) = pow((1-u), 3); 
function BEZ13(u) = 3*u*(pow((1-u),2)); 
function BEZ23(u) = 3*(pow(u,2))*(1-u); 
function BEZ33(u) = pow(u,3); 

// Calculate a singe point along a cubic bezier curve 
// Given a set of 4 control points, and a parameter 0 <= 'u' <= 1 
// These functions will return the exact point on the curve 
function PointOnBezCubic2D(p0, p1, p2, p3, u) = [ 
        BEZ03(u)*p0[0]+BEZ13(u)*p1[0]+BEZ23(u)*p2[0]+BEZ33(u)*p3[0], 
        BEZ03(u)*p0[1]+BEZ13(u)*p1[1]+BEZ23(u)*p2[1]+BEZ33(u)*p3[1]]; 

function PointOnBezCubic3D(p0, p1, p2, p3, u) = [ 
        BEZ03(u)*p0[0]+BEZ13(u)*p1[0]+BEZ23(u)*p2[0]+BEZ33(u)*p3[0], 
        BEZ03(u)*p0[1]+BEZ13(u)*p1[1]+BEZ23(u)*p2[1]+BEZ33(u)*p3[1], 
        BEZ03(u)*p0[2]+BEZ13(u)*p1[2]+BEZ23(u)*p2[2]+BEZ33(u)*p3[2]];

color("green")
translate([25+driveway.x+120,0,1.01]) {
    upperPoints = [
        [0,0],
        for (u = [0 : .004 : 1])  PointOnBezCubic2D(
            [-120, 70] * .25,
            [-160, 200],
            [70,240],
            [180,0], u) 
    ];
    polygon(upperPoints);

}

color("green")
translate([25+driveway.x+50,0,1.02]) {
    c=[302,269];
    lowerPoints = [
        for (u = [0 : .01 : 1])  PointOnBezCubic2D(
            [0,c.y],
            [00,220],
            [200,280],
            [c.x,20], u),
        c
    ];
    echo(lowerPoints);
    polygon(lowerPoints);
}



