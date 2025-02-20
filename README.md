<p align="center">
  <a href="https://github.com/sircryptic/autoexif">
    <img src="https://github.com/user-attachments/assets/11a5382e-0805-4ec5-87c9-53b244021eff" alt="DisFrame" width="500" 
    onmouseover="this.style.transform='scale(1.05)'; this.style.opacity='0.8';" 
    onmouseout="this.style.transform='scale(1)'; this.style.opacity='1';">
  </a>

  <div align="center">
    <a href="https://github.com/sircryptic/autoexif/stargazers"><img src="https://img.shields.io/github/stars/sircryptic/autoexif.svg" alt="GitHub stars"></a>
    <a href="https://github.com/sircryptic/autoexif/network"><img src="https://img.shields.io/github/forks/sircryptic/autoexif.svg" alt="GitHub forks"></a>
    <a href="https://github.com/sircryptic/autoexif/watchers"><img src="https://img.shields.io/github/watchers/sircryptic/autoexif.svg?style=social" alt="GitHub watchers"></a>
    <br>
    <a href="https://github.com/SirCryptic/autoexif/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-green.svg" alt="License"></a>
</div>
  
#
AutoExif is a user-friendly tool that provides an intuitive graphical interface for the powerful `exiftool` utility, allowing you to view, edit, and wipe metadata from images and videos with ease.

## Features

- **Read Metadata**: View basic or detailed EXIF data from local files.
- **Web Metadata**: Extract metadata from online images via URLs.
- **Wipe Metadata**: Remove specific metadata types (e.g., GPS, Photoshop) or all metadata from local files, with an optional custom comment.
- **Extract Video GPS**: Pull GPS data from video files.
- **Thumbnail Info**: View metadata from image thumbnails.
- **Operation Log**: Track all actions performed within the tool.
- **Cross-Platform**: Runs as a standalone executable on Windows and as a Python script on macOS/Linux.

## Installation

### Windows
1. **Download**: Grab the latest `AutoExif.exe` from the [Releases](https://github.com/SirCryptic/autoexif/releases) page.
2. **Run**:(no additional installation required! `exiftool` is bundled within the executable.)

### macOS/Linux
1. **Install Python 3**: Ensure Python 3.6+ is installed (e.g., via `brew install python` on macOS or `sudo apt install python3` on Linux).
2. **Install Dependencies**:
```
   pip install pyqt5 requests
```
3. **Install ExifTool**:
* macOS:
```
brew install exiftool
```
* Linux (Ubuntu/Debian):
```
sudo apt update
sudo apt install libimage-exiftool-perl
```
4. **Download Script**: Get AutoExif.py from the repository.
5. **Run**:
```
python AutoExif.py
```
* **If exiftool isn’t installed, click "Install Dependencies" in the app for instructions.**

## Usage
- Local Files: Enter a file path (e.g., C:\path\to\image.jpg or /home/user/pic.jpg) or use the "Browse" button.
- URLs: Use URLs (e.g., http://example.com/pic.jpg) only for "Read Web Metadata" and "Extract Thumbnail Info."

## Credits
- `AutoExif` was developed by [SirCryptic](https://github.com/sircryptic) and is released under the [MIT License](https://github.com/SirCryptic/autoexif/blob/re-write/LICENSE).

### Special Thanks to
* Phil Harvey: For ExifTool, the backbone of this tool.
* PyQt5 Team: For the awesome GUI framework.
* Open Source Community: For tools and libraries that made this possible.

**This tool is dedicated to simplifying metadata management for everyone. Enjoy using AutoExif!**
