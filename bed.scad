// -*- mode: scad; orgstruct-heading-prefix-regexp: "// " -*-
// * Variables
bed = [75, 38, 13]; // outer dimensions
plywood_thickness = .75;
//number_of_cubeies = 4; // interior width = (/ (- 75 (* 5 .75)) 4)17.8125
//number_of_cubeies = 5; // interior width = (/ (- 75 (* 6 .75)) 5)14.1
number_of_cubeies = 6; // interior width = (/ (- 75 (* 7 .75)) 6)11.625
//number_of_cubeies = 7; // interior width = (/ (- 75 (* 8 .75)) 7)9.857142857142858
//cubie_depth = bed.y * (34.0/89.0);
//cubie_depth = bed.y / 2; //19
cubie_depth = 12.375;

//(/ (- 38 12.375 .75 .75 .75) 2)

//cubie_depth = 15;
// * Colors
turquoise = [5/16,14/16,14/16];
blonde = [15.1/16, 13.25/16, 9.25/16];
mustard = [15.1/16, 13/16, 3/16];
sand = [182/256, 180/256, 162/265];

// * Bottom platform
color(turquoise)
cube([bed.x, bed.y, plywood_thickness]);

// * Top platform
*color(blonde)
translate([0,0,bed.z - plywood_thickness])
cube([bed.x, bed.y, plywood_thickness]);

// * Walls
// ** Interior Walls
for (i = [0:number_of_cubeies ]) {
    translate([((bed.x - plywood_thickness) / number_of_cubeies) * i , 0, plywood_thickness])
        cube([plywood_thickness, cubie_depth, bed.z - (2 * plywood_thickness)]);
    // * bins
    if (i < number_of_cubeies)
    color([1,1,1])
        translate([((bed.x - plywood_thickness) / number_of_cubeies) * i + 1.25, 0, plywood_thickness])
        cube([10.5, 10.5, 11]);
}

// ** Cubie back wall
color([.7, .7, 1])
translate([0, cubie_depth, plywood_thickness])
cube([bed.x, plywood_thickness, bed.z - (2 * plywood_thickness)]);

// * Footer cubie
// ** outside
color([.7, .7, 1])
translate([bed.x - cubie_depth, bed.y - plywood_thickness, plywood_thickness])
cube([cubie_depth, plywood_thickness, bed.z - (2 * plywood_thickness)]);
// ** back
translate([bed.x - cubie_depth - plywood_thickness, cubie_depth + plywood_thickness, plywood_thickness])
cube([plywood_thickness, bed.y - cubie_depth - plywood_thickness, bed.z - (2 * plywood_thickness)]);

// * Head cubie
// ** outside
color([.7, .7, 1])
translate([0, bed.y - plywood_thickness, plywood_thickness])
cube([cubie_depth,plywood_thickness, bed.z - (2 * plywood_thickness)]);
// ** back
translate([cubie_depth, cubie_depth + plywood_thickness, plywood_thickness])
cube([plywood_thickness,bed.y - cubie_depth - plywood_thickness, bed.z - (2 * plywood_thickness)]);

// * dividers
color([.7, .7, 1])
translate([0, (bed.y + cubie_depth ) / 2, plywood_thickness])
cube([cubie_depth,plywood_thickness, bed.z - (2 * plywood_thickness)]);

color([.7, .7, 1])
translate([bed.x - cubie_depth, (bed.y + cubie_depth ) / 2, plywood_thickness])
cube([cubie_depth,plywood_thickness, bed.z - (2 * plywood_thickness)]);

// * end boxes
color([1,1,1])
translate([0, 14, plywood_thickness])
cube([10.5, 10.5, 11]);

color([1,1,1])
translate([0, 26.5, plywood_thickness])
cube([10.5, 10.5, 11]);

// Bill of Materials
translate([0, 50, 0])
{
    %cube([96, 48, .75]);
    color(turquoise)
        cube([bed.x, bed.y, plywood_thickness]);
    translate([bed.x + 1,0,0])
        cube([11.5, bed.y, plywood_thickness]);
}

translate([0, 100, 0])
{
    %cube([96, 48, .75]);
    color(turquoise)
        cube([bed.x, bed.y, plywood_thickness]);
    translate([bed.x + 1,0,0])
        cube([11.5, bed.y, plywood_thickness]);
}

translate([0, 150, 0])
{
    %cube([96, 48, .75]);
    color([.7, .7, 1])
        cube([bed.x, bed.z - (2 * plywood_thickness), plywood_thickness]);
    translate([bed.x + 1,0,0])
        cube([12.375, 11.5, plywood_thickness]);
    for (i = [0:6]) {
        translate([i * 13, 11.5 + .5 ,0])
            cube([12.375, 11.5, plywood_thickness]);
    } // short 1 wall (12 3/8 x 11 1/2)
}

//; plywood
//75 x 38  * 2 // top/bottom
//12 3/8 x 11.5 * 11 // walls
//75 x 11.5 // back wall
//24 7/8 x 11.5 * 2 // back wall of ends

//(+ (* 2  (* 75 38))
//   (* 11 (* 12.375 11.5))
//   (* 75 11.5)
//   (* 2  (* 24.875 11.5)))8700.0625
//   (* 96 48) 4608
   
//; trim
//(+ (* 2  (+ 75 38 38 .5))
//   (* 15 11.5)); => 475.5 inches
//   (/ 475.5 12); => 39.625 feet
