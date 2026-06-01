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
| `build.bat` | Main entry point — double-click or run from cmd |
| `build.ps1` | Backend script called by `build.bat` (do not run directly) |

### Usage

**Recommended: use `build.bat`**

```
build.bat <bat-file> [ico-file]
```

| Argument | Required | Description |
|----------|----------|-------------|
| `bat-file` | Yes | Path to your `.bat` file (absolute or relative) |
| `ico-file` | No | Path to your `.ico` icon file (absolute or relative) |

### Examples

```batch
:: Minimal — output will be myscript.exe next to the bat file
build.bat "C:\Scripts\myscript.bat"

:: With custom icon
build.bat "C:\Scripts\myscript.bat" "C:\Scripts\icon.ico"

:: Relative paths also work
build.bat "..\myscript.bat" "..\icon.ico"
```

The compiled EXE is placed in the **same folder as your `.bat` file**.

> If you need to customize the output filename, use `build.ps1` directly with the `-Out` parameter:
> ```powershell
> .\build.ps1 -Bat "C:\Scripts\myscript.bat" -Ico "C:\Scripts\icon.ico" -Out "MyApp.exe"
> ```

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
| `build.bat` | 主要入口，雙擊或在 cmd 中呼叫 |
| `build.ps1` | 被 `build.bat` 呼叫的後端腳本（不需直接執行） |

### 使用方式

**建議使用 `build.bat`**

```
build.bat <bat檔路徑> [ico檔路徑]
```

| 參數 | 必填 | 說明 |
|------|------|------|
| `bat檔路徑` | 是 | `.bat` 檔案路徑（絕對或相對路徑皆可） |
| `ico檔路徑` | 否 | `.ico` 圖示檔路徑（絕對或相對路徑皆可） |

### 範例

```batch
:: 最簡用法 — 輸出 myscript.exe，放在 bat 檔同一資料夾
build.bat "C:\Scripts\myscript.bat"

:: 加入自訂圖示
build.bat "C:\Scripts\myscript.bat" "C:\Scripts\icon.ico"

:: 相對路徑也可以
build.bat "..\myscript.bat" "..\icon.ico"
```

編譯完成的 EXE 會放在 **與 `.bat` 檔相同的資料夾**。

> 若需要自訂輸出檔名，可直接使用 `build.ps1` 的 `-Out` 參數：
> ```powershell
> .\build.ps1 -Bat "C:\Scripts\myscript.bat" -Ico "C:\Scripts\icon.ico" -Out "MyApp.exe"
> ```

### 系統需求

- Windows 搭配 .NET Framework 4.x（Windows 7 以上內建）
- 無需額外安裝任何軟體
