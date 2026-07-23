# FriendsBattery

Inventory and stock management application (admin + seller, unit/serial inventory).

## Tech Stack

### Backend
- Node.js, Express, Prisma, PostgreSQL
- **OpenAPI/Swagger** is the API contract (`@swagger` / schemas → `openapi.json`)

### Frontend
- Flutter, Riverpod, go_router
- **API models:** generated OpenAPI package `friends_battery_api` (`frontend/lib/api/`) — **do not hand-edit**
- **Dio:** HTTP transport only (`frontend/lib/core/network`) — **not** the source of API models

```text
UI → Riverpod → Feature Repository → friends_battery_api → Dio → Backend
```

Agent rules: `AGENTS.md`. OpenAPI standard: `frontend/docs/OPENAPI.md`.

---

## New / changed API → frontend (required)

1. Backend + **Swagger** matching the real handler  
2. From repo root: **`npm run gen`** (exports OpenAPI + regenerates Flutter client)  
3. Feature **repository** uses generated `*Api` + OpenAPI types (no feature `dio.get/post`, no twin `fromJson` DTOs)  
4. Riverpod provider → UI  

If generated types are wrong: fix **backend swagger**, then `npm run gen` again.

---

## Project Structure

```text
FriendsBattery/
├── backend/                 # Express + Prisma + Swagger
├── frontend/
│   ├── lib/api/             # GENERATED OpenAPI client — do not edit
│   ├── lib/core/network/    # Dio transport only
│   ├── lib/features/        # screens, providers, repositories
│   ├── docs/OPENAPI.md
│   └── instructions/frontend_guidelines.md
├── generate_api.bat
├── package.json             # npm run gen, build-*, tunnel
├── AGENTS.md
└── README.md
```
---

## Backend Setup

Navigate to the backend folder:

```bash
cd backend
```

Install dependencies:

```bash
npm install
```

Run development server:

```bash
npm run dev
```

Or:

```bash
npm start
```

---

## Frontend Setup

Navigate to the frontend folder:

```bash
cd frontend
```

Install Flutter packages:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

---

## Environment Variables

Create a `.env` file inside the backend folder.

Example:

```env
PORT=5000
DATABASE_URL=your_database_connection_string
```

---

## Git Setup

Clone the repository:

```bash
git clone <repository-url>
```

Move into the project:

```bash
cd friendsBattery
```

Install backend dependencies:

```bash
cd backend
npm install
```

Install frontend dependencies:

```bash
cd ../frontend
flutter pub get
```

---

## Team Workflow

Pull latest changes:

```bash
git pull origin main
```

Create a feature branch:

```bash
git checkout -b feature/feature-name
```

Push changes:

```bash
git add .
git commit -m "feat: add feature"
git push origin feature/feature-name
```

Create a Pull Request on GitHub.