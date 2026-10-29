# 🚀 Hướng Dẫn Đẩy Project Lên GitHub

## Bước 1: Tạo Repository Trên GitHub

1. Truy cập: https://github.com/new
2. Điền thông tin:
   - **Repository name**: `hungyen-tourism-app`
   - **Description**: `Ứng dụng du lịch Hưng Yên - Flutter Mobile App`
   - **Visibility**: Chọn **Public** hoặc **Private**
   - **KHÔNG** tick vào "Add a README file" (vì đã có sẵn)
   - **KHÔNG** tick vào "Add .gitignore" (vì đã có sẵn)
3. Click **"Create repository"**

## Bước 2: Setup Git Local (Nếu Chưa Có)

### Kiểm tra Git đã cài chưa:

```bash
git --version
```

Nếu chưa có, download tại: https://git-scm.com/downloads

### Cấu hình Git (lần đầu):

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## Bước 3: Initialize Git Repository

Mở Terminal/Command Prompt tại thư mục project (`d:\VNPT\DuLichMobile`):

```bash
# 1. Initialize git repository
git init

# 2. Add all files
git add .

# 3. Commit
git commit -m "Initial commit: Hungyen Tourism App"

# 4. Rename branch to main (nếu cần)
git branch -M main
```

## Bước 4: Connect Với GitHub Repository

**Thay `YOUR_USERNAME` bằng username GitHub của bạn:**

```bash
# Add remote repository
git remote add origin https://github.com/YOUR_USERNAME/hungyen-tourism-app.git

# Verify remote
git remote -v
```

## Bước 5: Push Code Lên GitHub

```bash
# Push code lên GitHub
git push -u origin main
```

**Nếu yêu cầu đăng nhập:**
- Username: GitHub username của bạn
- Password: **Personal Access Token** (KHÔNG phải password GitHub)

### Tạo Personal Access Token:

1. Vào: https://github.com/settings/tokens
2. Click **"Generate new token"** → **"Generate new token (classic)"**
3. Điền:
   - **Note**: `Hungyen Tourism App`
   - **Expiration**: Chọn thời hạn
   - **Scopes**: Tick vào **`repo`** (full control)
4. Click **"Generate token"**
5. **Copy token** (chỉ hiện 1 lần, lưu lại!)
6. Dùng token này làm password khi push

## Bước 6: Verify Trên GitHub

1. Truy cập: `https://github.com/YOUR_USERNAME/hungyen-tourism-app`
2. Kiểm tra:
   - ✅ Tất cả files đã được push
   - ✅ README.md hiển thị đẹp
   - ✅ Có .gitignore
   - ✅ Có API_ANALYSIS.md và HUONG_DAN_CHAY_PROJECT.md

## 🎯 Quick Commands Reference

### Các lệnh Git thường dùng:

```bash
# Check status
git status

# Add files
git add .
git add <file_name>

# Commit
git commit -m "Your message"

# Push
git push

# Pull (lấy code mới từ GitHub)
git pull

# Check branches
git branch

# Create new branch
git checkout -b feature/new-feature

# Switch branch
git checkout main

# Merge branch
git merge feature/new-feature

# View commit history
git log
git log --oneline

# Undo changes (chưa commit)
git checkout -- <file_name>

# Undo last commit (giữ changes)
git reset --soft HEAD~1

# View remote
git remote -v
```

## 🔄 Workflow Sau Này

Khi có thay đổi code:

```bash
# 1. Check status
git status

# 2. Add changes
git add .

# 3. Commit with message
git commit -m "Add: new feature XYZ"

# 4. Push to GitHub
git push
```

## 📝 Commit Message Convention

Nên dùng format:

```
<type>: <description>

Types:
- feat: Thêm feature mới
- fix: Sửa bug
- docs: Cập nhật documentation
- style: Format code (không ảnh hưởng logic)
- refactor: Refactor code
- test: Thêm tests
- chore: Cập nhật build, dependencies
```

**Ví dụ:**
```bash
git commit -m "feat: add place detail screen"
git commit -m "fix: resolve API connection issue"
git commit -m "docs: update README with screenshots"
```

## 🌿 Branching Strategy (Nâng Cao)

```bash
# Main branch: production code
main

# Development branch
git checkout -b develop

# Feature branches
git checkout -b feature/home-screen
git checkout -b feature/place-list

# Bug fix branches
git checkout -b fix/api-error

# Merge về develop
git checkout develop
git merge feature/home-screen

# Merge develop về main (khi release)
git checkout main
git merge develop
```

## 🚨 Troubleshooting

### 1. "fatal: remote origin already exists"

```bash
git remote remove origin
git remote add origin https://github.com/YOUR_USERNAME/hungyen-tourism-app.git
```

### 2. "failed to push some refs"

```bash
# Pull trước, sau đó push
git pull origin main --rebase
git push origin main
```

### 3. "Permission denied"

- Check Personal Access Token
- Hoặc dùng SSH key: https://docs.github.com/en/authentication/connecting-to-github-with-ssh

### 4. "Large files detected"

```bash
# Remove file from git
git rm --cached <large_file>

# Add to .gitignore
echo "<large_file>" >> .gitignore

# Commit
git commit -m "Remove large file"
```

### 5. Quên add .gitignore trước khi commit

```bash
# Remove cached files
git rm -r --cached .

# Add all again
git add .

# Commit
git commit -m "Update .gitignore"
```

## 📦 Files Đã Được Ignore

Các files/folders sau KHÔNG được push lên GitHub (theo .gitignore):

- `build/` - Build artifacts
- `.dart_tool/` - Dart tools
- `.packages` - Package cache
- `*.iml`, `.idea/` - IDE files
- `android/app/debug`, `android/app/release` - Android builds
- `ios/Pods/` - iOS dependencies
- `.env` - Environment variables
- `**/api_keys.dart`, `**/secrets.dart` - API keys

## 🔐 Bảo Mật

**⚠️ QUAN TRỌNG:**

1. **KHÔNG** commit API keys, passwords vào Git
2. Dùng `.env` file cho sensitive data
3. Add `.env` vào `.gitignore`
4. Dùng GitHub Secrets cho CI/CD

## 📞 Hỗ Trợ

- GitHub Docs: https://docs.github.com
- Git Docs: https://git-scm.com/doc
- GitHub Desktop (GUI): https://desktop.github.com

---

**Chúc bạn thành công! 🎉**

Sau khi push xong, share link GitHub repo để mọi người có thể clone và contribute!
