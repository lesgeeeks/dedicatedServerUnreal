// © 2024 Kimmo Kotajärvi <kimmo.kotajarvi@gmail.com>
// This sample is licensed under MIT

using UnrealBuildTool;
using System.Collections.Generic;

public class DediServerSampleEditorTarget : TargetRules
{
	public DediServerSampleEditorTarget(TargetInfo Target) : base(Target)
	{
		Type = TargetType.Editor;
		DefaultBuildSettings = BuildSettingsVersion.V4;
		IncludeOrderVersion = EngineIncludeOrderVersion.Unreal5_3;
		ExtraModuleNames.Add("DediServerSample");
	}
}
