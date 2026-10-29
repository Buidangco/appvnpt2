# Test Flutter Web bằng local proxy (Cach 2)

## 1) Chạy proxy
Mở terminal 1 tại root project:

```powershell
.\run_proxy.bat
```

Proxy sẽ chạy ở:
- `http://localhost:8787`
- Health check: `http://localhost:8787/health`

## 2) Chạy Flutter Web qua proxy
Mở terminal 2 tại root project:

```powershell
.\run_web_proxy.bat
```

Lệnh này tương đương:

```powershell
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:8787/api/home.asmx
```

## 3) Kiểm tra nhanh endpoint tin tức
Có thể test trong terminal:

```powershell
curl -X POST "http://localhost:8787/api/home.asmx/Lay_ds_tintuc" ^
  -H "Content-Type: application/x-www-form-urlencoded" ^
  -d "idcate=5&page=1&uservn=VNPT@manhbeo123&passvn=Manhbeo@123@9897"
```

## Ghi chú
- Cách này dùng cho local dev/test Web.
- Không expose credentials lên production frontend.
- Production nên có backend thật, quản lý auth/secret ở server.
