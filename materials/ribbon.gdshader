shader_type canvas_item;

uniform float wave_amplitude : hint_range(0, 20); // Controls the height of the wave
uniform float wave_frequency : hint_range(0, 10); // Controls the number of waves
uniform float wave_speed : hint_range(0, 10); // Controls how fast the wave animates
uniform float pixel_width : hint_range(0.01, 5);  // Width of each "pixel"
uniform float pixel_height : hint_range(0.01, 5); // Height of each "pixel"

void vertex() {
    // Use the sine wave formula to deform the vertex along the Y-axis
    VERTEX.y += sin(VERTEX.x * wave_frequency + TIME * wave_speed) * wave_amplitude;
}

void fragment() {
	vec2 pixel_size = vec2(pixel_width, pixel_height);
    // Calculate the "pixelated" UV coordinates
    vec2 pixelated_uv = floor(UV / pixel_size) * pixel_size;

    // Sample the texture at the pixelated coordinates
    COLOR = texture(TEXTURE, pixelated_uv) * COLOR;
}