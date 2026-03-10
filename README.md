# 📦 Products with Cache — Flutter Demo App

A Flutter demo app that showcases **Cache-First strategy**, **Skeletonizer loading**, **dark/light theme switching**, and a **simple clean architecture** using Cubit for state management.

---

## ✨ Features

- 🗂️ **Cache-First Loading** — Shows cached products instantly, then refreshes from the API in the background
- 💀 **Skeletonizer Loading** — Beautiful skeleton placeholders while loading for the first time
- 🌗 **Theme Switching** — Toggle between light and dark themes, persisted across restarts
- 📜 **Infinite Pagination** — Scroll to the bottom to load more products automatically
- ⚠️ **Graceful Error Handling** — Falls back to cached data when network fails, shows a retry snackbar

---

## 🏗️ Architecture

The project follows a **simple clean architecture** pattern with two main layers:

```
lib/
├── core/                        # Shared utilities and services
│   ├── constants/               # API endpoints and app constants
│   ├── errors/                  # Failure & Exception models
│   ├── routes/                  # Named route definitions
│   ├── services/                # API (Dio) & local DB (Hive) services
│   ├── theme_cubit/             # Theme state management
│   ├── themes/                  # Light and dark ThemeData
│   └── widgets/                 # Shared reusable widgets (e.g. ThemeSwitcher)
│
└── features/
    └── products/
        ├── data/
        │   ├── data_source/     # Remote (Dio) & Local (Hive) data sources
        │   ├── models/          # ProductModel with fromJson / toJson / toMap
        │   └── repos/           # Repository interface + implementation
        └── presentation/
            ├── cubits/          # ProductCubit + ProductState
            ├── screens/         # ProductsScreen
            └── widgets/         # Product UI widgets
```

---

## 🗄️ Cache-First Strategy

The app implements a **cache-first** then **network-update** pattern:

1. **On app start**, the cubit calls `getLocalProducts()` to immediately show any previously cached data — making the UI feel instant, even with no internet.
2. **Then**, it fires the remote API request.
3. **On API success** — new data is shown and saved to the local Hive database.
4. **On API failure** — if cached data is already shown, a snackbar is displayed so the user knows the data may be stale. If there's no cached data at all, an error screen is shown with a retry button.

```
App starts
    ↓
[1] Load from Hive cache → show in UI instantly
    ↓
[2] Fetch from API (Dio)
    ↓
    ├── ✅ Success → update UI + save to Hive cache
    └── ❌ Failure → keep cached data + show snackbar with retry
```

**Key files:**
- `ProductsLocalDataSource` — reads/writes from local Hive database using `LocalDataBaseService`
- `ProductsRemoteDataSource` — fetches from the remote API via Dio
- `ProductsRepoImpl` — orchestrates the cache-first logic
- `ProductCubit.getProducts()` — drives the UI state updates

---

## 💀 Skeletonizer Loading

The [`skeletonizer`](https://pub.dev/packages/skeletonizer) package is used to show animated skeleton placeholders while the product list is loading for the first time (when there is no cached data yet).

**How it works:**

- `LoadingProductsList` renders 6 fake `ProductItem` widgets using `ProductModel.fakeProduct`
- Each item is wrapped with `Skeletonizer(enabled: true, ...)` to paint the shimmer effect on top
- Once real data arrives, the cubit emits a `success` state and the skeleton is replaced by the real list

```dart
// LoadingProductsList widget
Skeletonizer(
  enabled: true,
  child: ProductItem(product: ProductModel.fakeProduct),
)
```

This approach is powerful because:
- The skeleton has the **exact same layout** as the real item — no layout shift
- No extra skeleton widgets needed — just wrap the real widget and pass fake data

---

## 🌗 Theme Switching

- `ThemeCubit` manages the dark/light mode state
- The current theme is persisted to `SharedPreferences` so it survives app restarts
- A `ThemeSwitcher` icon button in the AppBar toggles the theme at any time

---

## 📦 Packages Used

| Package | Purpose |
|---|---|
| `flutter_bloc` | State management (Cubit) |
| `dio` | HTTP networking |
| `hive` / `hive_flutter` | Fast, lightweight local NoSQL database caching |
| `skeletonizer` | Skeleton loading placeholders |
| `shared_preferences` | Persisting theme preference |
| `dartz` | Functional `Either` type for error handling |
| `get_it` | Service locator / dependency injection |
| `cached_network_image` | Caching and rendering network images |

---

## 🚀 Getting Started

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run
```
