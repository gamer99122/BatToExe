# BatToExe

[English](#english) | [繁體中文](#繁體中文)

---

## English

Convert a `.bat` script into a standalone `.exe` using Windows built-in tools — no third-party software required.

### Features

- Embeds your `.bat` content directly into the EXE
- Supports custom `.png` icon (auto-converted to `.ico` internally)
- Auto-requests UAC elevation (admin rights) at runtime
- Compiled with `csc.exe` (.NET Framework, built into Windows)

### Files

| File | Description |
|------|-------------|
| `build.bat` | Main entry point — double-click to run |
| `build.ps1` | Backend script called by `build.bat` (do not run directly) |
| `config.txt` | Your file paths — edit this before running |

### Usage

1. Open `config.txt` with Notepad
2. Fill in your file paths:

```
BAT=E:\Path\To\your_script.bat
PNG=E:\Path\To\your_icon.png
```

3. Save and double-click `build.bat`

The compiled EXE is placed in the **same folder as your `.bat` file**.

| Key | Required | Description |
|-----|----------|-------------|
| `BAT` | Yes | Full path to your `.bat` script |
| `PNG` | No | Full path to your `.png` icon — remove the line if not needed |

### Requirements

- Windows with .NET Framework 4.x (built into Windows 7+)
- No additional installs needed

---

## 繁體中文

將 `.bat` 腳本轉換為獨立 `.exe` 執行檔，僅使用 Windows 內建工具，無需安裝第三方軟體。

### 功能特色

- 將 `.bat` 內容直接嵌入 EXE
- 支援自訂 `.png` 圖示（自動轉換為 `.ico`）
- 執行時自動請求 UAC 提權（管理員權限）
- 使用 `csc.exe` 編譯（.NET Framework，Windows 內建）

### 檔案說明

| 檔案 | 說明 |
|------|------|
| `build.bat` | 主要入口，雙擊執行 |
| `build.ps1` | 被 `build.bat` 呼叫的後端腳本（不需直接執行） |
| `config.txt` | 填入你的檔案路徑，執行前先編輯這個檔案 |

### 使用方式

1. 用記事本開啟 `config.txt`
2. 填入你的檔案路徑：

```
BAT=E:\你的路徑\script.bat
PNG=E:\你的路徑\icon.png
```

3. 存檔後雙擊 `build.bat`

編譯完成的 EXE 會放在 **與 `.bat` 檔相同的資料夾**。

| 設定 | 必填 | 說明 |
|------|------|------|
| `BAT` | 是 | `.bat` 腳本的完整路徑 |
| `PNG` | 否 | `.png` 圖示的完整路徑，不需要圖示可刪除此行 |

### 系統需求

- Windows 搭配 .NET Framework 4.x（Windows 7 以上內建）
- 無需額外安裝任何軟體
