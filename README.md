### Wanderverse Frontend

The Wanderverse frontend is built with **Flutter**, a cross-platform framework that provides a consistent and visually appealing user interface across web, iOS, and Android. The UI is designed to be responsive and user-friendly, offering a seamless experience for both the social-sharing and gaming aspects of the app.

#### Core App Pages
* **Auth Page**: A login and signup interface for new and existing users.
* **Home Page**: Displays a feed of user-generated posts and travel destinations, allowing users to browse photos and captions shared by the community.
* **Create Post Page**: Enables users to upload photos and write descriptions of tourist attractions.
* **User Profile Page**: Displays comprehensive user data and a curated list of posts shared by the user.
* **Discussion Page**: A dynamic feed of posts about travel destinations, which can be filtered by destination and post type.
* **Game Page**: Integrates a puzzle game inspired by **Snakebird**, built on **Unity WebGL**, and is optimized for low latency and smooth rendering.
* **Itinerary Page**: Integrates an **Agentic AI Trip Planner** to generate itinerary based on user request

#### State Management
The app uses **Riverpod** for state management. This handles app-wide states such as user session data, post feeds, and UI states. The architecture was optimized in a later milestone using **Riverpod Family Providers** for more granular data fetching and caching, which improved performance and reduced latency during user logins and data retrieval.

#### Technology Stack
* **Framework**: Flutter
* **Language**: Dart
* **State Management**: Riverpod
* **Hosting**: Netlify

---

### Software Engineering Principles (Frontend)

* **Separation of Concerns (SoC)**: The project's directory structure has distinct folders for `screens`, `widgets`, `models`, `router`, and `utils`, which modularizes UI, navigation, and data handling for improved maintainability.
* **Single Responsibility Principle (SRP)**: Individual files and widgets are designed to focus on a single purpose (e.g., `appTheme.dart` for thematics), reducing side effects and simplifying debugging.
* **Cross-Platform Compatibility**: The choice of Flutter and Unity's WebGL integration ensures the application can be deployed on web, iOS, and Android platforms from a single codebase.
* **Modularity and Reusability**: Directories for `providers`, `minigame`, and `post-sharing` contain the business logic for specific features, allowing for independent development and testing.
