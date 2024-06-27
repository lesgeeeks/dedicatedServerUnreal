@echo "Building Development"
@set PROJECT=%~dp0../../DediServerSample.uproject
@set ENGINEPATH=D:/git/UnrealEngine-Angelscript
@set OUTPUT=%~dp0../Steam/content
"%ENGINEPATH%/Engine/Build/BatchFiles/RunUAT" BuildCookRun^
 -project="%PROJECT%"^
 -targetplatform=Win64^
 -noserver^
 -clientconfig=Development^
 -serverconfig=Development^
 -build^
 -cook^
 -pak^
 -stage^
 -nop4^
 -utf8output^
 -stagingdirectory="%OUTPUT%"
@pause