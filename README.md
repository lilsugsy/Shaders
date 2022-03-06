# Shaders
Three.js Shaders

## How to use shaders (lava example)

### 1 - Import
Place the shaders in a folder of your chouse.
Then import both the fragment and vertex shaders at the top of your script

```js
import fragment from './Shaders/lavaFragmentShader.glsl'
import vertex from './Shaders/lavaVertexShader.glsl'

this.fragmentShader = fragment
this.vertexShader = vertex
```

### 2 - Set uniforms

Set the uniforms (these are the variables that get set/passed into the shaders)

```js
this.uniforms = {
  'fogDensity': { value: 0.01 },
  'fogColor': { value: new THREE.Vector3( 0, 0, 0 ) },
  'time': { value: 1.0 },
  'uvScale': { value: new THREE.Vector2(3.0, 1.0 ) },
  'texture1': { value: this.loader.load( 'assets/cloud.png' ) },
  'texture2': { value: this.loader.load( 'assets/lavatile.jpg' ) }
};
```

### 3 - Add material to mesh
Create a shader material, settings the uniforms, vertex and fragment shaders

```js
const material = new THREE.ShaderMaterial( {
  uniforms:  this.uniforms,
  vertexShader: this.vertexShader,
  fragmentShader: this.fragmentShader,
} );
        
const cube = new THREE.Mesh( new THREE.TorusGeometry( 1, 0.3, 30, 30 ), material );
this.scene.add(cube) 
```        

### 4 - Update uniform each frame using Deltatime
```js
this.time = this.experience.time
...
update()
{
this.uniforms[ 'time' ].value += 0.2 * this.time.delta*0.01;
}
``` 
