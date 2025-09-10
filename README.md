# Tech Notes: Business List App


## App Preview

| Loading State | Data Loaded |
| :---: | :---: |
| <img src="snap/initial.jpg" width="25%" alt="Apps state on initialization" /> | <img src="snap/loaded.jpg" width="25%" alt="Apps state on initialization" />


## Architecture
This app follows a layered architecture:
1.  **Data Layer**: `BusinessApiService` (Dio) and `BusinessRepository` (Hive). The repo handles the "single source of truth," first trying the network and falling back to local cache.
2.  **State Management Layer**: `BusinessProvider` (Provider package) holds the app's state and business logic, notifying the UI of changes.
3.  **Presentation Layer**: UI widgets (`HomePage`, `BusinessListTile`) consume the provider and render the state.

## Key Trade-offs & Decisions
*   **Provider over BLoC/Riverpod**: Chosen for simplicity and to match the assignment requirements. For a larger app, Riverpod's compile-time safety would be better.
*   **Hive for Local Storage**: Chosen for its simplicity, speed, and native Dart support. It's easier to set up than SQLite for this simple object list.
*   **Generic BusinessCard**: The card is a generic widget that accepts a builder function. This makes it truly reusable for any data model, but adds a small amount of boilerplate (the need for a `BusinessListTile`). The alternative was to make it accept specific `Business` properties, which would be less flexible.

## Improvements with More Time
1.  **Testing**: Add unit tests for the `Business.fromJson()` method, the `BusinessProvider`, and widget tests for the UI states.
2.  **Detailed Error Handling**: Differentiate between network errors, parsing errors, and empty states with specific messages and UI.
3.  **Pull-to-Refresh**: Implement a `RefreshIndicator` for a better UX than just the FAB.
4.  **Search/Filtering**: Add functionality to search through the list of businesses.
5.  **Dependency Injection**: Use a package like `get_it` to better manage the creation of `Repository` and `Provider`, making it easier to mock dependencies for testing.