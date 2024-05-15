shader_type canvas_item;

uniform vec4 bubble_color: source_color = vec4(1.0);
uniform float bubble_radius: hint_range(0.1, 1) = 0.1;
uniform float crack_intensity: hint_range(0.0, 2) = 0.0;
uniform sampler2D crack_texture: source_color;

void fragment() {
	// add cracks
	vec4 cracks = texture(crack_texture, UV);
	// draw a circle (implicit function of centered circle)
	if (pow(UV.x-0.5, 2)+ pow(UV.y-0.5, 2) < bubble_radius) {
		COLOR = bubble_color;
		COLOR += crack_intensity*cracks;
		COLOR.a = pow(UV.x-0.5, 2)+ pow(UV.y-0.5, 2); // opacity depends on distance w/ center
	} else {
		// no opacity outside the circle
		COLOR = vec4(0.0);
	}
	
	
}