// Define the components
module cylindrical_base() {
    translate([0, 0, -0.5])
    cylinder(h=6, r1=3.8, r2=3.8, center=true); // Increased length and adjusted proportions
    translate([0, 0, 3])
    rotate([0, 90, 0]) // Align perforations
    cylinder(h=4, r1=0.7, r2=0.7, center=true); // Perforations at both ends
}

module small_hollow_cylinder() {
    difference() {
        translate([0, 0, -0.5])
        cylinder(h=7, r1=3, r2=3, center=true); // Increased outer diameter
        translate([0, 0, -0.5])
        cylinder(h=7, r1=1.5, r2=1.5, center=true); // Enlarged inner hollow area
    }
}

module bolt_like_fastener() {
    difference() {
        union() {
            translate([0, 0, -2])
            cylinder(h=4, r1=0.75, r2=0.75, center=true); // Elongated cylindrical base
            translate([0, 0, 2])
            rotate([0,0,0])
            cylinder(h=1.2, r1=1, r2=1, center=true); // Adjusted hexagonal head size
        }
        translate([0, 0, 0])
        rotate([0, 0, 0])
        cylinder(h=3, r1=0.5, r2=0.5, center=true); // Refined threading for better fitment
    }
}

module connector_cylinder_with_bolt_holes() {
    difference() {
        cylinder(h=8, r1=2.35, r2=2.35, center=true); // Adjusted thickness for uniformity
        translate([-1.7, 0, 0]) // Proper alignment of holes
        rotate([0, 90, 0])
        cylinder(h=8, r1=0.75, r2=0.75, center=true); // Defined hole size
        translate([1.7, 0, 0]) // Symmetrical alignment of holes
        rotate([0, 90, 0])
        cylinder(h=8, r1=0.75, r2=0.75, center=true); // Defined hole size
    }
}

// Build the model assembly
module flexible_coupling() {
    translate([0, 0, 16]) cylindrical_base();
    translate([0, 0, 10]) small_hollow_cylinder();
    translate([0, 0, 2]) connector_cylinder_with_bolt_holes(); // Adjusted positioning
    translate([2, 0, 2]) bolt_like_fastener();
    translate([-2, 0, 2]) bolt_like_fastener();
    translate([0, 0, -5]) small_hollow_cylinder();
    translate([0, 0, -10]) cylindrical_base(); // Adjusted positioning
}

// Render the assembly
flexible_coupling();
