# Remove Windows Shortcut Arrow

Gets rid of the annoying arrow on Windows shortcut icons. One click to remove it, one click to bring it back.

## Usage

1. Download `apply.bat` and `uninstall.bat`.
2. Right-click one of them and choose **Run as administrator**.

| Script | Result |
| --- | --- |
| `apply.bat` | Removes the shortcut arrow |
| `uninstall.bat` | Restores the default arrow |

Explorer restarts automatically, so the taskbar flickers and open File Explorer windows close. If an icon still looks the same, restart your PC.

## How it works

Windows draws the arrow as an overlay icon whose location is stored in the registry as shell icon slot `29`.

- `apply.bat` points that slot at the blank icon built into Windows:
  ```
  HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons
  29 = %SystemRoot%\System32\imageres.dll,197
  ```
- `uninstall.bat` deletes the value, so Windows uses its default arrow again.

Both scripts then clear the icon cache and restart Explorer so the change shows immediately.

The built-in icon is used on purpose. A custom blank `.ico` file can leave black squares over icons at some sizes, while Windows' own icon works at every size.

## Notes

- Needs administrator rights and applies to all users on the PC.
- A big Windows update may reset it. Just run `apply.bat` again.
- It edits the registry, so use it at your own risk. (but it's safe anyway cause it just edit one icon, nothing could go wrong lol)
