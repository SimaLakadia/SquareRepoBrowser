# SquareRepoBrowser

An iOS application that displays a list of public GitHub repositories for the **Square** organization.  
Built as part of the **Poq iOS Technical Challenge**.

---

## Features

- Scrollable list of Square GitHub repositories
- Displays repository **name** and **description**
- Pull-to-refresh support
- Loading, error, and empty states handled gracefully
- Opens repository links in Safari

---

## Architecture

The app follows the **MVVM (Model–View–ViewModel)** architecture.

- **View**: UIKit ViewControllers & TableViewCells  
- **ViewModel**: Business logic and state handling  
- **Model**: Repository data models  
- **Networking**: Centralized APIService using `URLSession`  

This approach keeps the code modular, testable, and easy to maintain.

---

## Networking

- API endpoint used:
  ```
  https://api.github.com/orgs/square/repos
  ```
- Networking is handled using `URLSession`
- Handles:
  - No internet connection
  - Server and decoding errors
  - Empty responses
  - Invalid API URLs

---

## Loading & Error Handling

- Activity indicator shown during API calls
- Error and empty state messages displayed when required
- Previously loaded data is preserved if refresh fails, ensuring better UX

---

## Testing

- **Unit tests** written for `RepoListViewModel`
- API calls mocked using protocol-based dependency injection
- Test cases include:
  - Successful repository fetch
  - Failure scenarios (e.g. no internet)
- Default Xcode-generated UI launch and performance tests are included

All tests pass successfully.

---

## Technologies Used

- Swift
- UIKit
- URLSession
- XCTest
- NWPathMonitor

No third-party libraries were used.

---

## Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/SimaLakadia/SquareRepoBrowser.git
   ```

2. Open the project in Xcode:
   ```bash
   open SquareRepoBrowser.xcodeproj
   ```

3. Run the app:
   ```
   ⌘ + R
   ```

4. Run tests:
   ```
   ⌘ + U
   ```

---

## Notes

- The focus of this project is on **code quality, clarity, and robustness**
- MVVM was chosen to demonstrate clean separation of concerns and testability
- Edge cases such as offline refresh and empty data sets are handled gracefully

---

## Author

**Sima Lakadia**  
iOS Developer
