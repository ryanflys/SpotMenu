# SpotMenu-CN

**Spotify & Apple Music in your macOS menu bar**

A minimalist menu bar utility that displays your currently playing track with playback controls, keyboard shortcuts, and a beautiful native UI. Built with Swift and SwiftUI.

**中文版本** — 完整的简体中文界面支持，兼容 Xcode 15.4 和 macOS 13+

![Demo](https://github.com/user-attachments/assets/4b6b8e15-7180-44f1-abf7-796566a02fbb)

---

## Features

- **Menu Bar Integration** — View artist and song title directly in your menu bar
- **Playback Controls** — Hover overlay with play/pause, skip, and album art
- **Keyboard Shortcuts** — Global hotkeys for playback control
- **Track Liking** — Like/unlike tracks via Spotify Web API (Spotify only)
- **Compact View** — Toggle between full and compact display modes
- **Live Updates** — Automatically syncs with playback changes
- **Multi-Player Support** — Auto-detect or manually select Spotify / Apple Music
- **Fully Customizable** — Configure visuals, shortcuts, and behavior
- **🇨🇳 Chinese Localization** — Full Simplified Chinese UI support with language switcher

---

## Installation

### Download

Get the latest release from [GitHub Releases](https://github.com/ryanflys/SpotMenu-CN/releases/latest) and open `SpotMenu.app.zip`.

### Build from Source

**Requirements:** macOS 13+ (Ventura), Xcode 15.4+

```bash
git clone https://github.com/ryanflys/SpotMenu-CN.git
cd SpotMenu-CN
open SpotMenu.xcodeproj
```

**Note:** This version is compatible with Xcode 15.4 and includes full Simplified Chinese localization.

---

## Spotify Setup

To enable track liking/unliking, you need to set up a Spotify Developer App.

1. Go to [developer.spotify.com/dashboard](https://developer.spotify.com/dashboard)
2. Log in and click **Create an App**
3. Enter any name and description
4. In app settings, click **Edit Settings**
5. Under **Redirect URIs**, add:
   ```
   com.github.kmikiy.spotmenu://callback
   ```
6. Save and copy your **Client ID**
7. In SpotMenu, go to **Preferences → Music Player** and enable Track Liking
8. Paste your Client ID and complete the login flow

---

## Language / 语言

SpotMenu-CN supports both English and Simplified Chinese.

To change the language:
1. Right-click the menu bar icon → **Preferences...**
2. Go to **Language** section
3. Select your preferred language (English / 简体中文)
4. Restart the app

**切换语言：**
1. 右键点击菜单栏图标 → **偏好设置...**
2. 进入**语言**部分
3. 选择您喜欢的语言（English / 简体中文）
4. 重启应用

---

## Preferences

Access via right-click on the menu bar icon → **Preferences...**

### Music Player

Choose your music player:

- **Automatic** — Uses whichever player is active
- **Spotify**
- **Apple Music**

### Playback Appearance

Customize the player overlay:

- Hover Tint Color
- Foreground Color
- Blur Intensity
- Hover Tint Opacity

### Menu Bar

Configure display options:

- Show/hide artist and song title
- Show playing icon, liked icon, app icon
- Compact view mode
- Max width (40–300pt)

### Shortcuts

Set global hotkeys for:

- Play / Pause
- Next / Previous Track
- Like / Unlike / Toggle Like (Spotify only)

---

## Usage

| Action         | Result                   |
| -------------- | ------------------------ |
| Left-click     | Show/hide playback panel |
| Right-click    | Open context menu        |
| Hover on panel | Reveal playback controls |

---

## About This Version

This is a Chinese localized fork of [SpotMenu](https://github.com/kmikiy/SpotMenu) by [@kmikiy](https://github.com/kmikiy).

**Changes in SpotMenu-CN:**
- ✅ Full Simplified Chinese localization for all UI elements
- ✅ Downgraded to Xcode 15.4 compatibility
- ✅ Removed automatic update feature
- ✅ Updated dependencies for Swift 5.10 compatibility

**关于此版本：**

这是 [@kmikiy](https://github.com/kmikiy) 的 [SpotMenu](https://github.com/kmikiy/SpotMenu) 的中文本地化版本。

**SpotMenu-CN 的改进：**
- ✅ 所有界面元素的完整简体中文本地化
- ✅ 降级至 Xcode 15.4 兼容性
- ✅ 移除了自动更新功能
- ✅ 更新依赖以兼容 Swift 5.10

---

## Support

If you find SpotMenu useful, consider supporting the original author [@kmikiy](https://paypal.me/kmikiy).

---

## License

MIT License. See [LICENSE](LICENSE) for details.

Original project by [@kmikiy](https://github.com/kmikiy). Chinese localization and modifications by [@ryanflys](https://github.com/ryanflys).
