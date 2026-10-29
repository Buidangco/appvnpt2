# 🚀 START HERE - Chạy App Với Proxy

## ✅ Đã Sửa Xong

1. ✅ Proxy server đã được fix để parse XML → JSON đúng
2. ✅ File .bat đã được sửa (loại bỏ BOM)
3. ✅ Tạo script kill process cũ

---

## 🎯 3 Bước Đơn Giản

### Bước 1: Kill Proxy Cũ

```bash
.\kill_proxy.bat
```

**Kết quả:** Sẽ kill process đang dùng port 8787

---

### Bước 2: Start Proxy Mới

```bash
.\run_proxy.bat
```

**Kết quả:** 
```
Starting ASMX proxy on http://localhost:8787 ...
Proxy running at http://localhost:8787
Forwarding to https://hungyentourism.com.vn/api/home.asmx
```

⚠️ **Để terminal này chạy, KHÔNG đóng!**

---

### Bước 3: Test Proxy (Terminal Mới)

Mở terminal mới, chạy:

```bash
.\test_proxy_api.bat
```

**Kết quả mong đợi:** Thấy JSON data (không phải XML):

```json
{
  "data": [
    {
      "id": 123,
      "title": "Tin tức...",
      ...
    }
  ],
  "total": 50
}
```

✅ **Nếu thấy JSON** → Proxy hoạt động đúng!  
❌ **Nếu thấy XML hoặc lỗi** → Báo lại

---

## 🌐 Chạy Flutter Web (Terminal Thứ 3)

Sau khi proxy chạy OK, mở terminal thứ 3:

```bash
.\run_web_proxy.bat
```

Hoặc:

```bash
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:8787/api/home.asmx
```

**Kết quả:** App sẽ load data từ proxy:
- ✅ Banner hiển thị
- ✅ Tin tức hiển thị
- ✅ Địa điểm hiển thị

---

## 📊 Tóm Tắt

```
Terminal 1: .\kill_proxy.bat (chạy 1 lần)
Terminal 2: .\run_proxy.bat (để chạy)
Terminal 3: .\test_proxy_api.bat (test)
Terminal 4: .\run_web_proxy.bat (Flutter app)
```

---

## 🐛 Troubleshooting

### Lỗi: "Port 8787 đang được sử dụng"

```bash
.\kill_proxy.bat
```

Rồi chạy lại `.\run_proxy.bat`

### Lỗi: "curl không tìm thấy"

Dùng PowerShell thay vì CMD, hoặc cài curl:
```bash
winget install curl
```

### Proxy chạy nhưng app không load

1. Check proxy logs (terminal 2) xem có lỗi không
2. Check Flutter console xem có lỗi parse JSON không
3. Mở Chrome DevTools (F12) → Network tab → Xem response

### Vẫn thấy XML thay vì JSON

Proxy chưa được restart đúng cách:
1. Ctrl+C trong terminal proxy
2. Chạy `.\kill_proxy.bat`
3. Chạy `.\run_proxy.bat`

---

## 🎉 Sau Khi Chạy OK

Nếu mọi thứ hoạt động:

1. **Commit code:**
   ```bash
   git add .
   git commit -m "fix: proxy server now correctly parses ASMX XML to JSON"
   ```

2. **Push lên GitHub:**
   ```bash
   git push -u origin main
   ```

3. **Build APK để test trên điện thoại:**
   ```bash
   flutter build apk --release
   ```

---

**Chúc may mắn! 🚀**
