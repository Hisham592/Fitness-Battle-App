# 🏋️‍♂️ VOZ App

A gamified fitness and nutrition mobile application featuring a dark cyberpunk aesthetic and dynamic neon themes.

## ✨ Core Features

* **Smart Workout Splits:** Tailored programs across three tiers (Beginner, Intermediate, Expert) with Tuesday designated as the official weekly Rest Day[cite: 1].
* **Interactive Completion Flow:** Features an exercise checklist where the "Finish Challenge" button unlocks strictly after completing all daily targets to secure progress tracking[cite: 1].
* **Dynamic Theme Engine:** Allows changing the primary accent across 4 vibrant neon colors (Purple, Cyan, Green, Yellow) with real-time state updates saved locally[cite: 1].
* **Smart Local Nutrition:** A curated list of 50+ local Egyptian meals priced in EGP with exact macro breakdowns, sortable by caloric density or budget[cite: 1].
* **Avatar Customization Store:** Spend earned workout points (PTS) to unlock, buy, and equip custom profile avatars[cite: 1].

## 🛠️ Tech Stack

* **Framework:** Flutter & Dart[cite: 1]
* **State Management:** Bloc / Cubit[cite: 1]
* **Backend Backend:** Firebase (Authentication & Cloud Firestore)[cite: 1]
* **Local Storage:** SharedPreferences[cite: 1]
* **Video Player:** youtube_player_iframe[cite: 1]

## ⚙️ How to Run

1. Make sure the Flutter SDK stable channel is installed on your machine.
2. Clone the repository, open your terminal in the root folder, and run:

```bash
flutter clean
flutter pub get
flutter run
