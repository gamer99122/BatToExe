# BatToExe

[English](#english) | [繁體中文](#繁體中文)

---

## English

Convert a `.bat` script into a standalone `.exe` using Windows built-in tools — no third-party software required.

### Features

- Embeds your `.bat` content directly into the EXE
- Supports custom `.ico` icon
- Auto-requests UAC elevation (admin rights) at runtime
- Compiled with `csc.exe` (.NET Framework, built into Windows)

### Files

| File | Description |
|------|-------------|
| `build.ps1` | PowerShell script that generates and compiles the EXE |

### Usage

Run `build.ps1` with the following parameters:

```powershell
.\build.ps1 -Bat <path-to-bat> [-Ico <path-to-ico>] [-Out <output-name.exe>]
```

| Parameter | Required | Description |
|-----------|----------|-------------|
| `-Bat` | Yes | Path to your `.bat` file (absolute or relative) |
| `-Ico` | No | Path to your `.ico` icon file (absolute or relative) |
| `-Out` | No | Output EXE filename (defaults to same name as the bat file) |

### Examples

```powershell
# Minimal — output will be myscript.exe next to the bat file
.\build.ps1 -Bat "C:\Scripts\myscript.bat"

# With custom icon
.\build.ps1 -Bat "C:\Scripts\myscript.bat" -Ico "C:\Scripts\icon.ico"

# With custom icon and custom output name
.\build.ps1 -Bat "C:\Scripts\myscript.bat" -Ico "C:\Scripts\icon.ico" -Out "MyApp.exe"

# Relative paths also work (relative to where you run the command)
.\build.ps1 -Bat "..\myscript.bat" -Ico "..\icon.ico"
```

The compiled EXE is placed in the **same folder as your `.bat` file**.

### Requirements

- Windows with .NET Framework 4.x (built into Windows 7+)
- No additional installs needed

---

## 繁體中文

將 `.bat` 腳本轉換為獨立 `.exe` 執行檔，僅使用 Windows 內建工具，無需安裝第三方軟體。

### 功能特色

- 將 `.bat` 內容直接嵌入 EXE
- 支援自訂 `.ico` 圖示
- 執行時自動請求 UAC 提權（管理員權限）
- 使用 `csc.exe` 編譯（.NET Framework，Windows 內建）

### 檔案說明

| 檔案 | 說明 |
|------|------|
| `build.ps1` | 自動產生並編譯 EXE 的 PowerShell 腳本 |

### 使用方式

執行 `build.ps1` 並傳入以下參數：

```powershell
.\build.ps1 -Bat <bat檔路徑> [-Ico <ico檔路徑>] [-Out <輸出檔名.exe>]
```

| 參數 | 必填 | 說明 |
|------|------|------|
| `-Bat` | 是 | `.bat` 檔案路徑（絕對或相對路徑皆可） |
| `-Ico` | 否 | `.ico` 圖示檔路徑（絕對或相對路徑皆可） |
| `-Out` | 否 | 輸出 EXE 的檔名（預設與 bat 檔同名） |

### 範例

```powershell
# 最簡用法 — 輸出 myscript.exe，放在 bat 檔同一資料夾
.\build.ps1 -Bat "C:\Scripts\myscript.bat"

# 加入自訂圖示
.\build.ps1 -Bat "C:\Scripts\myscript.bat" -Ico "C:\Scripts\icon.ico"

# 加入自訂圖示並指定輸出檔名
.\build.ps1 -Bat "C:\Scripts\myscript.bat" -Ico "C:\Scripts\icon.ico" -Out "MyApp.exe"

# 相對路徑也可以（相對於執行指令的位置）
.\build.ps1 -Bat "..\myscript.bat" -Ico "..\icon.ico"
```

編譯完成的 EXE 會放在 **與 `.bat` 檔相同的資料夾**。

### 系統需求

- Windows 搭配 .NET Framework 4.x（Windows 7 以上內建）
- 無需額外安裝任何軟體
