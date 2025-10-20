# AI_generation_image_dukyoung
**덕영제 이미지 생성 웹 프로그램**

#AI 사진 변환기

OpenAI GPT-4 Vision과 DALL-E 3를 활용한 실시간 사진 스타일 변환 웹 애플리케이션입니다.

## 주요 기능

- **🖼️ 다양한 스타일 변환**: 지브리, 디즈니, 애니메, 사이버펑크, 판타지, 80년대, 호러, 코믹 스타일
- **📷 실시간 카메라 촬영**: 웹캠을 통한 즉석 사진 촬영 및 변환
- **📁 파일 업로드**: 드래그 앤 드롭으로 간편한 이미지 업로드
- **📧 이메일 전송**: 변환된 이미지를 이메일로 공유
- **📱 QR 코드 생성**: 작품 공유를 위한 QR 코드 생성 및 다운로드

## 기술 스택

### Backend
- **Node.js** + **Express.js**
- **OpenAI GPT-4 Vision API** - 이미지 분석
- **OpenAI DALL-E 3 API** - 스타일 변환 이미지 생성
- **Nodemailer** - 이메일 전송
- **QRCode** - QR 코드 생성
- **Multer** - 파일 업로드 처리

### Frontend
- **Vanilla JavaScript**
- **HTML5 Canvas** - 카메라 촬영
- **CSS3** - 그라데이션 UI 디자인
- **Drag & Drop API** - 파일 업로드

## 🚀 설치 및 실행

### 1. 저장소 클론
```bash
git clone https://github.com/choimj1717/AI_generation_image_dukyoung
cd DYAI
```

### 2. 의존성 설치
```bash
npm install
```

### 3. 환경 변수 설정
`.env` 파일을 생성하고 다음 내용을 추가하세요:

```env
OPENAI_API_KEY=your_openai_api_key_here
EMAIL_USER=your_gmail_address
EMAIL_PASS=your_gmail_app_password
PORT=3000
```

### 4. 애플리케이션 실행
```bash
# 프로덕션 모드
npm start

# 개발 모드 (nodemon)
npm run dev
```

### 5. 브라우저에서 접속
```
http://localhost:3000
```

## API 엔드포인트

### POST `/api/transform`
이미지를 선택한 스타일로 변환합니다.

**요청:**
- `image`: 업로드할 이미지 파일 (multipart/form-data)
- `style`: 변환 스타일 (ghibli, disney, anime, cyberpunk, fantasy, retro, horror, comic)

**응답:**
```json
{
  "success": true,
  "style": "ghibli",
  "originalDescription": "이미지 설명",
  "transformedImageUrl": "https://..."
}
```

### POST `/api/send-email`
변환된 이미지를 이메일로 전송합니다.

**요청:**
```json
{
  "email": "user@example.com",
  "imageUrl": "https://...",
  "style": "ghibli"
}
```

### POST `/api/generate-qr`
이미지 공유용 QR 코드를 생성합니다.

**요청:**
```json
{
  "imageUrl": "https://...",
  "style": "ghibli"
}
```

## 🎨 지원 스타일

| 스타일 | 설명 |
|--------|------|
| 🌿 **지브리** | 스튜디오 지브리 애니메이션 스타일 |
| 🏰 **디즈니** | 디즈니 픽사 3D 애니메이션 스타일 |
| 🎌 **애니메** | 일본 애니메이션 스타일 |
| 🤖 **사이버펑크** | 네온 조명의 미래적 사이버펑크 스타일 |
| 🧙‍♂️ **판타지** | 마법적이고 신비로운 판타지 스타일 |
| 📼 **80년대** | 신스웨이브 레트로 스타일 |
| 👻 **호러** | 고딕 호러 스타일 |
| 💥 **코믹** | 슈퍼히어로 코믹북 스타일 |

## 📁 프로젝트 구조

```
DYAI/
├── public/
│   └── index.html          # 메인 웹 페이지
├── server.js               # Express 서버 및 API
├── package.json            # 프로젝트 설정 및 의존성
├── .env                    # 환경 변수 (생성 필요)
└── README.md              # 프로젝트 문서
```

## 🔧 주요 기능 구현

### 이미지 분석 및 변환
1. **GPT-4 Vision**으로 업로드된 이미지 분석
2. **DALL-E 3**로 선택된 스타일에 맞게 이미지 재생성
3. 원본 구도와 인물 수 유지하면서 스타일만 변경

### 실시간 카메라 촬영
- `getUserMedia API`를 사용한 웹캠 접근
- HTML5 Canvas로 사진 캡처
- 즉시 변환 가능한 형태로 처리

### 이메일 전송
- Gmail SMTP를 통한 자동 이메일 발송
- HTML 템플릿으로 꾸며진 이메일
- 변환된 이미지 첨부

## 보안 고려사항

- OpenAI API 키는 환경 변수로 관리
- 파일 업로드 시 이미지 타입 검증
- 이메일 전송 시 입력값 검증

## 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다.

## 실행하기

- 설치 후 압축 헤제
- 베치파일 실행

## 문의

프로젝트에 대한 문의사항이 있으시면 이슈를 생성해 주세요.
