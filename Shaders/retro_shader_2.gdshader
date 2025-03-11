shader_type canvas_item;

// Uniforms
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap; // Screen texture
uniform float vignette_strength : hint_range(0.0, 1.0) = 0.3; // Strength of the vignette effect
uniform float vignette_softness : hint_range(0.0, 1.0) = 0.5; // Softness of the vignette
uniform float brightness : hint_range(0.5, 1.5) = 1.0; // Adjust brightness
uniform float contrast : hint_range(0.5, 1.5) = 1.1; // Adjust contrast
uniform vec3 color_tint = vec3(1.0, 0.95, 0.9); // Subtle warm tint
uniform float film_grain_strength : hint_range(0.0, 0.1) = 0.02; // Strength of film grain
uniform float scanline_strength : hint_range(0.0, 0.1) = 0.02; // Strength of scanlines
uniform vec3 color_grading = vec3(1.1, 1.0, 0.9); // Color grading (warm tone)

void fragment() {
    // Sample the screen texture
    vec3 color = texture(screen_texture, UV).rgb;

    // Apply brightness and contrast
    color = (color - 0.5) * contrast + 0.5;
    color *= brightness;

    // Apply color grading
    color *= color_grading;

    // Apply a subtle color tint
    color *= color_tint;

    // Add a soft vignette effect
    vec2 uv_center = UV - 0.5;
    float vignette = smoothstep(0.0, vignette_softness, 1.0 - length(uv_center) * vignette_strength);
    color *= vignette;

    // Add subtle film grain for a retro feel
    float film_grain = fract(sin(dot(FRAGCOORD.xy, vec2(12.9898, 78.233))) * 43758.5453) * film_grain_strength;
    color += film_grain;

    // Add subtle scanlines for a retro feel
    float scanline = mod(FRAGCOORD.y, 2.0) < 1.0 ? 1.0 - scanline_strength : 1.0;
    color *= scanline;

    // Output the final color
    COLOR = vec4(color, 1.0);
}