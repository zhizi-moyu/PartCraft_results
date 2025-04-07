
// Parameters for components
cylinder_diameter = 20;
cylinder_length = 50;
hole_diameter = 3;
threaded_hole_diameter = 5;
groove_depth = 1.5;
groove_width = 2;
bolt_diameter = 3;
bolt_length = 55;
nut_diameter = 6;
nut_height = 3;

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
                    (cylinder_diameter / 2 - 4) * cos(theta),
                    (cylinder_diameter / 2 - 4) * sin(theta),
                    i * (cylinder_length / 2 - 10)
                ])
                rotate([0, 0, theta])
                    cylinder(r=threaded_hole_diameter / 2, h=cylinder_length, center=true);
            }
        }

        // Functional grooves
        for (offset = [-1, 0, 1]) {
            translate([0, 0, offset * 15])
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
            cylinder(r=bolt_diameter * 1.5 / 2, h=bolt_diameter, center=false);
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
            (cylinder_diameter / 2 - 4) * cos(theta),
            (cylinder_diameter / 2 - 4) * sin(theta),
            -bolt_length / 2
        ])
        rotate([0, theta, 0])
            bolt();

        // Nuts
        translate([
            (cylinder_diameter / 2 - 4) * cos(theta),
            (cylinder_diameter / 2 - 4) * sin(theta),
            cylinder_length / 2
        ])
        rotate([0, theta, 0])
            nut();
    }
}

// Render the full assembly
assembly();

