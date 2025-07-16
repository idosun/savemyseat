import SwiftUI
import SentrySwiftUI
import Sentry

struct PaymentScreen: View {
	@EnvironmentObject var viewModel: AppViewModel

	var body: some View {
        SentryTracedView("PaymentScreen"){
            Form {
                Section(header: Text("Payment Details")) {
                    Picker("Card Type", selection: Binding(
                        get: { viewModel.paymentDetails?.cardType ?? viewModel.cardTypes[0] },
                        set: { viewModel.paymentDetails?.cardType = $0 }
                    )) {
                        ForEach(viewModel.cardTypes, id: \.self) { type in
                            Text(type)
                        }
                    }
                    
                    TextField("Card Number", text: Binding(
                        get: { viewModel.paymentDetails?.cardNumber ?? "" },
                        set: { viewModel.paymentDetails?.cardNumber = $0 }
                    ))
                    .keyboardType(.numberPad)
                    
                    TextField("Expiry", text: Binding(
                        get: { viewModel.paymentDetails?.expiry ?? "" },
                        set: { viewModel.paymentDetails?.expiry = $0 }
                    ))
                    .keyboardType(.numbersAndPunctuation)
                    
                    TextField("CVV", text: Binding(
                        get: { viewModel.paymentDetails?.cvv ?? "" },
                        set: { viewModel.paymentDetails?.cvv = $0 }
                    ))
                    .keyboardType(.numberPad)
                }
                
                HStack {
                    Button("Cancel") {
                        if let start = viewModel.reservationStartTime {
                            let duration = Int(Date().timeIntervalSince1970 * 1000) - Int(start.timeIntervalSince1970 * 1000)
                            viewModel.paymentSpan?.setData(value: duration, key: "reservation.timing.total_duration")
                            viewModel.paymentSpan?.setData(value: "cancelled", key: "reservation.status")
                            viewModel.paymentSpan?.setData(value: "payment", key: "reservation.cancel_step")
                        }
                        viewModel.paymentSpan?.finish()
                        viewModel.paymentSpan = nil
                        viewModel.reset()
                    }
                    .foregroundColor(.red)
                    Spacer()
                    Button("Continue to Confirmation") {
                        viewModel.paymentSpan?.finish()
                        viewModel.paymentSpan = nil
                        viewModel.path.append(.confirmation)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .navigationTitle("Payment")
            .onAppear {
                if viewModel.paymentSpan == nil {
                    if let parent = SentrySDK.span {
                        viewModel.paymentSpan = parent.startChild(operation: "userflow.reservation", description: "Payment step")
                    }
                }
            }
            .onDisappear {
                viewModel.paymentSpan?.finish()
                viewModel.paymentSpan = nil
            }
        }
	}
} 
