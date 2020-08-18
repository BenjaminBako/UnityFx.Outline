﻿// Copyright (C) 2019-2020 Alexander Bogarsukov. All rights reserved.
// See the LICENSE.md file in the project root for more information.

// Renders everything with while color.
// Modified version of 'Custom/DrawSimple' shader taken from https://willweissman.wordpress.com/tutorials/shaders/unity-shaderlab-object-outlines/.
Shader "Hidden/UnityFx/OutlineColor"
{
	HLSLINCLUDE

		#include "UnityCG.cginc"

		UNITY_DECLARE_TEX2D(_MainTex);

		half4 frag() : SV_Target
		{
			return 1;
		}

		half4 frag_clip(appdata_img i) : SV_Target
		{
			half4 c = UNITY_SAMPLE_TEX2D(_MainTex, i.texcoord);
			clip(c.a - 1);
			return 1;
		}

	ENDHLSL

	SubShader
	{
		Cull Off
		ZWrite Off
		ZTest LEqual
		Lighting Off

		Pass
		{
			Name "Opaque"

			HLSLPROGRAM

			#pragma vertex vert_img
			#pragma fragment frag

			ENDHLSL
		}

		Pass
		{
			Name "Transparent"

			HLSLPROGRAM

			#pragma vertex vert_img
			#pragma fragment frag_clip

			ENDHLSL
		}
	}
}
