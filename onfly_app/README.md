# Onfly API - Simple JSON-based Backend

**Author:** Dan Lima

## 📌 Overview

This is a **very simple backend** built with **Dart Shelf**, created solely to allow the app to function since an official API was not provided.

🚀 **Key Features:**

- **NoSQL JSON-based storage** (no database installation required).
- **User authentication** (email/password-based login).
- **Expense management** (CRUD operations for travel expenses).
- **Portable & lightweight** (works in any environment with Dart installed).
- **Uses Shelf & Shelf Router** for API routing.

## 🏗️ Project Structure

```
📂 onfly_server/
│── 📂 bin/
│   ├── onfly_server.dart       # Main server entry point
│── 📂 lib/
│   ├── 📂 core/
│   │   ├── database_helper.dart  # Handles JSON-based database
│   ├── 📂 data/
│   │   ├── user_repository.dart  # Manages user-related data
│   │   ├── expense_repository.dart # Manages expense data
│   ├── 📂 presentation/
│   │   ├── handlers.dart       # API route handlers
│── 📂 storage/
│   ├── database.json          # JSON-based database
│── pubspec.yaml               # Dart dependencies
```

## ⚙️ Installation & Setup

### **1️⃣ Install Dart (if not installed)**

Ensure Dart SDK is installed:

```bash
dart --version
```

If Dart is missing, install it from: [Dart SDK](https://dart.dev/get-dart)

### **2️⃣ Clone the repository**

```bash
git clone https://github.com/your-repo/onfly_api.git
cd onfly_api
```

### **3️⃣ Install dependencies**

```bash
dart pub get
```

### **4️⃣ Populate the JSON database**

Create the `storage/database.json` file if it does not exist, and add sample data:

```json
{
  "users": [
    {
      "id": "1",
      "name": "John Doe",
      "email": "john@email.com",
      "password": "123456"
    }
  ],
  "expenses": []
}
```

### **5️⃣ Run the server**

```bash
dart run bin/onfly_server.dart
```

### **6️⃣ API is now running on**

```bash
http://localhost:5000
```

## 🔥 API Endpoints

### **Authentication**

#### 🔹 `POST /login` - User Login

**Request:**

```json
{
  "email": "john@email.com",
  "password": "123456"
}
```

**Response:**

```json
{
  "token": "JWT-TOKEN-HERE"
}
```

### **Expense Management**

#### 🔹 `GET /expenses` - Fetch all expenses

```bash
curl -X GET http://localhost:5000/expenses
```

#### 🔹 `POST /expenses` - Add an expense

```json
{
  "id": "101",
  "userId": "1",
  "date": "2025-03-10T12:00:00Z",
  "value": 150.5,
  "category": "Transport",
  "description": "Taxi from airport",
  "isSynced": false
}
```

## 📖 How It Works

### 1️⃣ **Authentication**

- Users log in via `POST /login`.
- If credentials are valid, a **JWT token** is returned.

### 2️⃣ **Expense Management**

- Expenses are stored in `storage/database.json`.
- `GET /expenses` retrieves all stored expenses.
- `POST /expenses` adds a new expense.

## 🛠️ Development Notes

- **No SQL or database installation required**.
- **Uses JSON for lightweight data storage**.
- **Easily extendable** (add new features via `handlers.dart`).

## 📜 License

This project is licensed under the **MIT License**.

## 👨‍💻 Contributing

1. Fork the repository.
2. Create a new branch.
3. Make your changes and submit a pull request.

---

🚀 **This backend was built as a temporary solution due to the absence of an official API. It is not meant for production use.**
