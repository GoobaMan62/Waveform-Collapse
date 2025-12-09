shader_type spatial;

// Uniforms to receive data from GDScript
uniform sampler2D color_map_texture;
uniform float map_size = 700.0;
uniform float world_size = 140.0;

varying vec3 world_position;

void vertex() {
    world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
    // 1. Determine the object-space position relative to the center
    // Assuming the object's origin is at its center (e.g., a standard Godot PlaneMesh)
    // The range is from -world_size/2 to +world_size/2
    vec2 obj_pos = world_position.xz;
    
	float ws = world_size * 1.03;
    // 2. Normalize the position to a 0.0 to 1.0 range
    // We add half the size to shift the range from [-70, 70] to [0, 140]
    vec2 normalized_pos = (obj_pos + vec2(ws / 2.0)) / ws;

    // 3. Get the pixel index in the 14x14 grid
    // Multiply by map size (14), cast to int to get cell index, then normalize back to UV
    vec2 uv_index = floor(normalized_pos * map_size - vec2(world_size, world_size)) + 0.25 * vec2(world_size, world_size);
    vec2 uv_coords = (uv_index + vec2(0.5, 0.5)) / map_size; // Sample center of pixel
    
    // 4. Sample the color from the texture
    vec4 color_from_map = texture(color_map_texture, uv_coords);

    // Apply the color to the mesh, making sure to use a color hint if needed
    ALBEDO = color_from_map.rgb;
}