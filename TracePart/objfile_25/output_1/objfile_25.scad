
// Define parameters
cylinder_diameter = 20; // Diameter of the cylindrical body remains unchanged
cylinder_length = 60; // Length of the cylindrical body remains unchanged
bolt_diameter = 3; // Diameter of the bolt remains unchanged
bolt_length = 15; // Length of the bolt remains unchanged
nut_diameter = 5; // Diameter of the nut remains unchanged
nut_height = 3; // Height of the nut remains unchanged
recess_depth = 0.5; // Adjusted depth of the recessed areas to make them shallower

// Function to create a bolt
module bolt() {
    cylinder(d = bolt_diameter, h = bolt_length);
}

// Function to create a nut
module nut() {
    translate([0, 0, bolt_length])
    rotate([0, 0, 30])
    cylinder(d = nut_diameter, h = nut_height, $fn = 6); // making it hexagonal
}

// Function to create the cylindrical body with recessed areas
module cylindrical_body() {
    // Create cylinder with shallower grooves
    difference() {
        cylinder(d = cylinder_diameter, h = cylinder_length);
        for (i = [0:cylinder_length/5:cylinder_length]) {
            translate([0, 0, i])
            cylinder(d = cylinder_diameter + recess_depth, h = recess_depth);
        }
    }
}

// Main assembly
cylindrical_body();
for (j = [10, 20, 40, 50]) { // positions for bolts around the cylinder at recessed areas
    translate([cylinder_diameter/2, 0, j])
    bolt();
    nut();
}

