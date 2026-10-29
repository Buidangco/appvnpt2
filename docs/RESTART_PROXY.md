# 🔄 Restart Proxy Sau Khi Sửa Code

## Đã Sửa Gì?

**Vấn đề:** Proxy đang set `responseType: 'json'` nhưng ASMX API trả về **XML chứa JSON string**.

**Giải pháp:** Đã sửa `tools/proxy/server.js` để:
1. Nhận response dạng 'text' (XML)
2. Parse XML để extract JSON string bên trong `<string>...</string>`
3. Parse JSON string thành object
4. Trả về JSON object cho Flutter

---

## 🚀 Cách Restart Proxy

### Bước 1: Stop Proxy Hiện Tại

Trong terminal đang chạy proxy (terminal có dòng "Proxy running at http://localhost:8787"):

1. Nhấn **`Ctrl + C`**
2. Nếu hỏi "Terminate batch job (Y/N)?", nhấn **`Y`**

### Bước 2: Start Proxy Lại

```bash
.\run_proxy.bat
```

Hoặc:
```bash
cd tools\proxy
npm start
```

### Bước 3: Verify Proxy Hoạt Động

Mở browser hoặc dùng curl:

```bash
# Test health check
curl http://localhost:8787/health

# Kết quả mong đợi:
# {"ok":true,"service":"hungyen-asmx-proxy"}
```

### Bước 4: Test API Qua Proxy

```bash
curl -X POST "http://localhost:8787/api/home.asmx/Lay_ds_tintuc" ^
  -H "Content-Type: application/x-www-form-urlencoded" ^
  -d "idcate=5&page=1&pagesize=10&uservn=VNPT@manhbeo123&passvn=Manhbeo@123@9897"
```

**Kết quả mong đợi:** JSON object (không phải XML):
```json
{
  "data": [...],
  "total": 123
}
```

### Bước 5: Refresh Flutter App

Trong Flutter app (Chrome):
1. Nhấn **`r`** trong terminal Flutter để hot reload
2. Hoặc nhấn **`R`** để hot restart
3. Hoặc refresh browser (F5)

---

## ✅ Kiểm Tra Kết Quả

Sau khi restart proxy và refresh app:

- ✅ Home screen hiển thị banner
- ✅ Tin tức hiển thị danh sách
- ✅ Địa điểm hiển thị danh sách
- ✅ Không còn lỗi "Chưa có bài viết"

---

## 🐛 Nếu Vẫn Không Load

### 1. Check Proxy Logs

Trong terminal proxy, xem có lỗi gì không:
- ✅ Nên thấy: `POST /api/home.asmx/Lay_ds_tintuc 200`
- ❌ Nếu thấy: `500` hoặc `502` → có lỗi

### 2. Check Flutter Console

Trong VS Code Debug Console:
- ✅ Nên thấy: `[REQ] POST http://localhost:8787/...`
- ✅ Nên thấy: `[RES] 200`
- ❌ Nếu thấy lỗi parse JSON → báo lại

### 3. Test Trực Tiếp API

```bash
# Test API gốc (không qua proxy)
curl -X POST "https://hungyentourism.com.vn/api/home.asmx/Lay_ds_tintuc" ^
  -H "Content-Type: application/x-www-form-urlencoded" ^
  -d "idcate=5&page=1&pagesize=10&uservn=VNPT@manhbeo123&passvn=Manhbeo@123@9897"
```

Nếu API gốc trả về XML có JSON bên trong → proxy sẽ parse được.

### 4. Check Network Tab

Mở Chrome DevTools (F12) → Tab Network:
1. Filter: `XHR`
2. Click vào request `Lay_ds_tintuc`
3. Tab **Response** → Xem response có phải JSON không

---

## 📝 Tóm Tắt

```bash
# 1. Stop proxy (Ctrl+C)
# 2. Start lại
.\run_proxy.bat

# 3. Trong terminal Flutter, hot reload
# Nhấn 'r' hoặc 'R'

# 4. Kiểm tra app có load data không
```

---

## 🎯 Quick Commands

```bash
# Terminal 1: Proxy
.\run_proxy.bat

# Terminal 2: Flutter Web
.\run_web_proxy.bat

# Hoặc chạy trực tiếp:
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:8787/api/home.asmx
```

---

**Lưu ý:** Sau khi sửa code proxy, PHẢI restart proxy thì mới có hiệu lực!
