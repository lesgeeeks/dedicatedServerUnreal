WIP, not ready for public consumption yet

# Unreal Dedicated Servers with Steam sample application

This sample demonstrates how to get dedicated servers working with Steam on UE 5.3.

## Important: Firewall

## Downloading the engine

Using dedicated servers with Steam WILL require a custom Engine build. This is due to some preprocessor defines (UE_PROJECT_STEAMPRODUCTNAME etc.) that cannot be changed without a full engine rebuild.
In addition, it is highly useful for servers to enable logging (UE_LOG etc) in Shipping builds, and this also requires a custom build.

```basic summary for updating the engine here```

## Building the Client application

## Building the Server application

## Verifying the Server is visible in Steam

## Bonus: Uploading your game to Steam

Example Steam upload scripts (.vdf and .cmd files) are found under Tools/Steam/. First you should download Steamcmd.exe from https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip and place the .exe in Tools/Steam/Builder. Then you'll need to modify the .vdf files to use your own app IDs and file names, but once they're set up you should be able to deploy new builds to Steam simply by running the Build scripts and then the Upload .cmd.

## License

This sample is licensed under MIT.

```
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```