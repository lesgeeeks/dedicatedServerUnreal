// © 2024 Kimmo Kotajärvi <kimmo.kotajarvi@gmail.com>
// This sample is licensed under MIT

using UnrealBuildTool;
using System.Collections.Generic;

[SupportedPlatforms(UnrealPlatformClass.Server)]
public class DediServerSampleServerTarget : TargetRules
{
	public DediServerSampleServerTarget(TargetInfo Target) : base(Target)
	{
		Type = TargetType.Server;
		DefaultBuildSettings = BuildSettingsVersion.V4;
		IncludeOrderVersion = EngineIncludeOrderVersion.Unreal5_3;
		DediServerSampleTarget.ApplySharedTargetSettings(this);
		ExtraModuleNames.Add("DediServerSample");
		DisablePlugins.Add("OpenImageDenoise");
	}
}
