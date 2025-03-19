# Onfly Expense Management System

[![en](https://img.shields.io/badge/lang-en-red.svg)](./README.md)
[![pt-br](https://img.shields.io/badge/lang-pt--br-green.svg)](./README_PT.md)

This project is a **corporate travel expense management system** built with **Flutter** (offline-first approach), a **Design System** package, and a lightweight **Dart backend (Shelf)**. The architecture follows **Clean Architecture** and leverages **Drift** (SQLite) for offline data storage, ensuring users can manage expenses even without an active internet connection.

## 📱 Screenshots

|                                                            |                                                          |                                                            |
| ---------------------------------------------------------- | -------------------------------------------------------- | ---------------------------------------------------------- |
| <img src="onfly_design_system/img/ss01_2.png" width="75%"> | <img src="onfly_design_system/img/ss02.png" width="75%"> | <img src="onfly_design_system/img/ss02_2.png" width="75%"> |
| <img src="onfly_design_system/img/ss02_3.png" width="75%"> | <img src="onfly_design_system/img/ss04.png" width="75%"> | <img src="onfly_design_system/img/ss05.png" width="75%">   |
| <img src="onfly_design_system/img/ss01.png" width="75%">   | <img src="onfly_design_system/img/ss03.png" width="75%"> | <img src="onfly_design_system/img/ss04_2.png" width="75%"> |

## 🔎 Overview

| Component               | Description                                                               |
| ----------------------- | ------------------------------------------------------------------------- |
| **onfly_app** (Flutter) | Mobile application managing corporate travel expenses (offline-first).    |
| **onfly_design_system** | Standalone package containing reusable UI components, colors, and themes. |
| **onfly_server** (Dart) | Simple Dart backend using Shelf to handle API requests.                   |

### Key Features

- **Offline-First**: Data is stored locally (via **Drift** (SQLite)) and synced to the server when online.
- **Clean Architecture**: Clear separation of **Data**, **Domain**, and **Presentation** layers.
- **Dependency Injection**: Uses Flutter Modular for modular architecture, where each module (Auth, Expenses, etc.) is independent and self-contained with its own routes, dependencies and business logic.
- **State Management**: Uses Cubit from the BLoC ecosystem.
- **Image Upload & Compression**: Upload expense receipts in **Base64**, compressed via flutter_image_compress.
- **Design System**: A consistent UI and brand styling from the **onfly_design_system** package.
- **Lightweight Backend**: A Dart server with MVC architecture that provides REST endpoints for **Expenses**, **Auth**, and more.

## 🏗 Architecture

This project follows **Clean Architecture** for the Flutter app and **MVC** for the Dart backend:

```
Domain
┣ Entities (Expense, etc.)
┣ UseCases (AddExpense, GetExpenses, etc.)
┗ Repositories (Interfaces)

Data
┣ Models (ExpenseModel)
┣ DataSources (Remote, Local/Drift)
┗ Repositories Implementations

Presentation
┣ Cubit (ExpensesCubit)
┗ UI Pages (ExpensesPage, etc.)
```

```
Backend (MVC)
┣ Controllers (Auth, Expense)
┣ Models
┣ Repositories
┣ Services
┣ Utils
┣ routes.dart
┗ bin/main.dart
```

### Offline-First Flow

1. **Local Database (Drift)** → All expenses are stored locally in an SQLite DB.
2. **Remote Sync** → Whenever the app starts or a CRUD operation occurs, the local DB is updated and an attempt is made to sync with the remote server.
3. **Conflict Resolution (Simple)** → The project includes a simple method (`syncExpenses`) to push unsynced data to the server and then fetch the latest from the server to update the local database.

## 📂 Repository Structure

```
onfly_repo
├── onfly_app            # The Flutter mobile application
├── onfly_design_system  # Standalone design system package
├── onfly_server         # Shelf-based Dart backend
├── README.md            # This documentation
└── .gitignore
```

## 🛠️ Installation & Setup

1. **Clone the repository:**

```bash
git clone https://github.com/limadlp/onfly_test.git
cd onfly_repo
```

2. **Backend Setup (`onfly_server`):**

```bash
cd onfly_server
dart pub get
dart run bin/main.dart
```

- The backend will run on **localhost:5000** (or the configured port).

3. **Design System Setup (`onfly_design_system`):**

```bash
cd onfly_design_system
dart pub get
```

- This package can be imported by the app or any Flutter project needing consistent Onfly branding.

4. **Mobile App Setup (`onfly_app`):**

```bash
cd onfly_app
flutter pub get
flutter run
```

### Test Credentials

To test the application, use the following credentials:

- **Email**: user@onfly.com
- **Password**: 123456

- Make sure you have a device/emulator running.

## 🚀 Main Functionalities

### 1. **Authentication**

- Users can **sign in** via email and password. The token is saved locally and included in all API requests.

### 2. **Expense Management**

- **List Expenses**: Shows a list of corporate travel expenses, stored **offline-first** in Drift.
- **Add/Edit/Delete Expenses**: Interacts with local DB and syncs changes with the server.
- **Expense Filters & Charts**: Filter by status and category; generate charts to visualize spending patterns.

### 3. **Upload Receipts**

- Users can attach receipts to an expense by **picking an image** from the gallery or camera.
- The image is **compressed** (using flutter_image_compress) and converted to Base64.
- A **POST** request is sent to `/expenses/upload`, updating the `receiptUrl` on the server.

### 4. **Corporate Card**

- Displays the **corporate card** details and recent transactions.

### 5. **Travel Management**

- Shows flight details, boarding passes, check-in times, etc.

---

## 📱 Design System

The **onfly_design_system** is a Flutter package that can be reused across any Onfly project, providing:

- **Color tokens** (Primary, Secondary, Alert, Success, etc.)
- **Typography** (Headings, Paragraphs, etc.)
- **Widgets** (Buttons, Forms, Cards)
- **Theme support** (Light/Dark mode)

This ensures a **consistent** UI across all Onfly projects.

---

## 📡 API Endpoints (Backend)

Below is an overview of the key endpoints. For full details, see the `onfly_server` code.

| Method   | Endpoint           | Description                             |
| -------- | ------------------ | --------------------------------------- |
| `POST`   | `/auth/signin`     | User authentication (returns a JWT)     |
| `POST`   | `/auth/signup`     | User registration                       |
| `GET`    | `/expenses`        | Fetch all expenses for the current user |
| `POST`   | `/expenses`        | Add a new expense                       |
| `GET`    | `/expenses/<id>`   | Fetch a single expense (by ID)          |
| `PUT`    | `/expenses/<id>`   | Update an existing expense              |
| `DELETE` | `/expenses/<id>`   | Delete an expense                       |
| `POST`   | `/expenses/upload` | Upload a receipt image                  |

## 💾 Backend Storage Structure

The application uses a simple file-based storage system:

- **Backend Database**: For simplicity, a JSON file located at `storage/database.json` stores all application data
- **Receipts**: Receipt images are stored in the `storage/receipts` directory

This simple structure makes it easy to manage and backup data locally.

## 🧑‍💻 Usage Example

### Adding a New Expense

1. **Offline**: The expense is inserted into the local Drift DB with `isSynced = false`.
2. **Online Sync**: The system attempts to create the same expense on the backend. If successful, we update the local record to `isSynced = true`.

## ⏱ Synchronization Logic

A `syncExpenses()` method in the Repository tries to:

1. **Find unsynced expenses** (`isSynced = false`) in the local DB.
2. **Upload or update** them remotely (depending on whether they exist in the server).
3. **Fetch** the updated list from the server and re-save them locally to ensure data consistency.

## 🧪 Testing Guide

### Testing Layers

| Layer                    | What is Tested                           |
| ------------------------ | ---------------------------------------- |
| **Domain (UseCases)**    | Business logic (AddExpense, GetExpenses) |
| **Data (DataSources)**   | API & DB operations (remote/local)       |
| **Repositories**         | Proper integration between Domain & Data |
| **Presentation (Cubit)** | State changes, input handling            |

### Running Tests

```bash
cd onfly_app
flutter test
```

## 👥 Authors & Maintainers

- **Dan Lima** (Flutter / Dart Developer)
  <dlplima@hotmail.com>

---
