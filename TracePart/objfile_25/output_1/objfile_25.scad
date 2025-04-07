// Parameters for components
cylinder_diameter = 20;
cylinder_length = 60;  // Adjusted to match the original length
hole_diameter = 3.5;   // Adjusted for a more accurate cavity
threaded_hole_diameter = 5;
groove_depth = 2;  // Increased depth for the grooves
groove_width = 2.5; // Adjusted width for the grooves
bolt_diameter = 4;  // Increased diameter to match the original bolts
bolt_length = 60;   // Increased bolt length
nut_diameter = 6; 
nut_height = 4;     // Increased height for robust nuts

// Coupling Cylinder Function
module coupling_cylinder() {
    // Main body
    difference() {
        cylinder(r=cylinder_diameter / 2, h=cylinder_length, center=true);
        
        // Central hollow cavity
        translate([0, 0, -cylinder_length / 2])
            cylinder(r=hole_diameter / 2, h=cylinder_length * 1.5, center=false);

        // Threaded holes near each end
        for (i=[-1, 1]) {
            for (theta = [0, 90, 180, 270]) {
                translate([
                    (cylinder_diameter / 2 - 5) * cos(theta),  // Adjusted position radius
                    (cylinder_diameter / 2 - 5) * sin(theta),
                    i * (cylinder_length / 2 - 10)
                ])
                rotate([0, 0, theta])
                    cylinder(r=threaded_hole_diameter / 2, h=cylinder_length, center=true);
            }
        }

        // Functional grooves
        for (offset = [-2, -1, 0, 1, 2]) {  // Added extra grooves to match the original design
            translate([0, 0, offset * 12])
                rotate([90, 0, 0])
                    translate([-cylinder_diameter / 2, -groove_width, -groove_depth])
                        cube([cylinder_diameter, groove_width * 2, groove_depth], center=false);
        }
    }
}

// Bolt Function
module bolt() {
    union() {
        // Bolt shaft
        cylinder(r=bolt_diameter / 2, h=bolt_length, center=false);
        
        // Bolt head
        translate([0, 0, bolt_length])
            cylinder(r=bolt_diameter * 1.5 / 2, h=bolt_diameter * 1.5, center=false);  // Adjusted head for proper elevation
    }
}

// Nut Function
module nut() {
    difference() {
        // Outer hexagonal shape
        rotate([0, 0, 30])
            linear_extrude(height=nut_height)
                polygon(points=[
                    [nut_diameter / 2, 0],
                    [nut_diameter / 4, nut_diameter * sqrt(3) / 4],
                    [-nut_diameter / 4, nut_diameter * sqrt(3) / 4],
                    [-nut_diameter / 2, 0],
                    [-nut_diameter / 4, -nut_diameter * sqrt(3) / 4],
                    [nut_diameter / 4, -nut_diameter * sqrt(3) / 4]
                ]);

        // Inner circular hole
        translate([0, 0, -1])
            cylinder(r=bolt_diameter / 2, h=nut_height + 2, center=false);
    }
}

// Assembly
module assembly() {
    // Layer 1: Coupling cylinder
    coupling_cylinder();

    // Layer 2: Bolts and nuts
    for (theta = [0, 90, 180, 270]) {
        // Bolts
        translate([
            (cylinder_diameter / 2 - 5) * cos(theta),  // Adjusted bolt positioning
            (cylinder_diameter / 2 - 5) * sin(theta),
            -bolt_length / 2
        ])
        rotate([0, theta, 0])
            bolt();

        // Nuts
        translate([
            (cylinder_diameter / 2 - 5) * cos(theta),  // Adjusted nut positioning
            (cylinder_diameter / 2 - 5) * sin(theta),
            cylinder_length / 2
        ])
        rotate([0, theta, 0])
            nut();
    }
}

// Render the full assembly
assembly();
