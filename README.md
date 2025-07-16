# iosapp

[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-15%2B-blue.svg)](https://developer.apple.com/xcode/)
[![iOS](https://img.shields.io/badge/iOS-16%2B-lightgrey.svg)](https://developer.apple.com/ios/)

## Overview

**iosapp** is a restaurant booking iOS application built with SwiftUI and MVVM architecture. Users can search for restaurants, view details, and make reservations, using mock data. The app demonstrates using Sentry performance tracing to monitor an end user booking flow - durations and success rates - helping developers monitor bottle necks, drop offs, and other concerning trends.

---

## Features

- **Restaurant Search & List:** Browse and search among 12 mock restaurants.
- **Reservation Flow:**
  - Details: Select date, time, and guests.
  - Payment: Enter credit card details.
  - Confirmation: Review and confirm reservation.
- **Sentry Integration:**
  - Error and performance monitoring with custom span instrumentation for the reservation flow.
- **SwiftUI & MVVM:**
  - Modular, testable, and scalable codebase.
- **Mock Data:**
  - No backend required; all data is local.

---

## Screenshots

<!-- Add screenshots here -->

---

## Getting Started

### Prerequisites
- Xcode 15 or later
- iOS 16.0 or later

### Setup
1. **Clone the repository:**
   ```sh
   git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
   cd iosapp
   ```
2. **Open in Xcode:**
   - Open `iosapp.xcodeproj` in Xcode.
3. **Install Sentry SDK:**
   - Sentry is included via Swift Package Manager. If needed, go to Xcode → File → Add Packages and add:
     ```
     https://github.com/getsentry/sentry-cocoa.git
     ```
   - Choose `Sentry` and `SentrySwiftUI` products.
4. **Configure Sentry DSN:**
   - In `iosappApp.swift`, set your Sentry DSN:
     ```swift
     options.dsn = "<YOUR_SENTRY_DSN>"
     ```
5. **Build & Run:**
   - Select a simulator or device and run the app.

---

## Sentry Instrumentation
- The app uses Sentry for error and performance monitoring.
- Custom spans are created for each step of the reservation flow (Details, Payment, Confirmation).
- Span Attributes are used to track Total reservation duration and status in Sentry.

---

## Project Structure

```
iosapp/
├── iosapp/                # Main app source code
│   ├── AppViewModel.swift
│   ├── MainScreen.swift
│   ├── RestaurantDetailsScreen.swift
│   ├── PaymentScreen.swift
│   ├── ConfirmationScreen.swift
│   ├── Restaurant.swift
│   ├── ReservationDetails.swift
│   ├── ...
├── iosappTests/           # Unit tests
├── iosappUITests/         # UI tests
├── Assets.xcassets/       # App assets
├── ...
```

---

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/YourFeature`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/YourFeature`)
5. Open a Pull Request

---

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

---

## Contact

For questions or support, please open an issue or contact the maintainer. 