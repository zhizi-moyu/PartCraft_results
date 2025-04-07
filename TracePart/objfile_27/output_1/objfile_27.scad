
// Define the components
module cylindrical_base() {
    translate([0, 0, 0])
    cylinder(h=5, r1=3.6, r2=3.6, center=true); // Adjusted radius for a refined curvature
}

module small_hollow_cylinder() {
    difference() {
        translate([0, 0, 0])
        cylinder(h=6, r1=2.7, r2=2.7, center=true); // Slightly increased radius
        translate([0, 0, 0])
        cylinder(h=6, r1=1.25, r2=1.25, center=true); // Enlarged inner hollow area
    }
}

module bolt_like_fastener() {
    difference() {
        union() {
            translate([0, 0, -1.5])
            cylinder(h=3, r1=0.75, r2=0.75, center=true); // Same cylindrical base
            translate([0, 0, 1.5])
            rotate([0,0,0]) // Removed rotation for uniform threading alignment
            cylinder(h=1, r1=1, r2=1, center=true); // Shortened hexagonal head size
        }
        translate([0, 0, 0])
        rotate([0, 0, 0])
        cylinder(h=2.5, r1=0.6, r2=0.6, center=true); // Simplified threading to match original design
    }
}

module connector_cylinder_with_bolt_holes() {
    difference() {
        cylinder(h=7, r1=2.45, r2=2.45, center=true); // Adjusted diameter to match original model
        translate([-1.5, 0, 0]) // Fixed misalignment of holes
        rotate([0, 90, 0])
        cylinder(h=7, r1=0.65, r2=0.65, center=true); // Reduced hole size
        translate([1.5, 0, 0]) // Symmetrical alignment of holes
        rotate([0, 90, 0])
        cylinder(h=7, r1=0.65, r2=0.65, center=true); // Reduced hole size
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

