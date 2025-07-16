import Foundation

struct Restaurant: Identifiable, Equatable, Hashable {
	let id: UUID
	let name: String
	let description: String
	let address: String
	let imageName: String
}

let mockRestaurants: [Restaurant] = [
	Restaurant(id: UUID(), name: "Sunset Grill", description: "Cozy spot for breakfast and brunch.", address: "123 Ocean Ave", imageName: "photo"),
	Restaurant(id: UUID(), name: "Urban Eats", description: "Trendy downtown bistro.", address: "456 City St", imageName: "photo"),
	Restaurant(id: UUID(), name: "Pasta Palace", description: "Authentic Italian cuisine.", address: "789 Pasta Rd", imageName: "photo"),
	Restaurant(id: UUID(), name: "Sushi World", description: "Fresh sushi and sashimi.", address: "321 Fish Ln", imageName: "photo"),
	Restaurant(id: UUID(), name: "Burger Barn", description: "Classic American burgers.", address: "654 Grill Dr", imageName: "photo"),
	Restaurant(id: UUID(), name: "Taco Town", description: "Mexican street food.", address: "987 Fiesta Ave", imageName: "photo"),
	Restaurant(id: UUID(), name: "Curry House", description: "Spicy Indian flavors.", address: "135 Spice St", imageName: "photo"),
	Restaurant(id: UUID(), name: "Green Leaf", description: "Vegetarian and vegan options.", address: "246 Garden Rd", imageName: "photo"),
	Restaurant(id: UUID(), name: "Steakhouse Prime", description: "Premium steaks and wine.", address: "357 Beef Blvd", imageName: "photo"),
	Restaurant(id: UUID(), name: "Sea Breeze", description: "Seafood with a view.", address: "468 Harbor St", imageName: "photo"),
	Restaurant(id: UUID(), name: "Pizza Planet", description: "Wood-fired pizzas.", address: "579 Cheese Ct", imageName: "photo"),
	Restaurant(id: UUID(), name: "Noodle Nook", description: "Asian noodle dishes.", address: "680 Wok Way", imageName: "photo"),
] 