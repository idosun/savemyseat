import SwiftUI
import SentrySwiftUI
import Sentry

struct RestaurantDetailsScreen: View {
	let restaurant: Restaurant
	@EnvironmentObject var viewModel: AppViewModel

	var body: some View {
        SentryTracedView("RestaurantDetailsScreen"){
            
            Form {
                Section(header: Text("Restaurant")) {
                    Text(restaurant.name).font(.headline)
                    Text(restaurant.description)
                    Text(restaurant.address).font(.subheadline)
                }
                
                Section(header: Text("Reservation Details")) {
                    DatePicker("Date", selection: Binding(
                        get: { viewModel.reservationDetails?.date ?? Date() },
                        set: { viewModel.reservationDetails?.date = $0 }
                    ), displayedComponents: .date)
                    
                    Picker("Time", selection: Binding(
                        get: { viewModel.reservationDetails?.time ?? viewModel.times[0] },
                        set: { viewModel.reservationDetails?.time = $0 }
                    )) {
                        ForEach(viewModel.times, id: \.self) { time in
                            Text(time)
                        }
                    }
                    
                    Picker("Guests", selection: Binding(
                        get: { viewModel.reservationDetails?.guests ?? 2 },
                        set: { viewModel.reservationDetails?.guests = $0 }
                    )) {
                        ForEach(viewModel.guestOptions, id: \.self) { guests in
                            Text("\(guests)")
                        }
                    }
                }
                
                HStack {
                    Button("Cancel") {
                        if let start = viewModel.reservationStartTime {
                            let duration = Int(Date().timeIntervalSince1970 * 1000) - Int(start.timeIntervalSince1970 * 1000)
                            viewModel.detailsSpan?.setData(value: duration, key: "reservation.timing.total_duration")
                            viewModel.detailsSpan?.setData(value: "cancelled", key: "reservation.status")
                            viewModel.detailsSpan?.setData(value: "details", key: "reservation.cancel_step")
                        }
//                        viewModel.detailsSpan?.finish()
//                        viewModel.detailsSpan = nil
                        viewModel.reset()
                    }
                    .foregroundColor(.red)
                    Spacer()
                    Button("Continue to Payment") {
                        viewModel.paymentDetails = viewModel.randomPayment()
                        viewModel.path.append(.payment)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .navigationTitle("Details")
            .onAppear {
                if viewModel.detailsSpan == nil {
                    if let parent = SentrySDK.span {
                        viewModel.detailsSpan = parent.startChild(operation: "userflow.reservation", description: "Details step")
                    }
                }
            }
            .onDisappear {
                viewModel.detailsSpan?.finish()
                viewModel.detailsSpan = nil
            }
        }
	}
}
