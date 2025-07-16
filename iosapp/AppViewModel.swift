import Foundation
import SwiftUI
import Sentry

class AppViewModel: ObservableObject {
	@Published var restaurants: [Restaurant] = mockRestaurants
	@Published var searchText: String = ""
	@Published var selectedRestaurant: Restaurant?
	@Published var reservationDetails: ReservationDetails?
	@Published var paymentDetails: PaymentDetails?
	@Published var showConfirmationPopup: Bool = false

	@Published var path: [Screen] = []

	enum Screen: Hashable {
		case details(Restaurant)
		case payment
		case confirmation
	}

	let times = (10...23).map { String(format: "%02d:00", $0) }
	let guestOptions = Array(2...10)
	let cardTypes = ["Visa", "MasterCard", "Amex"]

	// Sentry child spans for tracing
	var detailsSpan: Span?
	var paymentSpan: Span?
	var confirmationSpan: Span?

	// Reservation flow timing
	var reservationStartTime: Date?
	var reservationDurationMs: Int?

	func randomReservation(for restaurant: Restaurant) -> ReservationDetails {
		let randomDate = Calendar.current.date(byAdding: .day, value: Int.random(in: 1...30), to: Date())!
		let randomTime = times.randomElement()!
		let randomGuests = guestOptions.randomElement()!
		return ReservationDetails(date: randomDate, time: randomTime, guests: randomGuests)
	}

	func randomPayment() -> PaymentDetails {
		let cardType = cardTypes.randomElement()!
		let cardNumber = String((0..<16).map { _ in "0123456789".randomElement()! })
		let expiry = String(format: "%02d/%02d", Int.random(in: 1...12), Int.random(in: 25...29))
		let cvv = String(format: "%03d", Int.random(in: 100...999))
		return PaymentDetails(cardType: cardType, cardNumber: cardNumber, expiry: expiry, cvv: cvv)
	}

	func reset() {
		selectedRestaurant = nil
		reservationDetails = nil
		paymentDetails = nil
		showConfirmationPopup = false
		path = []
		detailsSpan?.finish(); detailsSpan = nil
		paymentSpan?.finish(); paymentSpan = nil
		confirmationSpan?.finish(); confirmationSpan = nil
		reservationStartTime = nil
		reservationDurationMs = nil
	}
} 