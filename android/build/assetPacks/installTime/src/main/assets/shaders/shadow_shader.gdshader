shader_type canvas_item;

uniform float cut_value : hint_range(-0.5, 1.5); // Значение от 0 до 1 для управления обрезкой
uniform vec3 col;

void fragment() {

    // Определяем градиентный переход
    float alpha = smoothstep(cut_value - 0.5, cut_value + 0.5, UV.y);

    // Меняем только альфа-канал, оставляя цвет прежним
    COLOR = vec4(col, alpha);
}
