![Frame 3](https://res.cloudinary.com/dxdwmc7ob/image/upload/v1768667034/notescan_gx3hla.png)


# 📸 OCR – Flutter Text Scanner App

A Flutter-based **OCR (Optical Character Recognition)** application that allows users to **capture images using the device camera and extract text from them**.
Built with a clean architecture mindset and ready for community contributions.

---

## ✨ Features

* 📷 Capture images using the native device camera
* 🔍 Scan and extract text from images (OCR)
* ⚡ Fast and lightweight Flutter implementation
* 🧠 Proper camera lifecycle handling (no memory leaks)
* 📱 Android support (camera permissions configured)
* 🧩 Modular & scalable code structure

---

## 🛠️ Tech Stack

* **Flutter**
* **Dart**
* **Camera plugin**
* **State management** (Riverpod / Provider-style architecture)
* **ML / OCR package** (can be swapped or extended)

---

## 📂 Project Structure (High Level)

```
lib/
 ├── camera/
 │    ├── camera_view.dart
 │    └── camera_view_model.dart
 ├── ocr/
 │    └── text_scanner.dart
 ├── providers/
 └── main.dart
```

---

## 🚀 Getting Started

### Prerequisites

* Flutter SDK (latest stable)
* Android Studio / VS Code
* Android device or emulator with camera support

---

### Installation

```bash
git clone https://github.com/your-username/ocr.git
cd ocr
flutter pub get
flutter run
```

---

## 🔐 Android Permissions

Camera permissions are already configured in `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.CAMERA" />
```

Make sure to **grant camera permission at runtime** on the device.

---

## 📸 How It Works

1. User taps **Capture Image**
2. Camera screen opens
3. Image is captured
4. OCR scans the image
5. Extracted text is returned to the app

Camera resources are properly **disposed** to avoid memory leaks.

---

## 🧠 Best Practices Followed

* Safe disposal of camera controllers
* Avoid using `ref` during widget unmount
* Clear separation of UI and logic
* Open for extension (OCR engine can be replaced)

---

## 🤝 Contributing

Contributions are welcome!
If you’d like to improve this project:

1. Fork the repo
2. Create a new branch
3. Commit your changes
4. Open a Pull Request

---

## 📄 License

This project is **open source** and available under the **MIT License**.

---

## ⭐ Support

If you find this project useful, consider giving it a **star ⭐**
It helps the project grow and reach more developers.


Just tell me 👍
