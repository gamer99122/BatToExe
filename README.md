# BatToExe

[English](#english) | [繁體中文](#繁體中文)

---

## English

Convert a `.bat` script into a standalone `.exe` using Windows built-in tools — no third-party software required.

### Features

- Wraps batch script logic in a C# launcher
- Supports custom `.ico` icon
- Auto-requests UAC elevation (admin rights) at runtime
- Compiled with `csc.exe` (.NET Framework, built into Windows)

### Files

| File | Description |
|------|-------------|
| `launcher.cs` | C# wrapper that runs your batch commands |
| `build.ps1` | PowerShell script to compile the EXE |

### Usage

**1. Edit `launcher.cs`**

Replace the commands inside `Main()` with your own:

```csharp
Process.Start(new ProcessStartInfo("your-command", "arguments") {
    UseShellExecute = false,
    CreateNoWindow = true
}).WaitForExit();
```

Remove the `IsAdmin()` check if your script does not require elevated privileges.

**2. Add an icon (optional)**

Place your `icon.ico` in the same folder as `build.ps1`.

**3. Compile**

```powershell
.\build.ps1
```

Output: your `.exe` in the same folder.

### Requirements

- Windows with .NET Framework 4.x (built into Windows 7+)
- No additional installs needed

---

## 繁體中文

將 `.bat` 腳本轉換為獨立 `.exe` 執行檔，僅使用 Windows 內建工具，無需安裝第三方軟體。

### 功能特色

- 將批次腳本邏輯包裝成 C# 啟動器
- 支援自訂 `.ico` 圖示
- 執行時自動請求 UAC 提權（管理員權限）
- 使用 `csc.exe` 編譯（.NET Framework，Windows 內建）

### 檔案說明

| 檔案 | 說明 |
|------|------|
| `launcher.cs` | 執行批次指令的 C# 包裝器 |
| `build.ps1` | 用於編譯 EXE 的 PowerShell 腳本 |

### 使用方式

**1. 修改 `launcher.cs`**

將 `Main()` 內的指令替換成你自己的：

```csharp
Process.Start(new ProcessStartInfo("你的指令", "參數") {
    UseShellExecute = false,
    CreateNoWindow = true
}).WaitForExit();
```

若腳本不需要管理員權限，可移除 `IsAdmin()` 的檢查邏輯。

**2. 加入圖示（選填）**

將 `icon.ico` 放到與 `build.ps1` 相同的資料夾中。

**3. 編譯**

```powershell
.\build.ps1
```

輸出：同資料夾下產生 `.exe` 執行檔。

### 系統需求

- Windows 搭配 .NET Framework 4.x（Windows 7 以上內建）
- 無需額外安裝任何軟體
