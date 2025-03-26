shader_type canvas_item;

uniform float wave_amplitude : hint_range(0, 20); // Controls the height of the wave
uniform float wave_frequency : hint_range(0, 10); // Controls the number of waves
uniform float wave_speed : hint_range(0, 10); // Controls how fast the wave animates

void vertex() {
    // Use the sine wave formula to deform the vertex along the Y-axis
    VERTEX.y += sin(VERTEX.x * wave_frequency + TIME * wave_speed) * wave_amplitude;
}