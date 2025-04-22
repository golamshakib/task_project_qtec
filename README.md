# task_project

### E-Commerce Product Listing App

A Flutter e-commerce application that displays products from FakeStoreAPI with search, filtering, and sorting capabilities. The app implements pagination, offline caching, and follows a clean architecture pattern using GetX for state management.

## Getting Started

### E-Commerce Product Listing App

A Flutter e-commerce application that displays products from FakeStoreAPI with search, filtering, and sorting capabilities. The app implements pagination, offline caching, and follows a clean architecture pattern using GetX for state management.

## Project Video
- app video link : https://www.loom.com/share/2782280f3dfc460d8ebce2d994699d47

## Apk Link

- apk link : https://drive.google.com/drive/folders/1COKRQxJk1AT1safFz1e2UShT5Ee9GhIc?usp=sharing

## Features

- **Product List**

    - Fetches products from FakeStoreAPI
    - Displays products in a responsive grid layout
    - Implements pagination with "load more" on scroll  
    ![Product list](https://github.com/golamshakib/task_project_qtec/blob/main/Screenshot_1745319946.png?raw=true)

- **Search & Filters**

    - Search products by name in real-time
    - Sort products by:
        - Price (Low to High)
        - Price (High to Low)
        - Rating  
    ![search](https://github.com/golamshakib/task_project_qtec/blob/main/Screenshot_1745317703.png?raw=true)  
    ![sorting by filter](https://github.com/golamshakib/task_project_qtec/blob/main/Screenshot_1745319917.png?raw=true)

- **Offline Mode**

    - Offline Mode:
       ![search](https://github.com/golamshakib/task_project_qtec/blob/main/Screenshot_1745317639.png?raw=true)  

- **State Management**

    - Uses GetX for reactive state management
    - Minimizes rebuilds with `Obx` and `.obs` variables

- **Offline-First Approach**

    - Caches API responses using `sqflite` for local storage
    - Shows cached data when offline
    - Displays offline notification via bottom snackbar

---

## Technical Implementation

### Key Components

- **HomeController**: Manages product state, search, filtering, and pagination.
- **NetworkCaller**: Handles API requests with proper error handling.
- **LocalStorageService**: Manages caching with `sqflite`
- **Custom Widgets**: Reusable components for consistent UI.

### Dependencies

1. `get` - For state management.
2. `sqflite` - For offline local storage.
3. `http` - For network requests.
4. `cached_network_image` - For displaying images efficiently.

---

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- An IDE (Android Studio, VS Code)

### Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/golamshakib/task_project_qtec.git
    ```

2. Navigate to the project directory:

    ```bash
    cd task_project_qtec
    ```

3. Install dependencies:

    ```bash
    flutter pub get
    ```

4. Run the app:

    ```bash
    flutter run
    ```

---
