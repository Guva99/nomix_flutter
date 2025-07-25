// Первый uniform: u_resolution.x, u_resolution.y
uniform float2 u_resolution;
// Второй: время (в секундах)
uniform float  u_time;
// texture/sampler не нужен, но оставим на всякий случай
uniform sampler2D u_texture;

half4 main(float2 fragCoord) {
    // нормализуем [0..1]
    float2 uv = float2(
    fragCoord.x / u_resolution.x,
    fragCoord.y / u_resolution.y
    );

    // синусоидальное смещение по Y
    float wave = sin((uv.x + u_time * 0.5) * 10.0) * 0.02;
    uv.y += wave;

    // твои три цвета, переведённые в [0..1]
    const half4 c0 = half4(0.2588, 0.6471, 0.9608, 1.0); // #42A5F5
    const half4 c1 = half4(0.2784, 0.5530, 0.8784, 1.0); // #478DE0
    const half4 c2 = half4(0.3608, 0.4196, 0.7529, 1.0); // #5C6BC0

    // линейный градиент между c0→c1→c2 по Y
    half4 color = (uv.y < 0.5)
    ? mix(c0, c1, uv.y * 2.0)
    : mix(c1, c2, (uv.y - 0.5) * 2.0);

    return color;
}
