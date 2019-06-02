module hanger() {
    thickness = .125;
    curve = .75;
    ang = 15;
    l = 15;

// ** bottom bar
    translate([0, 0, 0])
        rotate([90, 0, 0])
        linear_extrude(height=l, $fn=50)
        circle(thickness);

// ** side curves
    translate([-curve, 0, 0])
        rotate_extrude(angle=180-ang, $fn=50)
        translate([curve, 0, 0])
        circle(thickness);

    translate([-curve, -l, 0])
        rotate_extrude(angle=ang-180, $fn=50)
        translate([curve, 0, 0])
        circle(thickness);

// ** top curve
//    translate([-3.134 * l/15, -l/2, 0]) //l=10               
    translate([-2.76 * l/15, -l/2, 0])  //l=15
//    translate([-2.572 * l/15, -l/2, 0])   //l=20
        rotate(180 - ang)
        rotate_extrude(angle=ang*2, $fn=50)
        translate([curve, 0, 0])
        circle(thickness);

// ** slanted bars
    sbl=7.765 * (l/15); //~ (* 7.5 (cos (/ (* 15 3.14156) 180)))

    sbo=2;
    translate([-curve, 0, 0])
        rotate([-90, 0, 180 - ang])
        translate([curve, 0, 0])
        linear_extrude(height=sbl, $fn=50)
        circle(thickness);

    translate([-curve, -l, 0])
        rotate([90, 0, ang - 180])
        translate([curve, 0, 0])
        linear_extrude(height=sbl, $fn=50)
        circle(thickness);

// ** neck
    translate([-3.35,-6.9,0])
        rotate([90,0,-105])
        linear_extrude(height = 4, $fn=50)
        circle(thickness);

// ** hook
    translate([-7.4,-6.59,0])
        rotate(75)
        rotate_extrude(angle=205, $fn=50)
        translate([curve, 0, 0])
        circle(thickness);
}

