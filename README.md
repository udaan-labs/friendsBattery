# FriendsBattery

Inventory and stock management application.

## Tech Stack

### Backend
- Node.js
- Express.js

### Frontend
- Flutter

---

## Project Structure

```text
friendsBattery/
│
├── backend/
│
├── frontend/
│
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