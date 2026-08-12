# 📚 Flashcard Quiz App

A modern and interactive **Flashcard Quiz mobile application** built with **Flutter and Dart** as part of my **CodeAlpha App Development Internship**.

The application allows users to create, manage, and study custom flashcards using an interactive flip-card interface.

---

## 📱 Features

### Flashcard Management

* ➕ Add new flashcards
* ✏️ Edit existing flashcards
* 🗑️ Delete flashcards
* 💾 Persistent local storage

### Learning Experience

* 🔄 Previous and Next navigation
* 🔁 Interactive 3D flip-card animation
* 👁️ Reveal answers by flipping the card
* 📊 Card progress indicator
* 📱 Responsive and user-friendly interface

---

## 🛠️ Technologies Used

| Technology | Purpose                        |
| ---------- | ------------------------------ |
| Flutter    | Mobile application development |
| Dart       | Programming language           |
| SQLite     | Local database                 |
| sqflite    | SQLite integration             |
| Material 3 | UI design                      |

---

## 🏗️ Project Structure

```text
lib/
│
├── database/
│   └── database_helper.dart
│
├── models/
│   └── flashcard.dart
│
├── screens/
│   ├── home_screen.dart
│   └── add_edit_screen.dart
│
├── widgets/
│   └── flashcard_widget.dart
│
└── main.dart
```

---

## 🗄️ Database Structure

The application uses a local SQLite database.

### Flashcards Table

| Column   | Type    | Description        |
| -------- | ------- | ------------------ |
| id       | INTEGER | Primary key        |
| question | TEXT    | Flashcard question |
| answer   | TEXT    | Flashcard answer   |

---

## 🔄 CRUD Operations

The application supports complete CRUD functionality.

```text
Create
  ↓
Add Flashcard
  ↓
SQLite Database
  ↓
Read
  ↓
Display Flashcards
  ↓
Update
  ↓
Edit Flashcard
  ↓
Delete
  ↓
Remove Flashcard
```

---

## 🔁 Flip Card Animation

The flashcard uses a 3D rotation animation.

```text
        ┌───────────────┐
        │   QUESTION    │
        │               │
        │  Tap to Flip  │
        └───────────────┘
                │
                ▼
           3D Rotation
                │
                ▼
        ┌───────────────┐
        │    ANSWER     │
        │               │
        │ Tap to Flip   │
        │     Back      │
        └───────────────┘
```

The animation is implemented using Flutter's animation APIs and `Matrix4` rotation.

---

## 📊 Progress Indicator

The application displays the user's current position:

```text
Card 3 of 10

██████████░░░░░░░░
```

This allows users to understand their progress while going through the flashcards.

---

## 🚀 Getting Started

### Prerequisites

Install:

* Flutter SDK
* Dart SDK
* Android Studio or VS Code
* Android Emulator or physical Android device

### Clone Repository

```bash
git clone https://github.com/Manoj-1Kumar/CodeAlpha_FlashCardQuiz.git
```

### Navigate to Project

```bash
cd codealpha_flashcard_quiz
```

### Install Dependencies

```bash
flutter pub get
```

### Run Application

```bash
flutter run
```

---

## 📦 Build APK

```bash
flutter build apk --release
```

APK location:

```text
build/app/outputs/flutter-apk/app-release.apk
```

---

## 🎥 Project Demo

**Demo Video:**
Add your LinkedIn/video link here.

---

## 🔗 Internship

This project was developed as part of my **CodeAlpha App Development Internship**.

The project fulfills the **Flashcard Quiz App** task requirement.

---

## 👨‍💻 Developer

**Manojkumar P**

B.Tech Information Technology

---

## ⭐ Support

If you find this project useful, consider giving the repository a ⭐.

---

## 📄 License

This project is created for educational and internship purposes.
