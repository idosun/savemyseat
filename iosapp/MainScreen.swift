import SwiftUI
import SentrySwiftUI


struct MainScreen: View {
	@EnvironmentObject var viewModel: AppViewModel

	var filteredRestaurants: [Restaurant] {
		if viewModel.searchText.isEmpty {
			return viewModel.restaurants
		}
		return viewModel.restaurants.filter {
			$0.name.lowercased().contains(viewModel.searchText.lowercased())
		}
	}

	var body: some View {
        SentryTracedView("MainScreen"){
            VStack {
                TextField("Search restaurants...", text: $viewModel.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                ScrollView {
                    ForEach(filteredRestaurants) { restaurant in
                        SentryTracedView("RestaurantCard"){
                            RestaurantCard(restaurant: restaurant)
                                .environmentObject(viewModel)
                                .padding(.horizontal)
                                .padding(.bottom, 8)
                        }
                    }
                }
            }
            .navigationTitle("Restaurants")
            .alert("Reservation Confirmed!", isPresented: $viewModel.showConfirmationPopup) {
                Button("Close") {
                    viewModel.reset()
                }
            } message: {
                Text("Your reservation has been confirmed.")
            }
        }
	}
}

struct RestaurantCard: View {
	let restaurant: Restaurant
	@EnvironmentObject var viewModel: AppViewModel

	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			Image(systemName: restaurant.imageName)
				.resizable()
				.scaledToFit()
				.frame(height: 150)
				.cornerRadius(10)
				.frame(maxWidth: .infinity)
				.background(Color.gray.opacity(0.2))

			Text(restaurant.name)
				.font(.title2)
				.bold()
			Text(restaurant.description)
				.font(.body)
			Text(restaurant.address)
				.font(.subheadline)
				.foregroundColor(.secondary)

			Button(action: {
				viewModel.selectedRestaurant = restaurant
				viewModel.reservationDetails = viewModel.randomReservation(for: restaurant)
				viewModel.reservationStartTime = Date()
				viewModel.reservationDurationMs = nil
				viewModel.path.append(.details(restaurant))
			}) {
				Text("Reserve")
					.font(.headline)
					.frame(maxWidth: .infinity)
					.padding()
					.background(Color.blue)
					.foregroundColor(.white)
					.cornerRadius(8)
			}
			.padding(.top, 8)
		}
		.padding()
		.background(Color(.systemBackground))
		.cornerRadius(12)
		.shadow(radius: 2)
	}
} 
