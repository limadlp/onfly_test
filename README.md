# Onfly Expense Management System

This project is a **corporate travel expense management system**, developed using **Flutter** with a focus on **offline-first functionality**. The system consists of three main components:

- **📱 onfly_app** → Mobile application built with Flutter.
- **🎨 onfly_design_system** → A standalone Design System package.
- **🖥 onfly_server** → A simple Dart backend to support the app.

## 🚀 Features

### 🏗 **Architecture**

- **Flutter Modular** → For dependency injection and module separation.
- **Cubit (Bloc)** → For state management.
- **SQLite (Drift)** → Local storage for offline-first functionality.
- **Dart Backend** → A lightweight backend using **Shelf** to handle API requests.
- **Clean Architecture** → Well-organized project structure.

### 📱 **Mobile App (onfly_app)**

✅ **Login Screen** → Authenticate users via email and password.  
✅ **Expense List** → Display, add, edit, and delete travel expenses.  
✅ **Corporate Card Screen** → Show balance, brand, and transactions.  
✅ **Travel Management** → Show travel details (boarding pass, flight time, airline, airport).  
✅ **Offline-First** → Works without internet, syncing data when online.  
✅ **Reports & Graphs** → Visualize expenses with filters.  
✅ **Dark & Light Theme** → Following Onfly’s Style Guide.

### 🎨 **Design System (onfly_design_system)**

✅ **Color Tokens** → Primary, Secondary, Success, Alert, Background.  
✅ **Typography** → Based on Poppins font.  
✅ **Buttons** → Primary, Success, Alert, Disabled (Filled, Outline, Text).  
✅ **Inputs & Fields** → Text fields, password fields, dropdowns.  
✅ **Cards & Lists** → Used for expense tracking.  
✅ **Tabs, Switches, Tooltips, and Status Components**.  
✅ **Light & Dark Mode Support**.

### 🖥 **Backend Server (onfly_server)**

✅ **Built with Dart (Shelf framework)**.  
✅ **Handles Authentication (mock login system)**.  
✅ **Provides API endpoints for expenses & travel management**.  
✅ **Simulates synchronization for offline-first functionality**.

---

## 📂 Project Structure

```

/onfly_repo
├── /onfly_app # Flutter mobile app
├── /onfly_design_system # Standalone Design System package
├── /onfly_server # Simple Dart backend (Shelf)
├── README.md # Project documentation
└── .gitignore # Git ignore settings

```

---

## 🛠 Setup & Installation

### 1️⃣ **Clone the repository**

```sh
git clone https://github.com/your-username/onfly_repo.git
cd onfly_repo
```

### 2️⃣ **Backend Setup (onfly_server)**

```sh
cd onfly_server
dart pub get
dart run bin/server.dart
```

- The backend runs on **localhost:8080**.

### 3️⃣ **Design System Setup (onfly_design_system)**

```sh
cd onfly_design_system
dart pub get
```

### 4️⃣ **Mobile App Setup (onfly_app)**

```sh
cd onfly_app
flutter pub get
flutter run
```

---

## 🚦 API Endpoints (onfly_server)

| Method | Endpoint           | Description                  |
| ------ | ------------------ | ---------------------------- |
| `POST` | `/login`           | User authentication          |
| `GET`  | `/expenses`        | Fetch expense list           |
| `POST` | `/expenses`        | Add a new expense            |
| `GET`  | `/corporate-card`  | Fetch corporate card details |
| `GET`  | `/travel-schedule` | Fetch travel schedule        |

---

## 🛠 Technologies Used

| Technology          | Purpose                                       |
| ------------------- | --------------------------------------------- |
| **Flutter**         | Mobile app development                        |
| **Dart**            | Backend and mobile development                |
| **SQLite (Drift)**  | Local storage for offline-first functionality |
| **Flutter Modular** | Dependency injection & navigation             |
| **Cubit (Bloc)**    | State management                              |
| **Shelf**           | Lightweight Dart backend                      |

---

## ✅ Best Practices Followed

- **Separation of concerns** → The Design System is modular and can be reused.
- **Scalability** → The backend is structured for future improvements.
- **Offline-first** → Users can access expense data without an internet connection.
- **Automated Testing** → Unit and integration tests for stability.

---

# 🧪 Testing Guide

This project follows the **Clean Architecture** principles and uses **Flutter Modular** for dependency injection. Our testing strategy ensures that each layer is properly tested, avoiding tight coupling between components.

## 🔹 What is Tested?

We use **unit tests** to validate the correctness of our application's core logic. The following table summarizes the **Clean Architecture layers** and what we test in each one:

| **Layer**                    | **What is tested?**                                         |
| ---------------------------- | ----------------------------------------------------------- |
| **Data (Datasource)**        | Ensures that API calls return the expected data             |
| **Domain (UseCases)**        | Validates that business logic is correctly executed         |
| **Repository**               | Checks if repositories correctly interact with datasources  |
| **Cubit (State Management)** | Verifies if states are correctly emitted during operations  |
| **UI (Optional)**            | Ensures that UI components display correctly (widget tests) |

## 🛠️ Testing Tools

We use **Mocktail** to create test doubles instead of real dependencies. Unlike **Mockito**, Mocktail does **not require code generation** (`build_runner`), making it simpler and faster to use.

### 📌 Why **Mocktail**?

- No need to run `flutter pub run build_runner build`
- More flexible and easier to use than Mockito
- Works perfectly with **Flutter Bloc** and **Cubit**

## 🏃 Running the Tests

To execute the tests, simply run:

```bash
flutter test
This will run all unit tests and verify if the code is working as expected.

---

## 👥 Contributors

- **[Dan Lima]** - Dart/Flutter Developer

---

## 📜 License

This project is licensed under the **MIT License**.

---

## 📩 Contact

For questions or support, reach out to **dlplima@hotmail.com**.

```

```

```
