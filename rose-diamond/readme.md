# How to use

## Import the shaders

First import the shaders into the top of your javascript file, e.g world.js

```js
import fragmentNoise from './Shaders/noiseFragmentShader.glsl'
import vertexNoise from './Shaders/noiseVertexShader.glsl'

import fragmentFresnel from './Shaders/fresnelFragmentShader.glsl'
import vertexFresnel from './Shaders/fresnelVertexShader.glsl'
```

## Set up the uniforms

These are the properties that will be passed into the shaders. These are to be set in the same javascript file as above, e.g word.js

```js
this.uniforms2 = {
  'time': { value: 0 },
  'tCube': { value: 0 },
  'resolution': { value: new THREE.Vector4() }
}
```

## Set up the materials + geometry

Create an inner sphere (forground) and an outer sphere (background).

```js
this.setOuterSphere() // background
this.setInnerSphere() // foreground
this.setCubeTexture() // texture for fresnal shader reflections/refractions

setOuterSphere()
    {
        const material = new THREE.ShaderMaterial( {
            //wireframe: true,
            side: THREE.DoubleSide,
            uniforms: this.uniforms,
            vertexShader: this.vertexNoise,
            fragmentShader: this.fragmentNoise,

        } );
        const geometry = new THREE.SphereBufferGeometry(5, 32, 32 );
        this.sphere = new THREE.Mesh( geometry, material );
        this.scene.add(this.sphere)        
    }

    setInnerSphere()
    {

        this.mat = new THREE.ShaderMaterial( {
            //wireframe: true,
            side: THREE.DoubleSide,
            uniforms: this.uniforms2,
            vertexShader: this.vertexFresnel,
            fragmentShader: this.fragmentFresnel
        } );
        const geometry2 = new THREE.OctahedronGeometry(0.8, 0)
        this.sphere2 = new THREE.Mesh( geometry2, this.mat );
        this.sphere2.rotation.y = -Math.PI*0.08;
        this.sphere2.rotation.z = -Math.PI*1.2;
        this.scene.add(this.sphere2)        
    }
    
    setCubeTexture()
    {
        this.cubeRenderTarget = new THREE.WebGLCubeRenderTarget(256, {
            format: THREE.RGBAFormat,
            generateMipmaps: true,
            minFilter: THREE.LinearMipmapLinearFilter,
            encoding: THREE.sRGBEncoding
        })

        this.cubeCamera = new THREE.CubeCamera(0.1,10, this.cubeRenderTarget);
    }
    
```

## update each frame

We need to update the time + tCube(reflection/refraction environment map) each frame.

```js
update()
    {
        if(this.sphere && this.sphere2) {
            this.uniforms[ 'time' ].value += 0.2 * this.time.delta*0.002;
            this.mat.uniforms[ 'tCube' ].value = this.cubeRenderTarget.texture;
            
        }

        if(this.cubeCamera) {
            this.cubeCamera.update(this.renderer, this.scene); 
        }      
    }
```    

