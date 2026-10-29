# 🔧 Fix Lỗi CORS Khi Chạy Flutter Web

## ❌ Lỗi Gặp Phải

```
Access to XMLHttpRequest at 'https://hungyentourism.com.vn/api/home.asmx?op=Lay_ds_tintuc' 
from origin 'http://localhost:50142' has been blocked by CORS policy: 
Response to preflight request doesn't pass access control check: 
No 'Access-Control-Allow-Origin' header is present on the requested resource.
```

## 🤔 Tại Sao Lỗi Này Xảy Ra?

- **CORS** (Cross-Origin Resource Sharing) là chính sách bảo mật của trình duyệt
- Khi Flutter Web chạy trên `localhost:50142`, browser CHẶN request đến `hungyentourism.com.vn`
- Server Hưng Yên Tourism không gửi header `Access-Control-Allow-Origin`
- **Đây KHÔNG phải lỗi code Flutter**, mà là chính sách bảo mật của Chrome
- **Lỗi này CHỈ xảy ra trên Web**, KHÔNG xảy ra trên Android/iOS/Windows

---

## ✅ 4 Cách Giải Quyết

### 🥇 Cách 1: Chạy Trên Android/iOS/Windows (KHUYẾN NGHỊ)

**Đơn giản nhất** - Không có CORS trên mobile/desktop:

```bash
# Android
flutter run -d android

# Windows
flutter run -d windows

# Liệt kê devices
flutter devices
```

✅ **Ưu điểm:** Không cần config gì, app chạy ngay  
✅ **Phù hợp:** Production, testing thực tế

---

### 🥈 Cách 2: Chạy Chrome Với CORS Disabled (DEV ONLY)

**Đã tạo sẵn script:** `run_web_dev.bat`

```bash
# Double-click file run_web_dev.bat
# Hoặc chạy trong terminal:
run_web_dev.bat
```

**Hoặc chạy lệnh trực tiếp:**

```bash
flutter run -d chrome ^
  --web-browser-flag "--disable-web-security" ^
  --web-browser-flag "--user-data-dir=%TEMP%\flutter_chrome_dev"
```

⚠️ **CẢNH BÁO:**
- CHỈ dùng cho development
- KHÔNG dùng Chrome này để duyệt web bình thường
- KHÔNG đăng nhập vào các tài khoản quan trọng
- Chrome sẽ hiện cảnh báo "You are using an unsupported command-line flag"

✅ **Ưu điểm:** Test nhanh trên web  
❌ **Nhược điểm:** Không an toàn, chỉ dùng dev

---

### 🥉 Cách 3: Dùng CORS Proxy (Production-ready)

Tạo proxy server trung gian. Có 2 lựa chọn:

#### 3.1. Dùng Public CORS Proxy (Tạm thời)

**KHÔNG khuyến nghị cho production** vì:
- Proxy có thể down bất cứ lúc nào
- Có thể đọc được data của bạn
- Có rate limit

```dart
// Trong lib/app/env.dart
static const String apiBaseUrl = 'https://corsproxy.io/?https://hungyentourism.com.vn/api/home.asmx';
```

#### 3.2. Tự Build Proxy Server (KHUYẾN NGHỊ)

**Option A: Node.js Express Proxy**

```javascript
// proxy-server.js
const express = require('express');
const cors = require('cors');
const { createProxyMiddleware } = require('http-proxy-middleware');

const app = express();
app.use(cors());

app.use('/api', createProxyMiddleware({
  target: 'https://hungyentourism.com.vn',
  changeOrigin: true,
  secure: true,
}));

app.listen(3000, () => {
  console.log('Proxy running on http://localhost:3000');
});
```

Chạy:
```bash
npm init -y
npm install express cors http-proxy-middleware
node proxy-server.js
```

Trong Flutter:
```dart
// lib/app/env.dart
static const String apiBaseUrl = 'http://localhost:3000/api/home.asmx';
```

**Option B: Cloudflare Workers (Free, Production-ready)**

1. Tạo Worker tại: https://workers.cloudflare.com
2. Code:
```javascript
addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request));
});

async function handleRequest(request) {
  const url = new URL(request.url);
  const targetUrl = 'https://hungyentourism.com.vn' + url.pathname + url.search;
  
  const response = await fetch(targetUrl, {
    method: request.method,
    headers: request.headers,
    body: request.body,
  });
  
  const newHeaders = new Headers(response.headers);
  newHeaders.set('Access-Control-Allow-Origin', '*');
  newHeaders.set('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  newHeaders.set('Access-Control-Allow-Headers', '*');
  
  return new Response(response.body, {
    status: response.status,
    statusText: response.statusText,
    headers: newHeaders,
  });
}
```

---

### 🏆 Cách 4: Liên Hệ Server Để Add CORS Header (BEST FOR PRODUCTION)

Liên hệ admin của `hungyentourism.com.vn` để thêm vào `web.config`:

```xml
<system.webServer>
  <httpProtocol>
    <customHeaders>
      <add name="Access-Control-Allow-Origin" value="*" />
      <add name="Access-Control-Allow-Methods" value="GET, POST, OPTIONS" />
      <add name="Access-Control-Allow-Headers" value="Content-Type, SOAPAction" />
    </customHeaders>
  </httpProtocol>
</system.webServer>
```

✅ **Ưu điểm:** Giải pháp tốt nhất, production-ready  
❌ **Nhược điểm:** Cần quyền admin server

---

## 🚀 Khuyến Nghị

### Cho Development:
1. **Test feature mới:** Chạy `run_web_dev.bat` (Cách 2)
2. **Test trên thiết bị thật:** Chạy `flutter run -d android` (Cách 1)

### Cho Production:
1. **Mobile App:** Build APK/IPA, không có vấn đề CORS
2. **Web App:** Build proxy server (Cách 3.2) hoặc liên hệ server add CORS (Cách 4)

---

## 🧪 Test Sau Khi Fix

### 1. Mở DevTools (F12)
- Tab **Network** → Check API request có thành công không
- Tab **Console** → Không còn lỗi CORS

### 2. Test API Calls
- ✅ Home screen load banner
- ✅ News screen load tin tức
- ✅ Places screen load địa điểm

### 3. Verify Response
```javascript
// Trong Console của Chrome:
fetch('https://hungyentourism.com.vn/api/home.asmx/Lay_ds_tintuc', {
  method: 'POST',
  headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
  body: 'page=1&pagesize=10&uservn=VNPT@manhbeo123&passvn=Manhbeo@123@9897'
}).then(r => r.text()).then(console.log);
```

---

## 📊 So Sánh Các Cách

| Cách | Độ Khó | An Toàn | Production | Tốc Độ |
|------|--------|---------|------------|--------|
| 1. Mobile/Desktop | ⭐ | ✅ | ✅ | ⚡⚡⚡ |
| 2. Chrome no-CORS | ⭐ | ❌ | ❌ | ⚡⚡⚡ |
| 3.1. Public Proxy | ⭐ | ⚠️ | ❌ | ⚡ |
| 3.2. Self Proxy | ⭐⭐⭐ | ✅ | ✅ | ⚡⚡ |
| 4. Server CORS | ⭐⭐ | ✅ | ✅ | ⚡⚡⚡ |

---

## 🎯 Quick Action Cho Bạn

**Nếu chỉ muốn test nhanh:**
```bash
# Double-click file:
run_web_dev.bat
```

**Nếu muốn chạy production-ready:**
```bash
# Test trên Android
flutter run -d android

# Hoặc Windows
flutter run -d windows
```

**Build APK để cài lên điện thoại:**
```bash
flutter build apk --release
# File APK ở: build/app/outputs/flutter-apk/app-release.apk
```

---

## 📚 Tham Khảo

- Flutter Web CORS: https://docs.flutter.dev/development/platform-integration/web/web-images
- MDN CORS: https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS
- Chrome Flags: https://peter.sh/experiments/chromium-command-line-switches/

---

**Tóm lại:** Lỗi CORS không phải lỗi code, mà là chính sách bảo mật. Cách tốt nhất là **chạy trên mobile/desktop** hoặc dùng **`run_web_dev.bat`** cho development. 🚀
