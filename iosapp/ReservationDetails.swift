import Foundation

struct ReservationDetails {
	var date: Date
	var time: String
	var guests: Int
}

struct PaymentDetails {
	var cardType: String
	var cardNumber: String
	var expiry: String
	var cvv: String
} 