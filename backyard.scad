// -*- mode: scad; orgstruct-heading-prefix-regexp: "// " -*-
// * House
house = [31*12+8, 1, 96];
foundation = [house.x, 1, 10];
slider = [60,1.02,82];
window = [60,1.02,42];

color("grey")
translate([0,-1,0])
cube(foundation);

// ** Back wall
difference() {
        translate([0,-1,foundation.z])
        cube(house);

    // slider
    translate([288, -1.01, foundation.z + 4])
        cube(slider);

    // window
    translate([98, -1.01, foundation.z + 44])
        cube(window);
}

// ** Bedroom window wall
bedroom_wall = [1, 16*12+2, house.z];
bedroom_wall_foundation = [1, bedroom_wall.y, 10];
bedroom_window = [1.02, 60, 34];

color("grey")
translate([house.x-1, -bedroom_wall.y, 0])
cube(bedroom_wall_foundation);

difference() {
    translate([house.x-1, -bedroom_wall.y, foundation.z])
        cube(bedroom_wall);

    // window
    translate([house.x - 1.01, -128, foundation.z + 50])
        cube(bedroom_window);
}
// ** Family room wall
family_room_wall = [13*12+8, 1, house.z];
family_room_slider = [6*12+10, 1.02, 82];
family_room_wall_foundation = [family_room_wall.x, 1, 10];

color("grey")
translate([house.x, -bedroom_wall.y - 1, 0])
cube(family_room_wall_foundation);

difference() {
    translate([house.x, -bedroom_wall.y - 1, foundation.z])
        cube(family_room_wall);

    // window
    translate([house.x + 3*12+10, -bedroom_wall.y-1.01, foundation.z + 4 ])
        cube(family_room_slider);
}

// ** Roof
overhang=[6, 4, 4];

color("green")
    hull() {

        translate([house.x+overhang.x, overhang.y, house.z - overhang.z + foundation.z])
            rotate([90, 0, 0])
            cylinder(r=1, h=bedroom_wall.y + overhang.y);

        translate([house.x/2, overhang.y, house.z + 8*12+2 + foundation.z])
            rotate([90,0,0])
            cylinder(r=1,h=bedroom_wall.y + overhang.y);
    }

color("green")
    hull() {
        translate([-overhang.x, overhang.y, house.z-overhang.z + foundation.z ])
            rotate([90, 0, 0])
            cylinder(r=1, h=bedroom_wall.y + overhang.y);


        translate([house.x/2, overhang.y, house.z + 8*12+2 + foundation.z])
            rotate([90,0,0])
            cylinder(r=1,h=bedroom_wall.y + overhang.y);
    }

translate([0,0,house.z+foundation.z])
rotate([90,0,0])
linear_extrude(height=1)
polygon(points=[[0,0], [house.x, 0], [house.x/2, 8*12+2]]);

// * Yard
yard = [45*12+2, 34*12+9];
color([0, .7, 0])
translate([0, 0, -1])
cube([yard.x, yard.y, 1]);

south_strip = [61, yard.y+100];
color([0, .7, 0])
translate([-south_strip.x, -100, -1])
cube([south_strip.x, south_strip.y, 1]);

north_strip = [62, yard.y + 250];
color([0, .7, 0])
translate([yard.x, -250, -1])
cube([north_strip.x, north_strip.y, 1]);

patch = [family_room_wall.x, bedroom_wall.y, 1];
translate([house.x, -bedroom_wall.y, -1])
color([0, .7, 0])
cube(patch);

// ** Fence
// *** West
for (i = [-south_strip.x: 5.75: yard.x + north_strip.x]) {
    translate([i, yard.y, 0])
        cube([5.5, .5, 60]);
}

// *** South
for (i = [-100 : 5.75 : yard.y]) {
    translate([-south_strip.x, i, 0])
        cube([.5, 5.5, 60]);
}

// *** North
for (i = [-250 : 5.75 : yard.y]) {
    translate([yard.x + north_strip.x, i, 0])
        cube([.5, 5.5, 60]);
}




// ** Shed
module shed() {
    shed = [74, 98, 78];
    door = [28, 4.02, 69];
    window = [4.02, 30, 22];

    difference() {
        cube(shed);

        // inside
        translate([4,4,4])
            cube([shed.x - 8, shed.y - 8, shed.z - 8]);

        // door
        translate([2*12, -.01, 4])
            cube(door);

        // window
        translate([-0.01, 32, 30])
            cube(window);
    }

    hull() {
        translate([shed.x/2, 0, shed.z+20])
            rotate([-90, 0, 0])
            cylinder(r=1, h=shed.y);

        translate([-4, 0, shed.z-3])
            rotate([-90, 0, 0])
            cylinder(r=1, h=shed.y);

        translate([shed.x+4,0,shed.z-3])
            rotate([-90,0,0])
            cylinder(r=1,h=shed.y);
    }
}
color([.3,.3,.7])
translate([39*12+6, 18*12+4, 0])
shed();

// * Patio/structure
for(x = [4*12+0, 30*12+0], y = [0 : 4*12+4 : 12*12]) {
    translate([x, y, 0])
        cube([4, 4, 8*12]);

    color([.6, .6, .6, .2])
        translate([x+1, y+4, 0])
        cube([2, 4*12, 8*12]);
}

for(x = [4*12+0 : 4*12+4 : 27*12]) {
    translate([x, 13*12, 0])
        cube([4, 4, 8*12]);

    color([.6, .6, .6, .2])
        translate([x+4, 13*12+1, 0])
        cube([4*12, 2, 8*12]);
}

translate([30*12+0, 13*12, 0])
cube([4, 4, 8*12]);

fringe=6;
color("yellow")
translate([4*12 - fringe, 0, -0.9])
cube([26*12+4 + 2*fringe,13*12+4 + fringe,1]);


color("orange")
translate([house.x + 100+15, 30-36, 0])
//scale([1,1,.5])
sphere(15);

color("red")
translate([house.x + 100+45, 45, 0])
//scale([1,1,.5])
sphere(45);

color("green")
translate([house.x + family_room_wall.x, -bedroom_wall.y + 32 + 7.5, 0])
scale([1,1.5,.25])
sphere(15);

translate([-south_strip.x +37 + 15, yard.y - 150 - 15 - 53, 0])
cylinder(d=11, h=30);

translate([-south_strip.x +37 + 15, yard.y - 150 - 15, 0])
cylinder(r1=7, r2=15, h=100);

