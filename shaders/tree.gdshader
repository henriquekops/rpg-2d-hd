shader_type canvas_item;

uniform float amplitude = 3.0f;
uniform float speed = 2.0f;

void vertex(){
	VERTEX.x += amplitude * sin( (1.0f - UV.y) * speed * TIME );
}