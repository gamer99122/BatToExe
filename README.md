# BatToExe

Convert a `.bat` script into a standalone `.exe` using Windows built-in tools — no third-party software required.

## Features

- Wraps batch script logic in a C# launcher
- Supports custom `.ico` icon
- Auto-requests UAC elevation (admin rights) at runtime
- Compiled with `csc.exe` (.NET Framework, built into Windows)

## Files

| File | Description |
|------|-------------|
| `launcher.cs` | C# wrapper that runs your batch commands |
| `build.ps1` | PowerShell script to compile the EXE |

## Usage

### 1. Edit `launcher.cs`

Replace the commands inside `Main()` with your own:

```csharp
Process.Start(new ProcessStartInfo("your-command", "arguments") {
    UseShellExecute = false,
    CreateNoWindow = true
}).WaitForExit();
```

Remove the `IsAdmin()` check if your script does not require elevated privileges.

### 2. Add an icon (optional)

Place your `icon.ico` in the same folder as `build.ps1`.

### 3. Compile

```powershell
.\build.ps1
```

Output: `your-script.exe` in the same folder.

## Requirements

- Windows with .NET Framework 4.x (built into Windows 7+)
- No additional installs needed
