// -*- mode: scad; orgstruct-heading-prefix-regexp: "// " -*-
// * Variables
table = [60, 30, 25];
stud = [2.5,1.5];
plywood_thickness = .75;
shelf = [11+stud.x, 12, [max(stud.y, stud.x), 12, 18]];
turquoise = [5/16,14/16,14/16];
blonde = [15.1/16, 13.25/16, 9.25/16];
mustard = [15.1/16, 13/16, 3/16];
module make_stud(length) { echo(length);cube([stud.x, stud.y, length]); }
module platform(x, y) { color(blonde) cube([x, y, plywood_thickness]); }

color(turquoise)
// * The 6 legs
for (x = [0, shelf.x, table.x - stud.x]) {
     for (y = [0, table.y - stud.y]) {
          translate([x,y,0])
               make_stud(table.z - plywood_thickness);
     }
}

color(turquoise)
// * Cross ties between the legs
for (z = concat(shelf.z, table.z - plywood_thickness)) {
     for (x = [0, shelf.x, table.x - stud.x]) {
          if (x != table.x - stud.x || z != shelf.z[0])
              translate([x, stud.y, z])
                  rotate([-90, 0, 0])
                  make_stud(table.y - stud.y * 2);
     }
}

//color(turquoise)
// * Cross ties spanning the legs
for (i = [0,1]) {
     x = [stud.x, shelf.x+stud.x][i];
     l = [shelf.x - stud.x, table.x - shelf.x - stud.x*2][i];

     for (y = [0, table.y - stud.x]) {
         translate([x,y, table.z - plywood_thickness - stud.y])
             rotate([90,0,90])
             make_stud(l);
     }

     // Back studs
     for (z = shelf.z) {
          if (i != 1 || z != shelf.z[0])
              translate([x,table.y - stud.y,z])
                  rotate([0,90,0])
                  make_stud(l);
     }
}

// * Tabletop
translate([0,0,table.z - plywood_thickness])
platform(table.x, table.y);

// * module shelf
module shelf(z) {
     translate([0,0,z]) {
          //shelf
          translate([0,stud.y,0])
               platform(shelf.x + stud.x, table.y - stud.y*2);
         if (z != shelf.z[0]) {
             //backshelf
                 translate([shelf.x + stud.x, table.y - shelf.y , 0])
                 platform(table.x - shelf.x - stud.x, shelf.y - stud.y);
             union(){
                 //front bit
                 translate([stud.x, 0,0])
                     platform(shelf.x-stud.x, stud.y);
                 //back shelf bit
                 translate([stud.x, table.y - stud.y, 0])
                     platform(shelf.x - stud.x, stud.y);
                 // skinny back shelf bit
                 translate([shelf.x + stud.x, table.y - stud.y, 0])
                     platform(table.x - shelf.x - stud.x * 2, stud.y);
             }
         }
     }
}

// * Shelves
for (z = shelf.z) { shelf(z); }

* union() {
     %platform(96,48);
     shelf(0);
     translate([table.x + shelf.x + stud.x + 1, table.y,0])
     rotate(180)
     shelf(0);
}
//!shelf(0);
