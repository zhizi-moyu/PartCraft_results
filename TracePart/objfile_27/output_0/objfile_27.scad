
// Define the components
module cylindrical_base() {
    translate([0, 0, 0])
    cylinder(h=5, r1=3.5, r2=3.5, center=true);
}

module small_hollow_cylinder() {
    difference() {
        translate([0, 0, 0])
        cylinder(h=5, r1=2.5, r2=2.5, center=true);
        translate([0, 0, 0])
        cylinder(h=6, r1=1, r2=1, center=true);
    }
}

module bolt_like_fastener() {
    union() {
        translate([0, 0, -1.5])
        cylinder(h=3, r1=0.75, r2=0.75, center=true);
        translate([0, 0, 1.5])
        rotate([0,0,30])
        cylinder(h=1.5, r1=1, r2=1, center=true);
    }
}

module connector_cylinder_with_bolt_holes() {
    difference() {
        cylinder(h=7, r1=2.5, r2=2.5, center=true);
        translate([0, 0, 0])
        rotate([0, 90, 0])
        cylinder(h=7, r1=0.75, r2=0.75, center=true);
    }
}

// Build the model assembly
module flexible_coupling() {
    translate([0, 0, 15]) cylindrical_base();
    translate([0, 0, 10]) small_hollow_cylinder();
    translate([0, 0, 3]) connector_cylinder_with_bolt_holes();
    translate([2, 0, 3]) bolt_like_fastener();
    translate([-2, 0, 3]) bolt_like_fastener();
    translate([0, 0, -4]) small_hollow_cylinder();
    translate([0, 0, -9]) cylindrical_base();
}

// Render the assembly
flexible_coupling();

