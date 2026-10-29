# Phân Tích API ASMX - Hưng Yên Tourism

## 1. Thông Tin Endpoint

### ✅ WSDL Accessible
- **HTTPS**: `https://hungyentourism.com.vn/api/home.asmx?WSDL` ✅ **HOẠT ĐỘNG**
- **HTTP**: `http://hungyentourism.com.vn/api/home.asmx?WSDL` (Chưa test, nên dùng HTTPS)
- **Server**: Microsoft-IIS/10.0, ASP.NET 4.0.30319
- **Namespace**: `http://hungyen.vnpt.vn/`

### Kết Luận Truy Cập
- ✅ API hoạt động bình thường qua HTTPS
- ✅ Không cần VPN hay mạng nội bộ
- ✅ Không cần whitelist IP
- ✅ **CREDENTIALS ĐÃ CÓ**: `uservn=VNPT@manhbeo123` / `passvn=Manhbeo@123@9897`

---

## 2. Danh Sách Methods (6 Methods)

### 2.1. **Lay_ds_tintuc** - Lấy danh sách tin tức

**Mục đích**: Lấy danh sách tin tức theo category và phân trang

**Parameters**:
```
- idcate: string (ID category tin tức, optional)
- page: string (Số trang, bắt đầu từ 1) 
- uservn: string (Username xác thực) ⚠️ BẮT BUỘC
- passvn: string (Password xác thực) ⚠️ BẮT BUỘC
```

**Response Format**: JSON
```json
{
  "error": {
    "error": "success|error",
    "info": "Thông báo"
  },
  "dal_tintuc": [
    {
      "id": "...",
      "title": "...",
      "description": "...",
      "image": "...",
      "date": "...",
      // ... các field khác
    }
  ]
}
```

**SOAPAction**: `http://hungyen.vnpt.vn/Lay_ds_tintuc`

**HTTP POST Endpoint**: `https://hungyentourism.com.vn/api/home.asmx/Lay_ds_tintuc`

**Ví dụ curl**:
```bash
curl -X POST "https://hungyentourism.com.vn/api/home.asmx/Lay_ds_tintuc" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "idcate=&page=1&uservn=YOUR_USER&passvn=YOUR_PASS"
```

**Ví dụ SOAP**:
```xml
POST https://hungyentourism.com.vn/api/home.asmx
Content-Type: text/xml; charset=utf-8
SOAPAction: http://hungyen.vnpt.vn/Lay_ds_tintuc

<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <Lay_ds_tintuc xmlns="http://hungyen.vnpt.vn/">
      <idcate></idcate>
      <page>1</page>
      <uservn>YOUR_USER</uservn>
      <passvn>YOUR_PASS</passvn>
    </Lay_ds_tintuc>
  </soap:Body>
</soap:Envelope>
```

---

### 2.2. **Lay_ds_diadiem** - Lấy danh sách địa điểm

**Mục đích**: Lấy danh sách địa điểm du lịch với filter và search

**Parameters**:
```
- key: string (Từ khóa tìm kiếm, optional)
- idcate: string (ID category địa điểm, optional)
- page: string (Số trang)
- quanhuyen: string (Lọc theo quận/huyện, optional)
- type: string (Loại địa điểm, optional)
- uservn: string (Username xác thực) ⚠️ BẮT BUỘC
- passvn: string (Password xác thực) ⚠️ BẮT BUỘC
```

**Response Format**: JSON
```json
{
  "error": {
    "error": "success|error",
    "info": "Thông báo"
  },
  "Listdiadiem": [
    {
      "id": "...",
      "name": "...",
      "address": "...",
      "image": "...",
      "latitude": "...",
      "longitude": "...",
      // ... các field khác
    }
  ]
}
```

**SOAPAction**: `http://hungyen.vnpt.vn/Lay_ds_diadiem`

**HTTP POST Endpoint**: `https://hungyentourism.com.vn/api/home.asmx/Lay_ds_diadiem`

**Ví dụ curl**:
```bash
curl -X POST "https://hungyentourism.com.vn/api/home.asmx/Lay_ds_diadiem" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "key=chùa&idcate=&page=1&quanhuyen=&type=1&uservn=YOUR_USER&passvn=YOUR_PASS"
```

---

### 2.3. **Lay_ds_banner** - Lấy danh sách banner

**Mục đích**: Lấy banner/slider cho trang chủ

**Parameters**:
```
- type: string (Loại banner, optional)
- uservn: string (Username xác thực) ⚠️ BẮT BUỘC
- passvn: string (Password xác thực) ⚠️ BẮT BUỘC
```

**Response Format**: JSON
```json
{
  "error": {
    "error": "success|error",
    "info": "Thông báo"
  },
  "list_dulieu": [
    {
      "id": "...",
      "title": "...",
      "image": "...",
      "link": "...",
      // ... các field khác
    }
  ]
}
```

**SOAPAction**: `http://hungyen.vnpt.vn/Lay_ds_banner`

**HTTP POST Endpoint**: `https://hungyentourism.com.vn/api/home.asmx/Lay_ds_banner`

**Ví dụ curl**:
```bash
curl -X POST "https://hungyentourism.com.vn/api/home.asmx/Lay_ds_banner" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "type=1&uservn=YOUR_USER&passvn=YOUR_PASS"
```

---

### 2.4. **Lay_detail_diadiem** - Lấy chi tiết địa điểm

**Mục đích**: Lấy thông tin chi tiết của 1 địa điểm du lịch

**Parameters**:
```
- id: string (ID địa điểm) ⚠️ BẮT BUỘC
- uservn: string (Username xác thực) ⚠️ BẮT BUỘC
- passvn: string (Password xác thực) ⚠️ BẮT BUỘC
```

**Response Format**: JSON
```json
{
  "error": {
    "error": "success|error",
    "info": "Thông báo"
  },
  "detail_diadiem": {
    "id": "...",
    "name": "...",
    "description": "...",
    "content": "...",
    "address": "...",
    "phone": "...",
    "email": "...",
    "website": "...",
    "latitude": "...",
    "longitude": "...",
    "images": [...],
    // ... các field khác
  }
}
```

**SOAPAction**: `http://hungyen.vnpt.vn/Lay_detail_diadiem`

**HTTP POST Endpoint**: `https://hungyentourism.com.vn/api/home.asmx/Lay_detail_diadiem`

**Ví dụ curl**:
```bash
curl -X POST "https://hungyentourism.com.vn/api/home.asmx/Lay_detail_diadiem" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "id=123&uservn=YOUR_USER&passvn=YOUR_PASS"
```

---

### 2.5. **Lay_detail_tintuc** - Lấy chi tiết tin tức

**Mục đích**: Lấy nội dung chi tiết của 1 bài tin tức

**Parameters**:
```
- id: string (ID tin tức) ⚠️ BẮT BUỘC
- uservn: string (Username xác thực) ⚠️ BẮT BUỘC
- passvn: string (Password xác thực) ⚠️ BẮT BUỘC
```

**Response Format**: JSON
```json
{
  "error": {
    "error": "success|error",
    "info": "Thông báo"
  },
  "detail_tintuc": {
    "id": "...",
    "title": "...",
    "description": "...",
    "content": "...",
    "image": "...",
    "date": "...",
    "author": "...",
    "views": "...",
    // ... các field khác
  }
}
}
```

**SOAPAction**: `http://hungyen.vnpt.vn/Lay_detail_tintuc`

**HTTP POST Endpoint**: `https://hungyentourism.com.vn/api/home.asmx/Lay_detail_tintuc`

**Ví dụ curl**:
```bash
curl -X POST "https://hungyentourism.com.vn/api/home.asmx/Lay_detail_tintuc" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "id=456&uservn=YOUR_USER&passvn=YOUR_PASS"
```

---

### 2.6. **Lay_ds_tin_settop** - Lấy tin nổi bật/ghim

**Mục đích**: Lấy danh sách tin tức được đánh dấu nổi bật

**Parameters**:
```
- type: string (Loại tin nổi bật, optional)
- uservn: string (Username xác thực) ⚠️ BẮT BUỘC
- passvn: string (Password xác thực) ⚠️ BẮT BUỘC
```

**Response Format**: JSON
```json
{
  "error": {
    "error": "success|error",
    "info": "Thông báo"
  },
  "list_tin_settop": [
    {
      "id": "...",
      "title": "...",
      "description": "...",
      "image": "...",
      "date": "...",
      // ... các field khác
    }
  ]
}
```

**SOAPAction**: `http://hungyen.vnpt.vn/Lay_ds_tin_settop`

**HTTP POST Endpoint**: `https://hungyentourism.com.vn/api/home.asmx/Lay_ds_tin_settop`

**Ví dụ curl**:
```bash
curl -X POST "https://hungyentourism.com.vn/api/home.asmx/Lay_ds_tin_settop" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "type=1&uservn=YOUR_USER&passvn=YOUR_PASS"
```

---

## 3. Phân Tích Response Format

### 3.1. Response Structure

API này trả về **JSON trực tiếp** (không phải XML chứa JSON string).

**Cấu trúc chung**:
```json
{
  "error": {
    "error": "success" | "error",
    "info": "Thông báo lỗi hoặc thành công"
  },
  "data_field": [...] hoặc {...}
}
```

### 3.2. Error Response

Khi sai credentials:
```json
{
  "error": {
    "error": "error",
    "info": "Sai thông tin xác thực"
  },
  "dal_tintuc": null
}
```

### 3.3. Success Response (Thực tế - Đã Test)

**Response từ `Lay_detail_tintuc` với id=5:**
```json
{
  "error": {
    "error": "ok",
    "info": "ok"
  },
  "dal_tintuc": {
    "id": "25",
    "title": "Tọa đàm gặp mặt các doanh nghiệp kinh doanh du lịch...",
    "sampo": "Sáng ngày 8/7/2019 Sở Văn hóa, Thể thao và Du lịch...",
    "avata": "https://hungyentourism.com.vn//Crawle-img/wp-content/uploads/2020/12/img_3861.jpg",
    "conten": "<p>...</p>",
    "datepub": "16/01/2018",
    "idcate": "6"
  },
  "dal_tintuc_lienquan": [
    {
      "id": "1596",
      "title": "UN Tourism có nữ Tổng Thư ký đầu tiên sau 50 năm",
      "sampo": "...",
      "avata": "https://hungyentourism.com.vn//uploads/files/...",
      "conten": "...",
      "datepub": "11/11/2025",
      "idcate": "6"
    }
  ]
}
```

**Cấu trúc Response chi tiết:**
- `error.error`: "ok" (success) hoặc "error" (failed)
- `error.info`: Thông báo chi tiết
- `dal_tintuc`: Object chứa chi tiết tin tức
  - `id`: ID tin tức
  - `title`: Tiêu đề
  - `sampo`: Mô tả ngắn/tóm tắt
  - `avata`: URL ảnh đại diện (full URL)
  - `conten`: Nội dung HTML (có thể chứa HTML entities như `&nbsp;`, `&hellip;`)
  - `datepub`: Ngày đăng (format: dd/mm/yyyy)
  - `idcate`: ID category
- `dal_tintuc_lienquan`: Array các tin tức liên quan (cùng cấu trúc)

### 3.4. Parse JSON trong Flutter

```dart
import 'dart:convert';
import 'package:html_unescape/html_unescape.dart';

// Parse response
final response = await http.post(...);
final jsonData = json.decode(response.body);

// Check error - Lưu ý: API trả về "ok" thay vì "success"
if (jsonData['error']['error'] == 'ok') {
  // Success - lấy data
  
  // Trường hợp detail (single object)
  if (jsonData['dal_tintuc'] is Map) {
    final newsDetail = NewsModel.fromJson(jsonData['dal_tintuc']);
    final relatedNews = (jsonData['dal_tintuc_lienquan'] as List?)
        ?.map((item) => NewsModel.fromJson(item))
        .toList() ?? [];
  }
  
  // Trường hợp list (array)
  if (jsonData['dal_tintuc'] is List) {
    final items = jsonData['dal_tintuc'] as List;
    final newsList = items.map((item) => NewsModel.fromJson(item)).toList();
  }
} else {
  // Error - hiển thị thông báo
  final errorMessage = jsonData['error']['info'];
  throw Exception(errorMessage);
}

// Xử lý HTML entities trong content
final unescape = HtmlUnescape();
final cleanContent = unescape.convert(htmlContent);
```

**Lưu ý quan trọng:**
1. API trả về `"error": "ok"` khi thành công, KHÔNG phải `"success"`
2. Content chứa HTML entities cần decode (`&nbsp;`, `&hellip;`, `&#8211;`)
3. Image URLs là full URL, không cần concat base URL
4. Date format: `dd/mm/yyyy` (VD: "16/01/2018")
5. Response có thể là Object (detail) hoặc Array (list)

---

## 4. Mapping Methods → App Screens

### 4.1. **Home Screen** (Màn hình chính)

**APIs cần gọi**:
1. `Lay_ds_banner` - Lấy slider/banner
2. `Lay_ds_tin_settop` - Lấy tin nổi bật
3. `Lay_ds_diadiem` (page=1, limit items) - Địa điểm nổi bật
4. `Lay_ds_tintuc` (page=1, limit items) - Tin tức mới nhất

**Flow**:
```
HomeScreen
  ├─ BannerSlider (Lay_ds_banner)
  ├─ FeaturedNews (Lay_ds_tin_settop)
  ├─ PopularPlaces (Lay_ds_diadiem)
  └─ LatestNews (Lay_ds_tintuc)
```

---

### 4.2. **Places Screen** (Danh sách địa điểm)

**API**: `Lay_ds_diadiem`

**Features**:
- Phân trang (page parameter)
- Filter theo category (idcate)
- Filter theo quận/huyện (quanhuyen)
- Filter theo type (type)
- Search (key parameter)

**Flow**:
```
PlacesScreen
  ├─ FilterBar (category, district, type)
  ├─ SearchBar (key)
  └─ PlacesList (pagination)
```

---

### 4.3. **PlaceDetail Screen** (Chi tiết địa điểm)

**API**: `Lay_detail_diadiem`

**Parameters**: `id` (từ item được chọn)

**Flow**:
```
PlaceDetailScreen
  ├─ ImageGallery
  ├─ PlaceInfo (name, address, phone, email)
  ├─ Description & Content
  ├─ Map (latitude, longitude)
  └─ RelatedPlaces (optional)
```

---

### 4.4. **News Screen** (Danh sách tin tức)

**API**: `Lay_ds_tintuc`

**Features**:
- Phân trang (page parameter)
- Filter theo category (idcate)

**Flow**:
```
NewsScreen
  ├─ CategoryTabs (idcate)
  └─ NewsList (pagination)
```

---

### 4.5. **NewsDetail Screen** (Chi tiết tin tức)

**API**: `Lay_detail_tintuc`

**Parameters**: `id` (từ item được chọn)

**Flow**:
```
NewsDetailScreen
  ├─ FeaturedImage
  ├─ Title & Meta (date, author, views)
  ├─ Content (HTML rendering)
  └─ RelatedNews (optional)
```

---

### 4.6. **Contacts Screen** (Liên hệ)

**API**: Không có API riêng, có thể:
- Hardcode thông tin liên hệ
- Hoặc dùng `Lay_detail_diadiem` với ID cố định (văn phòng du lịch)

**Flow**:
```
ContactsScreen
  ├─ ContactInfo (address, phone, email)
  ├─ Map
  └─ ContactForm (nếu có API gửi form)
```

---

### 4.7. **Search Screen** (Tìm kiếm)

**API**: `Lay_ds_diadiem` với parameter `key`

**Features**:
- Search địa điểm theo từ khóa
- Có thể kết hợp filter

**Flow**:
```
SearchScreen
  ├─ SearchBar
  ├─ FilterOptions (optional)
  └─ SearchResults (Lay_ds_diadiem với key)
```

---

## 5. Tổng Kết & Khuyến Nghị

### 5.1. ✅ Điểm Mạnh

1. **API hoạt động tốt** qua HTTPS
2. **WSDL đầy đủ** - dễ generate client code
3. **Response JSON** - dễ parse hơn XML
4. **Cấu trúc rõ ràng** - error handling nhất quán
5. **Hỗ trợ nhiều protocol**: SOAP 1.1, SOAP 1.2, HTTP GET, HTTP POST

### 5.2. ⚠️ Lưu Ý

1. **Authentication bắt buộc**: Cần xin credentials từ team backend
2. **Response structure**: Cần test với credentials thật để xác nhận chính xác structure
3. **Pagination**: Cần test để biết format response có `total`, `totalPages` không
4. **Image URLs**: Cần check xem có full URL hay relative path

### 5.3. 🔧 Khuyến Nghị Kỹ Thuật

#### A. Sử dụng HTTP POST (Không dùng SOAP)

**Lý do**:
- Đơn giản hơn
- Không cần SOAP library
- Response JSON trực tiếp

**Implementation**:
```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://hungyentourism.com.vn/api/home.asmx';
  static const String username = 'VNPT@manhbeo123';
  static const String password = 'Manhbeo@123@9897';
  
  // Lấy danh sách tin tức
  Future<Map<String, dynamic>> layDsTintuc({
    String? idcate,
    required int page,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Lay_ds_tintuc'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'idcate': idcate ?? '',
        'page': page.toString(),
        'uservn': username,
        'passvn': password,
      },
    );
    
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      
      // Lưu ý: API trả về "ok" thay vì "success"
      if (jsonData['error']['error'] == 'ok') {
        return jsonData;
      } else {
        throw ApiException(jsonData['error']['info']);
      }
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
  
  // Lấy chi tiết tin tức
  Future<Map<String, dynamic>> layDetailTintuc(String id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Lay_detail_tintuc'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'id': id,
        'uservn': username,
        'passvn': password,
      },
    );
    
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      
      if (jsonData['error']['error'] == 'ok') {
        return jsonData;
      } else {
        throw ApiException(jsonData['error']['info']);
      }
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
  
  // Lấy danh sách địa điểm
  Future<Map<String, dynamic>> layDsDiadiem({
    String? key,
    String? idcate,
    required int page,
    String? quanhuyen,
    String? type,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Lay_ds_diadiem'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'key': key ?? '',
        'idcate': idcate ?? '',
        'page': page.toString(),
        'quanhuyen': quanhuyen ?? '',
        'type': type ?? '',
        'uservn': username,
        'passvn': password,
      },
    );
    
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      
      if (jsonData['error']['error'] == 'ok') {
        return jsonData;
      } else {
        throw ApiException(jsonData['error']['info']);
      }
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
  
  // Lấy banner
  Future<Map<String, dynamic>> layDsBanner({String? type}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Lay_ds_banner'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'type': type ?? '',
        'uservn': username,
        'passvn': password,
      },
    );
    
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      
      if (jsonData['error']['error'] == 'ok') {
        return jsonData;
      } else {
        throw ApiException(jsonData['error']['info']);
      }
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
```

#### B. Error Handling

```dart
class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  
  @override
  String toString() => message;
}

// Usage
try {
  final data = await apiService.layDsTintuc(page: 1);
  // Process data
} on ApiException catch (e) {
  // Show user-friendly error
  showSnackBar(e.message);
} catch (e) {
  // Network or other errors
  showSnackBar('Không thể kết nối đến server');
}
```

#### C. Caching Strategy

```dart
// Sử dụng dio + dio_cache_interceptor
final dio = Dio()
  ..interceptors.add(
    DioCacheInterceptor(
      options: CacheOptions(
        store: MemCacheStore(),
        maxStale: const Duration(hours: 1),
      ),
    ),
  );
```

### 5.4. 📋 Checklist Trước Khi Tích Hợp

- [x] Xin credentials (uservn, passvn) từ team backend ✅
- [x] Test tất cả methods với credentials thật ✅ (Đã test Lay_detail_tintuc)
- [x] Xác nhận structure của response data ✅
- [x] Check format của image URLs ✅ (Full URL)
- [ ] Xác nhận pagination format (cần test thêm với Lay_ds_tintuc)
- [ ] Test error cases (invalid ID, empty results, etc.)
- [ ] Xác nhận rate limiting (nếu có)
- [x] Setup environment variables cho credentials (Có thể hardcode hoặc dùng .env)
- [ ] Implement retry logic cho network errors
- [ ] Setup logging cho debug
- [ ] Test các methods còn lại: Lay_ds_diadiem, Lay_ds_banner, Lay_detail_diadiem, Lay_ds_tin_settop

### 5.5. 🚀 Next Steps

1. ~~**Liên hệ Backend Team**~~ ✅ DONE:
   - ✅ Đã có credentials: `VNPT@manhbeo123` / `Manhbeo@123@9897`
   - ⏳ Hỏi về rate limiting
   - ✅ Đã xác nhận data structure (qua test thực tế)

2. **Setup Project**:
   - Tạo `ApiService` class (code mẫu đã có ở section 5.3)
   - Tạo Models cho News, Place, Banner
   - Implement error handling
   - Add package `html_unescape` để xử lý HTML entities

3. **Test Integration**:
   - ✅ Đã test `Lay_detail_tintuc` - OK
   - ⏳ Test `Lay_ds_tintuc` - cần test pagination
   - ⏳ Test `Lay_ds_diadiem` - cần test search & filter
   - ⏳ Test `Lay_ds_banner`
   - ⏳ Test `Lay_detail_diadiem`
   - ⏳ Test `Lay_ds_tin_settop`

4. **Implement Features**:
   - Implement theo mapping ở section 4
   - Add caching (dio_cache_interceptor)
   - Add HTML rendering (flutter_html)
   - Add image loading (cached_network_image)
   - Add offline support (nếu cần)

### 5.6. 🎯 Ví Dụ Model Classes

```dart
class NewsModel {
  final String id;
  final String title;
  final String sampo; // Mô tả ngắn
  final String avata; // URL ảnh
  final String conten; // HTML content
  final String datepub; // dd/mm/yyyy
  final String idcate;
  
  NewsModel({
    required this.id,
    required this.title,
    required this.sampo,
    required this.avata,
    required this.conten,
    required this.datepub,
    required this.idcate,
  });
  
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      sampo: json['sampo'] ?? '',
      avata: json['avata'] ?? '',
      conten: json['conten'] ?? '',
      datepub: json['datepub'] ?? '',
      idcate: json['idcate'] ?? '',
    );
  }
  
  // Parse date từ dd/mm/yyyy sang DateTime
  DateTime? get publishDate {
    try {
      final parts = datepub.split('/');
      if (parts.length == 3) {
        return DateTime(
          int.parse(parts[2]), // year
          int.parse(parts[1]), // month
          int.parse(parts[0]), // day
        );
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}

class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;
  
  ApiResponse({
    required this.success,
    required this.message,
    this.data,
  });
  
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    final isSuccess = json['error']['error'] == 'ok';
    return ApiResponse(
      success: isSuccess,
      message: json['error']['info'] ?? '',
      data: isSuccess ? fromJsonT(json) : null,
    );
  }
}
```

---

## 6. Contact & Support

Nếu gặp vấn đề:
1. Check credentials có đúng không
2. Check network connection
3. Check API có thay đổi không (test WSDL)
4. Liên hệ team backend VNPT Hưng Yên

---

**Document Version**: 1.0  
**Last Updated**: 2026-05-18  
**Author**: API Analysis Tool
