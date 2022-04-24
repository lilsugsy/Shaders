uniform float time;
varying vec2 vUv;
varying vec2 uvScale;
varying vec3 vPosition;
uniform vec2 pixels;

void main()
{

    vUv = uvScale * uv;

    vPosition = position;

    vec4 mvPosition = modelViewMatrix * vec4( position,1.0 );
    gl_Position = projectionMatrix * mvPosition;

}