#version 330 compatibility

#include "shadow_strength.glsl"
#define noWaterTransparency
#define waterBlueness 2.0 // [1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.8 1.9 20.0]

uniform sampler2D lightmap;
uniform sampler2D gtexture;

uniform float alphaTestRef = 0.1;

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;
in float blockType;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {
	bool isWater = blockType > 0.0;

	color = texture(gtexture, texcoord) * glcolor;
	color *= pow(texture(lightmap, lmcoord), vec4(shadowStrength));

	if (isWater) { color.b *= waterBlueness; }

	#ifdef noWaterTransparency
		if (isWater) { color.a = 1.0; }
	#endif

	if (color.a < alphaTestRef) {
		discard;
	}

}

