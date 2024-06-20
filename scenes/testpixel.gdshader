shader_type spatial;



uniform float pixel_size : hint_range(1, 100) = 5.0; // Adjust pixel size

void fragment() {
    // Calculate pixelated UV coordinates
    vec2 uv = FRAGCOORD.xy /SCREEN_PIXEL_SIZE;
    vec2 pixel_uv = floor(uv * pixel_size) / pixel_size;

    // Sample color from texture
    vec4 color = texture(TEXTURE, UV);

    // Output the pixelated color
    ALBEDO = color.rgb;
    ALPHA = color.a;
}