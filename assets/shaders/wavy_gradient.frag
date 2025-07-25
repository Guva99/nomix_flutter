// uniforms: сначала четырёхкомпонентный вектор, потом скаляр
uniform float4 u_resolution;  // x=width, y=height, z,w — не используются
uniform float  u_time;        // текущее время в секундах

half4 main(float2 fragCoord) {
    // нормализуем координаты в [0..1]
    float2 uv = fragCoord / u_resolution.xy;

    // «волнистое» смещение по Y
    float wave = sin((uv.x + u_time * 0.5) * 10.0) * 0.02;
    uv.y += wave;

    // три цвета вашего градиента
    const half4 c0 = half4(0.2588, 0.6471, 0.9608, 1.0); // #42A5F5
    const half4 c1 = half4(0.2784, 0.5530, 0.8784, 1.0); // #478DE0
    const half4 c2 = half4(0.3608, 0.4196, 0.7529, 1.0); // #5C6BC0

    // сам градиент: c0→c1→c2 по uv.y
    half4 color = (uv.y < 0.5)
    ? mix(c0, c1, uv.y * 2.0)
    : mix(c1, c2, (uv.y - 0.5) * 2.0);

    return color;
}
