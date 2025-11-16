#version 330 compatibility

#include "shadow_strength.glsl"

uniform sampler2D lightmap;
uniform sampler2D gtexture;

uniform float alphaTestRef = 0.1;

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {
	color = texture(gtexture, texcoord) * glcolor;
	color *= pow(texture(lightmap, lmcoord), vec4(shadowStrength));
	if (color.a < alphaTestRef) {
		discard;
	}
}
