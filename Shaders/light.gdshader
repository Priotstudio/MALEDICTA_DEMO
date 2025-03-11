shader_type canvas_item;

// Light properties
uniform vec3 light_direction = vec3(-0.5, -0.5, -0.5); // Light direction
uniform vec4 light_color = vec4(1.0, 1.0, 1.0, 1.0); // Light color
uniform float light_intensity : hint_range(0.0, 2.0) = 1.0; // Light intensity
uniform float shadow_strength : hint_range(0.0, 1.0) = 0.5; // Shadow strength

// Material properties
uniform float ambient_strength : hint_range(0.0, 1.0) = 0.2; // Ambient strength
uniform vec4 ambient_color = vec4(0.2, 0.2, 0.2, 1.0); // Ambient color

void fragment() {
    // Default normal for flat surface
    vec3 normal = vec3(0.0, 0.0, 1.0);
    // Uncomment and adjust if using a normal map:
    // normal = texture(NORMAL_TEXTURE, UV).rgb * 2.0 - 1.0;

    // Normalize light direction
    vec3 light_dir = normalize(-light_direction);
    
    // Diffuse lighting
    float diffuse = max(0.0, dot(normal, light_dir));
    vec3 diffuse_light = light_color.rgb * diffuse * light_intensity;

    // Ambient lighting
    vec3 ambient = ambient_color.rgb * ambient_strength;

    // Simple shadow simulation
    float shadow_factor = smoothstep(0.0, 0.2, diffuse);
    shadow_factor = mix(shadow_strength, 1.0, shadow_factor);

    // Combine lighting
    vec3 final_light = (diffuse_light * shadow_factor) + ambient;
    
    // Apply to texture
    vec4 color = texture(TEXTURE, UV);
    COLOR = vec4(color.rgb * final_light, color.a);
}