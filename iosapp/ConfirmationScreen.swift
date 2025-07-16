import SwiftUI
import SentrySwiftUI
import Sentry

struct ConfirmationScreen: View {
	@EnvironmentObject var viewModel: AppViewModel

	var body: some View {
        SentryTracedView("ConfirmationScreen"){
            Form {
                Section(header: Text("Restaurant")) {
                    Text(viewModel.selectedRestaurant?.name ?? "")
                    Text(viewModel.selectedRestaurant?.description ?? "")
                    Text(viewModel.selectedRestaurant?.address ?? "")
                }
                Section(header: Text("Reservation")) {
                    if let details = viewModel.reservationDetails {
                        Text("Date: \(details.date.formatted(date: .abbreviated, time: .omitted))")
                        Text("Time: \(details.time)")
                        Text("Guests: \(details.guests)")
                    }
                }
                Section(header: Text("Payment")) {
                    if let payment = viewModel.paymentDetails {
                        Text("Card Type: \(payment.cardType)")
                        Text("Card Number: \(payment.cardNumber)")
                        Text("Expiry: \(payment.expiry)")
                        Text("CVV: \(payment.cvv)")
                    }
                }
                HStack {
                    Button("Cancel") {
                        if let start = viewModel.reservationStartTime {
                            let duration = Int(Date().timeIntervalSince1970 * 1000) - Int(start.timeIntervalSince1970 * 1000)
                            viewModel.confirmationSpan?.setData(value: duration, key: "reservation.timing.total_duration")
                            viewModel.confirmationSpan?.setData(value: "cancelled", key: "reservation.status")
                            viewModel.confirmationSpan?.setData(value: "confirmation", key: "reservation.cancel_step")
                        }
                        viewModel.confirmationSpan?.finish()
                        viewModel.confirmationSpan = nil
                        viewModel.reset()
                    }
                    .foregroundColor(.red)
                    Spacer()
                    Button("Confirm Reservation") {
                        if let start = viewModel.reservationStartTime {
                            let duration = Int(Date().timeIntervalSince1970 * 1000) - Int(start.timeIntervalSince1970 * 1000)
                            viewModel.confirmationSpan?.setData(value: duration, key: "reservation.timing.total_duration")
                            viewModel.confirmationSpan?.setData(value: "completed", key: "reservation.status")
                        }
                        viewModel.confirmationSpan?.finish()
                        viewModel.confirmationSpan = nil
                        viewModel.showConfirmationPopup = true
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .navigationTitle("Confirmation")
            .onAppear {
                if viewModel.confirmationSpan == nil {
                    if let parent = SentrySDK.span {
                        viewModel.confirmationSpan = parent.startChild(operation: "userflow.reservation", description: "Confirmation Step")
                    }
                }
            }
            .onDisappear {
                viewModel.confirmationSpan?.finish()
                viewModel.confirmationSpan = nil
            }
         }
	}
} 
