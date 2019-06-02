// -*- mode: scad; orgstruct-heading-prefix-regexp: "// " -*-
include <hanger.scad>;

// * Variables
shelf_depth = 15.9;
top_shelf = 80;
epsilon = 0.0006 - 0.0001;
north_partition = 32;
east_partition = 16;
north_left_shelves = [28, 41, 54, 67];
north_right_shelves = [15 : 13 : 80];
east_shelves = [10 : 10 : 79];
pole_clearance = 1.75;

// * Colors and other non-variables
turquoise = [5/16,14/16,14/16];
blonde = [15.1/16, 13.25/16, 9.25/16];
mustard = [15.1/16, 13/16, 3/16];
sand = [182/256, 180/256, 162/265];
south_right_wall = 20 + 0;
south_left_wall = 23 + 0;
south_entrance = 26 + 0;
room = [69, 51, 92.5];
plywood = [96, 48, .75];


// * Walls
// ** East Wall
%translate([-plywood.z, 0, 0])
cube([plywood.z, room.y, room.z]);

// ** North Wall
%translate([0, room.y, 0])
cube([room.x, plywood.z, room.z]);

// ** West Wall
%translate([room.x, 0, 0])
cube([plywood.z, room.y, room.z]);

// ** Entrance
%translate([0, -plywood.z, 0])
cube([south_left_wall, plywood.z, room.z]);

%translate([south_left_wall + south_entrance, -plywood.z, 0])
cube([south_right_wall, plywood.z, room.z]);

// ** Floor
difference() {
    translate([0, 0, -plywood.z])
        cube([room.x, room.y, plywood.z]);

// *** Trapdoor
    translate([3, room.y - 27 - 3, -plywood.z - epsilon])
        cube([27, 27, plywood.z + (2 * epsilon)]);
}
// ** Ceiling
%translate([0, 0, room.z])
cube([room.x, room.y, plywood.z]);

// ** Light
color("white")
translate([room.x/2, 14, room.z - 5])
sphere(4, $fn=50);

// * Shelf module
module shelf(y, has_l=true, has_r=true) {
    echo(y);
    // Shelf
    translate([0, 0, -plywood.z])
    cube([shelf_depth, y, plywood.z]);

    // cleats
    cleat_height = 1;
    if (has_l)
    translate([plywood.z, 0, -cleat_height - plywood.z])
    cube([shelf_depth - plywood.z, plywood.z, cleat_height]);

    translate([0, 0, -cleat_height - plywood.z])
    cube([plywood.z, y, cleat_height]);

    if (has_r)
    translate([plywood.z, y - plywood.z, -cleat_height - plywood.z])
    cube([shelf_depth - plywood.z, plywood.z, cleat_height]);
}

// * Top wrap shelf
translate([0, 0, top_shelf])
shelf(room.y);

translate([shelf_depth, room.y, top_shelf])
rotate(-90)
shelf(room.x - shelf_depth * 2, false, false);

translate([room.x, room.y, top_shelf])
rotate(180)
shelf(room.y);

// * West Wall
// ** Poles
top_pole    = [10.25, room.y,                   top_shelf - plywood.z - pole_clearance];
bottom_pole = [10.25, room.y - shelf_depth + 2, north_left_shelves[1] - plywood.z - pole_clearance];

for (pole = [bottom_pole, top_pole]) {
    translate([pole.x, 0, pole.z])
        rotate([-90, 0, 0])
        cylinder(h=room.y, r=5/8, $fn=24);
    for(i = [1 : 1.5 : 31]) {
        translate([pole.x + 6.62, i, pole.z - 7.39])
            rotate([0, 90, -90])
            hanger();
    }
}

// * North Wall
// ** Partition
translate([north_partition, room.y - shelf_depth, 0])
cube([plywood.z, shelf_depth, top_shelf - plywood.z]);

// ** left shelves
for (g = north_left_shelves) {
    translate([0, room.y, g])
        rotate(-90)
        shelf(north_partition);
}
// ** right shelves
for (g = north_right_shelves) {
    translate([north_partition + plywood.z, room.y, g])
        rotate(-90)
        shelf(room.x - north_partition - plywood.z);

    translate([room.x, room.y - shelf_depth, g])
        rotate(180)
        shelf(room.y - shelf_depth - east_partition - plywood.z, false);
}

// * East Wall
// *** Partition
translate([room.x - shelf_depth, east_partition, 0])
cube([shelf_depth, plywood.z, top_shelf - plywood.z]);

for (g = east_shelves) {
    translate([room.x, east_partition, g])
        rotate(180)
        shelf(east_partition);
}

// * Litterbox
color([.4,.4,.4])
translate([10.5, room.y - 16, 0.5])
difference() {
    cube([21, 16, 11]);

    translate([.5, .5,.5])
        cube([20.1,15.1,11]);

    translate([7, -epsilon, 5])
        cube([7, 1, 7]);
}

/*
(/
 (/
(+
51
37.2
51
32
32
32
32
36.25
22.35
36.25
22.35
36.25
22.35
36.25
22.35
36.25
22.35
36.25
22.35
12
12
12
12
12
12
12
 80
 80
 )
  3)
  96)
*/
