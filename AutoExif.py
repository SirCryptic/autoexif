#!/usr/bin/env python3
import sys
import os
import platform
import subprocess
import requests
import tempfile
import shutil
import zipfile
from PyQt5.QtWidgets import (QApplication, QWidget, QVBoxLayout, QHBoxLayout, QGridLayout,
                             QPushButton, QLabel, QLineEdit, QFileDialog, QTextEdit,
                             QMessageBox, QStatusBar, QInputDialog)
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QPalette, QColor, QIcon, QPixmap
from io import BytesIO
from datetime import datetime

class AutoExifUI(QWidget):
    VERSION = "1.3.7"

    def __init__(self):
        super().__init__()
        self.log = []
        self.system = platform.system().lower()
        self.temp_dir = tempfile.mkdtemp()
        self.script_dir = os.path.dirname(os.path.abspath(__file__))
        self.exiftool_path = self.setupExiftool()
        self.initUI()

    def setupExiftool(self):
        """Setup exiftool path, extracting from resources if needed."""
        if self.system == 'windows':
            try:
                if hasattr(sys, '_MEIPASS'):
                    resource_base = sys._MEIPASS
                else:
                    resource_base = self.script_dir

                exiftool_src = os.path.join(resource_base, "exiftool.exe")
                if not os.path.exists(exiftool_src):
                    raise FileNotFoundError("exiftool.exe not found in bundle")
                exiftool_exe = os.path.join(self.temp_dir, "exiftool.exe")
                shutil.copy(exiftool_src, exiftool_exe)

                exiftool_files_zip = os.path.join(resource_base, "exiftool_files.zip")
                if os.path.exists(exiftool_files_zip):
                    with zipfile.ZipFile(exiftool_files_zip, 'r') as zip_ref:
                        zip_ref.extractall(self.temp_dir)
                    self.log.append(f"{datetime.now()} - Extracted exiftool_files.zip")
                else:
                    self.log.append(f"{datetime.now()} - Note: exiftool_files.zip not bundled, using standalone exiftool.exe")

                return exiftool_exe
            except Exception as e:
                self.log.append(f"{datetime.now()} - Error setting up exiftool: {e}")
                QMessageBox.critical(self, "Error", f"Failed to setup bundled exiftool: {e}\nFalling back to system exiftool.")
                return "exiftool"
        else:
            return "exiftool"

    def cleanup(self):
        """Clean up temporary directory on exit."""
        try:
            shutil.rmtree(self.temp_dir)
        except Exception as e:
            self.log.append(f"{datetime.now()} - Error cleaning up temp dir: {e}")

    def initUI(self):
        self.setWindowTitle(f'Auto Exif v{self.VERSION}')
        main_layout = QVBoxLayout()

        palette = QPalette()
        palette.setColor(QPalette.Window, QColor(30, 30, 30))
        palette.setColor(QPalette.WindowText, Qt.white)
        palette.setColor(QPalette.Base, QColor(45, 45, 45))
        palette.setColor(QPalette.Text, Qt.white)
        palette.setColor(QPalette.PlaceholderText, QColor(150, 150, 150))
        palette.setColor(QPalette.Button, QColor(0, 0, 0))
        palette.setColor(QPalette.ButtonText, Qt.black)
        self.setPalette(palette)

        try:
            response = requests.get("https://user-images.githubusercontent.com/48811414/219992613-de266069-beaa-4071-ac2c-8b563fb441ac.png", timeout=5)
            img_data = BytesIO(response.content)
            pixmap = QPixmap()
            pixmap.loadFromData(img_data.getvalue())
            if not pixmap.isNull():
                self.setWindowIcon(QIcon(pixmap))
        except Exception as e:
            print(f"Error setting window icon: {e}")

        header = QLabel(f"Auto Exif v{self.VERSION} - Metadata Tool\nCreated by Sir Cryptic", self)
        header.setAlignment(Qt.AlignCenter)
        main_layout.addWidget(header)

        input_layout = QHBoxLayout()
        self.fileInput = QLineEdit(self)
        self.fileInput.setPlaceholderText("Enter file path or URL (e.g., /home/user/pic.jpg or http://example.com/pic.jpg)")
        self.fileInput.setToolTip("Path to a local file or a URL (URLs valid only for Read Web Metadata/Extract Thumbnail Info).")
        input_palette = QPalette()
        input_palette.setColor(QPalette.Text, Qt.black)
        self.fileInput.setPalette(input_palette)
        input_layout.addWidget(self.fileInput)
        browseButton = QPushButton('Browse', self)
        browseButton.clicked.connect(self.browseFiles)
        browseButton.setToolTip("Browse for a local file.")
        input_layout.addWidget(browseButton)
        main_layout.addLayout(input_layout)

        self.outputText = QTextEdit(self)
        self.outputText.setReadOnly(True)
        self.outputText.setToolTip("Displays the output of EXIF operations.")
        main_layout.addWidget(self.outputText)

        button_layout = QGridLayout()
        options = [
            ("Read Basic Metadata", self.readBasicMetadata, "Extract basic EXIF metadata from a local file."),
            ("Read Expert Metadata", self.readExpertMetadata, "Extract detailed EXIF metadata from a local file."),
            ("Read Web Metadata", self.readWebMetadata, "Extract metadata from an online image URL."),
            ("Wipe Data (Except JFIF)", self.wipeDataExceptJFIF, "Wipe specific metadata types from a local file, preserving JFIF."),
            ("Wipe All GPS Data", self.wipeGPSData, "Remove all GPS metadata from a local file."),
            ("Wipe All Metadata", self.wipeAllMetadata, "Wipe all metadata from a local file and add a custom comment."),
            ("Extract Video GPS", self.extractVideoGPS, "Extract GPS data from a local video file."),
            ("Extract Thumbnail Info", self.extractThumbnailInfo, "Extract metadata from an image thumbnail (local or URL)."),
            ("Wipe Photoshop Metadata", self.wipePhotoshopMetadata, "Remove Photoshop-specific metadata from a local file."),
            ("Clear Output", self.clearOutput, "Clear the output display."),
            ("View Log", self.viewLog, "View history of operations."),
            ("Help", self.showHelp, "Show usage instructions (and maybe an Easter egg?)."),
            ("Install Dependencies", self.installDependencies, "Install exiftool if not present (Linux/macOS only)."),
            ("Credits", self.showCredits, "View credits and acknowledgments.")
        ]
        for i, (text, func, tooltip) in enumerate(options):
            btn = QPushButton(text, self)
            btn.clicked.connect(func)
            btn.setToolTip(tooltip)
            button_layout.addWidget(btn, i // 4, i % 4)
        main_layout.addLayout(button_layout)

        self.statusBar = QStatusBar(self)
        self.statusBar.showMessage("Ready")
        main_layout.addWidget(self.statusBar)

        self.setLayout(main_layout)
        self.setGeometry(300, 300, 800, 600)

    def browseFiles(self):
        file, _ = QFileDialog.getOpenFileName(self, "Select File", "", "All Files (*);;Images (*.png *.jpg *.jpeg);;Videos (*.m2ts *.mp4)")
        if file:
            self.fileInput.setText(file)

    def checkExiftool(self):
        try:
            result = subprocess.run([self.exiftool_path, "-ver"], check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            self.log.append(f"{datetime.now()} - Exiftool version: {result.stdout.decode('utf-8').strip()}")
            return True
        except (subprocess.CalledProcessError, FileNotFoundError, PermissionError):
            if self.system == 'windows':
                QMessageBox.critical(self, "Error", f"Failed to run bundled exiftool.exe at {self.exiftool_path}. Ensure it’s correctly bundled.")
            else:
                QMessageBox.warning(self, "Error", "System exiftool not found. Use 'Install Dependencies' to install it.")
            self.log.append(f"{datetime.now()} - Error: Exiftool not executable at {self.exiftool_path}")
            return False

    def runExiftool(self, args, input_data=None):
        if not self.checkExiftool():
            return None
        try:
            self.statusBar.showMessage("Running exiftool...")
            process = subprocess.Popen([self.exiftool_path] + args, stdin=subprocess.PIPE if input_data else None,
                                       stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            stdout, stderr = process.communicate(input=input_data)
            if process.returncode == 0:
                self.log.append(f"{datetime.now()} - Success: {' '.join(args)}")
                self.statusBar.showMessage("Operation completed")
                return stdout.decode('utf-8', errors='replace')
            else:
                self.outputText.setText(f"Error: {stderr.decode('utf-8', errors='replace')}")
                self.log.append(f"{datetime.now()} - Error: {stderr.decode('utf-8', errors='replace')}")
                self.statusBar.showMessage("Operation failed")
                return None
        except Exception as e:
            self.outputText.setText(f"Error running exiftool: {e}")
            self.log.append(f"{datetime.now()} - Exception: {e}")
            self.statusBar.showMessage("Operation failed")
            return None

    def getFilePath(self):
        path = self.fileInput.text().strip()
        if not path:
            QMessageBox.warning(self, "Oops", "Please enter a file path!")
            return None
        return path

    def readBasicMetadata(self):
        path = self.getFilePath()
        if path:
            if path.startswith('http'):
                QMessageBox.warning(self, "Error", "This operation requires a local file path, not a URL. Use 'Read Web Metadata' for URLs.")
                return
            if not os.path.exists(path):
                QMessageBox.warning(self, "Error", "File not found or invalid path!")
                return
            self.outputText.setText("Extracting Basic Metadata...")
            output = self.runExiftool([path])
            if output:
                self.outputText.setText(output)

    def readExpertMetadata(self):
        path = self.getFilePath()
        if path:
            if path.startswith('http'):
                QMessageBox.warning(self, "Error", "This operation requires a local file path, not a URL. Use 'Read Web Metadata' for URLs.")
                return
            if not os.path.exists(path):
                QMessageBox.warning(self, "Error", "File not found or invalid path!")
                return
            self.outputText.setText("Extracting Expert Metadata...")
            with open(path, 'rb') as f:
                output = self.runExiftool(["-"], input_data=f.read())
            if output:
                self.outputText.setText(output)

    def readWebMetadata(self):
        url = self.getFilePath()
        if url and url.startswith('http'):
            self.outputText.setText("Extracting Metadata from URL...")
            try:
                response = requests.get(url, timeout=5)
                output = self.runExiftool(["-fast", "-"], input_data=response.content)
                if output:
                    self.outputText.setText(output)
            except requests.RequestException as e:
                self.outputText.setText(f"Error fetching URL: {e}")
        else:
            QMessageBox.warning(self, "Error", "Please enter a valid URL!")

    def wipeDataExceptJFIF(self):
        path = self.getFilePath()
        if path:
            if path.startswith('http'):
                QMessageBox.warning(self, "Error", "This operation requires a local file path, not a URL.")
                return
            if not os.path.exists(path):
                QMessageBox.warning(self, "Error", "File not found or invalid path!")
                return
            data_type, ok = QInputDialog.getText(self, "Wipe Data", "Enter data type to wipe (e.g., JFIF or GPS):")
            if ok and data_type:
                self.outputText.setText(f"Wiping {data_type} Data...")
                output = self.runExiftool(["-all=", f"--{data_type}:all", path])
                if output:
                    self.outputText.setText("Data wiped successfully!\n" + output)
            else:
                QMessageBox.warning(self, "Oops", "Data type required!")

    def wipeGPSData(self):
        path = self.getFilePath()
        if path:
            if path.startswith('http'):
                QMessageBox.warning(self, "Error", "This operation requires a local file path, not a URL.")
                return
            if not os.path.exists(path):
                QMessageBox.warning(self, "Error", "File not found or invalid path!")
                return
            self.outputText.setText("Wiping GPS Data...")
            output = self.runExiftool(["-gps:all=", path])
            if output:
                self.outputText.setText("GPS data wiped successfully!\n" + output)

    def wipeAllMetadata(self):
        path = self.getFilePath()
        if path:
            if path.startswith('http'):
                QMessageBox.warning(self, "Error", "Wiping metadata from URLs is not supported. Please use a local file path.")
                return
            if not os.path.exists(path):
                QMessageBox.warning(self, "Error", "File not found or invalid path!")
                return
            comment, ok = QInputDialog.getText(self, "Custom Comment", "Enter a custom comment for the metadata (optional):")
            if ok:
                self.outputText.setText("Wiping All Metadata...")
                if comment:
                    output = self.runExiftool(["-all=", f"-comment={comment}", path])
                else:
                    output = self.runExiftool(["-all=", path])
                if output:
                    self.outputText.setText("All metadata wiped successfully!\n" + output)

    def extractVideoGPS(self):
        path = self.getFilePath()
        if path:
            if path.startswith('http'):
                QMessageBox.warning(self, "Error", "This operation requires a local file path, not a URL.")
                return
            if not os.path.exists(path):
                QMessageBox.warning(self, "Error", "File not found or invalid path!")
                return
            self.outputText.setText("Extracting GPS from Video...")
            output = self.runExiftool(["-ee", "-p", "$gpslatitude, $gpslongitude, $gpstimestamp", path])
            if output:
                self.outputText.setText(output)

    def extractThumbnailInfo(self):
        path = self.getFilePath()
        if path:
            if path.startswith('http'):
                self.outputText.setText("Extracting Thumbnail Info from URL...")
                try:
                    response = requests.get(path, timeout=5)
                    thumbnail_data = self.runExiftool([path, "-thumbnailimage", "-b"], input_data=response.content)
                    if thumbnail_data:
                        output = self.runExiftool(["-"], input_data=thumbnail_data.encode('utf-8'))
                        if output:
                            self.outputText.setText(output)
                        else:
                            self.outputText.setText("No thumbnail data available.")
                    else:
                        self.outputText.setText("No thumbnail data available.")
                except requests.RequestException as e:
                    self.outputText.setText(f"Error fetching URL: {e}")
            else:
                if not os.path.exists(path):
                    QMessageBox.warning(self, "Error", "File not found or invalid path!")
                    return
                self.outputText.setText("Extracting Thumbnail Info...")
                thumbnail_data = self.runExiftool([path, "-thumbnailimage", "-b"])
                if thumbnail_data:
                    output = self.runExiftool(["-"], input_data=thumbnail_data.encode('utf-8'))
                    if output:
                        self.outputText.setText(output)
                else:
                    self.outputText.setText("No thumbnail data available.")

    def wipePhotoshopMetadata(self):
        path = self.getFilePath()
        if path:
            if path.startswith('http'):
                QMessageBox.warning(self, "Error", "This operation requires a local file path, not a URL.")
                return
            if not os.path.exists(path):
                QMessageBox.warning(self, "Error", "File not found or invalid path!")
                return
            self.outputText.setText("Wiping Photoshop Metadata...")
            output = self.runExiftool(["-Photoshop:All=", path])
            if output:
                self.outputText.setText("Photoshop metadata wiped successfully!\n" + output)

    def clearOutput(self):
        self.outputText.clear()
        self.statusBar.showMessage("Output cleared")

    def viewLog(self):
        log_text = "\n".join(self.log) if self.log else "No operations logged yet."
        QMessageBox.information(self, "Operation Log", log_text)

    def showHelp(self):
        path = self.fileInput.text().strip()
        if path.upper() == "RJW":
            easter_egg = (
                f"Easter Egg!\n\n"
                "To RJW, born 22/05/18:\n"
                "You're the coolest little dude! Keep shining, my son!"
            )
            QMessageBox.information(self, "Special Message", easter_egg)
        else:
            help_text = (
                f"Auto Exif v{self.VERSION} - Metadata Tool\n\n"
                "1. Enter a file path or URL in the input field.\n"
                "2. Use 'Browse' to select local files.\n"
                "3. On Windows, exiftool is bundled in the executable.\n"
                "   On Linux/macOS, install exiftool if prompted.\n"
                "4. Features:\n"
                "   - Read Basic/Expert Metadata: View EXIF data (local files only).\n"
                "   - Read Web Metadata: Fetch from online images (URLs allowed).\n"
                "   - Wipe Data: Remove specific types (e.g., JFIF/GPS, local files only).\n"
                "   - Wipe GPS/All Metadata: Clear GPS or all data with a custom comment (local files only).\n"
                "   - Extract Video GPS: Get GPS from videos (local files only).\n"
                "   - Thumbnail Info: View thumbnail metadata (local files or URLs).\n"
                "   - Wipe Photoshop Metadata: Remove Photoshop data (local files only).\n"
                "5. Log: View operation history with 'View Log'.\n"
            )
            QMessageBox.information(self, "Help", help_text)

    def showCredits(self):
        credits_text = (
            f"Auto Exif v{self.VERSION} - Credits\n\n"
            "Created by: Sir Cryptic\n"
            "Special Thanks:\n"
            "   - Phil Harvey: For ExifTool, the backbone of this tool.\n"
            "   - PyQt5 Team: For the awesome GUI framework.\n"
            "   - Open Source Community: For tools and libraries that made this possible.\n\n"
            "This tool is dedicated to making metadata management easy and accessible.\n"
            "Enjoy using Auto Exif!"
        )
        QMessageBox.information(self, "Credits", credits_text)

    def installDependencies(self):
        if self.system == 'windows':
            QMessageBox.information(self, "Windows Info", 
                                    "Exiftool is bundled in this executable.\n"
                                    "No additional installation needed unless it fails to run.")
            return
        reply = QMessageBox.question(self, "Install Dependencies", 
                                     "Install exiftool? Requires admin privileges.", 
                                     QMessageBox.Yes | QMessageBox.No)
        if reply == QMessageBox.Yes:
            try:
                if self.system == 'linux':
                    subprocess.run(["sudo", "apt", "install", "-y", "libimage-exiftool-perl"], check=True)
                elif self.system == 'darwin':
                    subprocess.run(["brew", "install", "exiftool"], check=True)
                else:
                    raise Exception("Unsupported OS for auto-install")
                QMessageBox.information(self, "Success", "Exiftool installed successfully!")
                self.log.append(f"{datetime.now()} - Installed exiftool for {self.system}")
            except subprocess.CalledProcessError as e:
                QMessageBox.critical(self, "Error", f"Failed to install exiftool: {e}")
                self.log.append(f"{datetime.now()} - Installation failed: {e}")
            except Exception as e:
                QMessageBox.critical(self, "Error", f"Installation not supported: {e}")
                self.log.append(f"{datetime.now()} - Installation error: {e}")

    def closeEvent(self, event):
        self.cleanup()
        event.accept()

if __name__ == "__main__":
    app = QApplication(sys.argv)
    ex = AutoExifUI()
    ex.show()
    sys.exit(app.exec_())