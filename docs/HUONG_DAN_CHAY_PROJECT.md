# Hướng Dẫn Chạy Project Du Lịch Hưng Yên

## 📋 Yêu Cầu Hệ Thống

### 1. Cài Đặt Flutter SDK
- **Flutter SDK**: Version 3.11.1 trở lên
- **Dart SDK**: Đi kèm với Flutter
- Download tại: https://flutter.dev/docs/get-started/install

### 2. IDE (Chọn 1 trong 2)
- **Visual Studio Code** + Flutter Extension (Đang dùng)
- **Android Studio** + Flutter Plugin

### 3. Thiết Bị/Emulator
- **Android**: Android Studio Emulator hoặc thiết bị thật
- **iOS**: Xcode Simulator (chỉ trên macOS) hoặc thiết bị thật
- **Web**: Chrome browser
- **Windows**: Windows 10/11

---

## 🚀 Các Bước Chạy Project

### Bước 1: Kiểm Tra Flutter

Mở Terminal/Command Prompt và chạy:

```bash
flutter doctor
```

**Kết quả mong đợi:**
```
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.11.1, on Microsoft Windows...)
[✓] Android toolchain - develop for Android devices
[✓] Chrome - develop for the web
[✓] Visual Studio Code (version 1.xx.x)
[✓] Connected device (1 available)
```

**Nếu có lỗi:**
- `[✗] Android toolchain`: Cài Android Studio và Android SDK
- `[✗] Chrome`: Cài Google Chrome
- `[!] Android Studio`: Chạy `flutter doctor --android-licenses`

---

### Bước 2: Cài Đặt Dependencies

Trong thư mục project (`d:\VNPT\DuLichMobile`), chạy:

```bash
# Cài đặt tất cả packages
flutter pub get

# Nếu có lỗi, thử clean trước
flutter clean
flutter pub get
```

**Packages sẽ được cài:**
- `flutter_riverpod`: State management
- `go_router`: Navigation
- `dio`: HTTP client
- `cached_network_image`: Cache ảnh
- `flutter_html`: Render HTML
- `carousel_slider`: Slider/Banner
- Và các packages khác...

---

### Bước 3: Chọn Thiết Bị

#### Option A: Android Emulator

1. Mở Android Studio
2. Tools → Device Manager
3. Create Device → Chọn Pixel 5 → Next
4. Chọn System Image (Android 13 recommended) → Next → Finish
5. Click Play để start emulator

Hoặc dùng command:
```bash
# List emulators
flutter emulators

# Start emulator
flutter emulators --launch <emulator_id>
```

#### Option B: Chrome (Web)

```bash
# Chạy trên Chrome
flutter run -d chrome
```

#### Option C: Windows Desktop

```bash
# Chạy trên Windows
flutter run -d windows
```

#### Option D: Thiết Bị Thật (Android)

1. Bật **Developer Options** trên điện thoại:
   - Settings → About Phone → Tap "Build Number" 7 lần
2. Bật **USB Debugging**:
   - Settings → Developer Options → USB Debugging
3. Kết nối USB với máy tính
4. Chấp nhận "Allow USB Debugging" trên điện thoại

---

### Bước 4: Chạy App

#### Cách 1: Dùng Command Line

```bash
# Xem danh sách devices
flutter devices

# Chạy app (tự động chọn device)
flutter run

# Chạy trên device cụ thể
flutter run -d <device_id>

# Chạy ở chế độ release (nhanh hơn)
flutter run --release
```

#### Cách 2: Dùng VS Code

1. Mở file `lib/main.dart`
2. Nhấn `F5` hoặc click "Run" → "Start Debugging"
3. Hoặc nhấn `Ctrl+F5` để chạy không debug

#### Cách 3: Dùng Android Studio

1. Mở project trong Android Studio
2. Chọn device từ dropdown
3. Click nút Run (▶️) hoặc nhấn `Shift+F10`

---

## 🔧 Các Lệnh Hữu Ích

### Development

```bash
# Hot reload (trong khi app đang chạy)
# Nhấn 'r' trong terminal

# Hot restart (trong khi app đang chạy)
# Nhấn 'R' trong terminal

# Quit app
# Nhấn 'q' trong terminal

# Chạy với verbose logging
flutter run -v

# Chạy trên device cụ thể
flutter run -d chrome
flutter run -d windows
flutter run -d <android_device_id>
```

### Build

```bash
# Build APK (Android)
flutter build apk

# Build APK split per ABI (nhỏ hơn)
flutter build apk --split-per-abi

# Build App Bundle (để upload lên Play Store)
flutter build appbundle

# Build Windows
flutter build windows

# Build Web
flutter build web
```

### Debugging

```bash
# Analyze code
flutter analyze

# Format code
flutter format .

# Run tests
flutter test

# Check dependencies
flutter pub outdated
```

### Clean & Reset

```bash
# Clean build files
flutter clean

# Get dependencies lại
flutter pub get

# Upgrade dependencies
flutter pub upgrade

# Reset Flutter
flutter doctor
flutter clean
flutter pub get
```

---

## 📱 Test API Trước Khi Chạy

Trước khi chạy app, test API để đảm bảo hoạt động:

```bash
# Test API với curl
curl -X POST "https://hungyentourism.com.vn/api/home.asmx/Lay_detail_tintuc" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "id=25&uservn=VNPT@manhbeo123&passvn=Manhbeo@123@9897"
```

Hoặc dùng Postman:
1. Method: POST
2. URL: `https://hungyentourism.com.vn/api/home.asmx/Lay_detail_tintuc`
3. Body → x-www-form-urlencoded:
   - `id`: 25
   - `uservn`: VNPT@manhbeo123
   - `passvn`: Manhbeo@123@9897

---

## 🐛 Xử Lý Lỗi Thường Gặp

### 1. "Gradle build failed"

```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### 2. "Unable to locate Android SDK"

- Cài Android Studio
- Set ANDROID_HOME environment variable
- Chạy `flutter doctor --android-licenses`

### 3. "CocoaPods not installed" (iOS/macOS)

```bash
sudo gem install cocoapods
cd ios
pod install
cd ..
flutter run
```

### 4. "Waiting for another flutter command to release the startup lock"

```bash
# Xóa lock file
rm <flutter_sdk_path>/bin/cache/lockfile
```

### 5. "Version solving failed"

```bash
flutter clean
rm pubspec.lock
flutter pub get
```

### 6. "Hot reload not working"

- Restart app: Nhấn `R` trong terminal
- Hoặc stop và chạy lại: `flutter run`

### 7. "API connection failed"

- Check internet connection
- Check credentials trong code
- Test API với curl/Postman
- Check firewall/antivirus

---

## 📂 Cấu Trúc Project

```
DuLichMobile/
├── lib/
│   ├── main.dart              # Entry point
│   ├── app/                   # App configuration
│   ├── core/                  # Core utilities
│   │   ├── constants/         # Constants
│   │   ├── theme/            # Theme configuration
│   │   └── utils/            # Utilities
│   └── features/             # Features
│       ├── home/             # Home screen
│       ├── places/           # Places feature
│       ├── news/             # News feature
│       └── ...
├── assets/                   # Assets (images, icons)
├── android/                  # Android specific
├── ios/                      # iOS specific
├── web/                      # Web specific
├── windows/                  # Windows specific
├── test/                     # Tests
├── pubspec.yaml             # Dependencies
└── API_ANALYSIS.md          # API documentation
```

---

## 🎯 Quick Start (TL;DR)

```bash
# 1. Check Flutter
flutter doctor

# 2. Get dependencies
flutter pub get

# 3. Run app
flutter run

# Hoặc chạy trên Chrome
flutter run -d chrome

# Hoặc chạy trên Windows
flutter run -d windows
```

---

## 📞 Hỗ Trợ

Nếu gặp vấn đề:

1. **Check Flutter Doctor**: `flutter doctor -v`
2. **Clean Project**: `flutter clean && flutter pub get`
3. **Check API**: Xem file `API_ANALYSIS.md`
4. **Google Error**: Copy error message và search
5. **Stack Overflow**: https://stackoverflow.com/questions/tagged/flutter
6. **Flutter Discord**: https://discord.gg/flutter

---

## 📚 Tài Liệu Tham Khảo

- **Flutter Docs**: https://docs.flutter.dev/
- **Dart Docs**: https://dart.dev/guides
- **Riverpod**: https://riverpod.dev/
- **Go Router**: https://pub.dev/packages/go_router
- **Dio**: https://pub.dev/packages/dio

---

**Last Updated**: 2026-05-18  
**Flutter Version**: 3.11.1+  
**Project**: Hưng Yên Travel App
