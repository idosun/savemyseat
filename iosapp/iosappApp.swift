//
//  iosappApp.swift
//  iosapp
//
//  Created by Ido Shemesh on 7/15/25.
//

import SwiftUI
import Sentry

@main
struct iosappApp: App {
	@StateObject var viewModel = AppViewModel()

	init() {
		SentrySDK.start { options in
			options.dsn = "" // TODO: Replace with your real DSN
			options.debug = true // Helpful for development
			options.tracesSampleRate = 1.0 // 100% performance tracing (adjust in production)
		}
		// Send a test error to verify Sentry integration
		SentrySDK.capture(message: "Sentry is successfully integrated!")
	}

	var body: some Scene {
		WindowGroup {
			NavigationStack(path: $viewModel.path) {
				MainScreen()
					.environmentObject(viewModel)
					.navigationDestination(for: AppViewModel.Screen.self) { screen in
						switch screen {
						case .details(let restaurant):
							RestaurantDetailsScreen(restaurant: restaurant)
								.environmentObject(viewModel)
						case .payment:
							PaymentScreen()
								.environmentObject(viewModel)
						case .confirmation:
							ConfirmationScreen()
								.environmentObject(viewModel)
						}
					}
			}
		}
	}
}
