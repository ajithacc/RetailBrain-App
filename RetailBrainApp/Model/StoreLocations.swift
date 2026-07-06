//
//  StoreLocations.swift
//  RetailBrainApp
//
//  Created by ajith.a.s on 24/06/26.
//

import Foundation
import RetailBrainSDK

struct StoreLocations {
    static let singleFloorShoppingItems: [ShoppingItem] = [
        ShoppingItem(name: "Washroom", storeName: "Washroom", description: "Restrooms & facilities"),
        ShoppingItem(name: "Butcher", storeName: "Butcher", description: "Fresh meat & butcher products"),
        ShoppingItem(name: "Seafood", storeName: "Seafood", description: "Fresh seafood section"),
        ShoppingItem(name: "Cafe", storeName: "Cafe", description: "Cafe & dining area"),
        ShoppingItem(name: "Milk", storeName: "Dairy", description: "Fresh milk & dairy products"),
        ShoppingItem(name: "Cake", storeName: "Bakery", description: "Fresh baked cakes & pastries"),
        ShoppingItem(name: "Biscuits", storeName: "Bakery", description: "Cookies & biscuits"),
        ShoppingItem(name: "Popcorn", storeName: "Snacks", description: "Popcorn & snacks"),
        ShoppingItem(name: "Chips", storeName: "Snacks", description: "Chips & crisps"),
        ShoppingItem(name: "Tomato Paste", storeName: "Pantry", description: "Tomato paste & sauces"),
        ShoppingItem(name: "Olive Oil", storeName: "Pantry", description: "Olive oil & cooking oils"),
        ShoppingItem(name: "Flour", storeName: "Pantry", description: "Flour & baking supplies"),
        ShoppingItem(name: "Sugar", storeName: "Pantry", description: "Sugar & sweeteners"),
        ShoppingItem(name: "Jam", storeName: "Pantry", description: "Jams & preserves"),
        ShoppingItem(name: "Bulgur", storeName: "Pantry", description: "Bulgur & grains"),
        ShoppingItem(name: "Oatmeal", storeName: "Pantry", description: "Oatmeal & cereals"),
        ShoppingItem(name: "Bleach", storeName: "Household", description: "Cleaning supplies"),
        ShoppingItem(name: "Mop", storeName: "Household", description: "Cleaning tools"),
        ShoppingItem(name: "Lotion", storeName: "Health & Beauty", description: "Lotions & skincare"),
        ShoppingItem(name: "Parking", storeName: "Parking", description: "Parking area")
    ]

    static let multiFloorShoppingItems: [ShoppingItem] = [
        ShoppingItem(name: "Apple Store", storeName: "Apple Store", description: "Latest Apple devices & accessories"),
        ShoppingItem(name: "Nike", storeName: "Nike", description: "Sportswear & footwear"),
        ShoppingItem(name: "Adidas", storeName: "Adidas", description: "Athletic apparel & shoes"),
        ShoppingItem(name: "Zara", storeName: "Zara", description: "Fashion clothing"),
        ShoppingItem(name: "H&M", storeName: "H&M", description: "Casual fashion & accessories"),
        ShoppingItem(name: "Levi's", storeName: "Levi's", description: "Denim & casual wear"),
        ShoppingItem(name: "Puma", storeName: "Puma", description: "Sports apparel & shoes"),
        ShoppingItem(name: "Sephora", storeName: "Sephora", description: "Beauty & cosmetics"),
        ShoppingItem(name: "MAC Cosmetics", storeName: "MAC", description: "Professional makeup products"),
        ShoppingItem(name: "Starbucks", storeName: "Starbucks", description: "Coffee & beverages"),
        ShoppingItem(name: "McDonald's", storeName: "McDonald's", description: "Fast food restaurant"),
        ShoppingItem(name: "KFC", storeName: "KFC", description: "Fried chicken restaurant"),
        ShoppingItem(name: "Subway", storeName: "Subway", description: "Sandwiches & salads"),
        ShoppingItem(name: "Pizza Hut", storeName: "Pizza Hut", description: "Pizza & pasta"),
        ShoppingItem(name: "Book Store", storeName: "Book World", description: "Books & stationery"),
        ShoppingItem(name: "Toys Store", storeName: "Toy Planet", description: "Kids toys & games"),
        ShoppingItem(name: "Kids Zone", storeName: "Kids Zone", description: "Indoor play area"),
        ShoppingItem(name: "Cinema", storeName: "Multiplex", description: "Movie theatre"),
        ShoppingItem(name: "Gaming Zone", storeName: "Game Arena", description: "Arcade & VR games"),
        ShoppingItem(name: "ATM", storeName: "Bank ATM", description: "Cash withdrawal"),
        ShoppingItem(name: "Information Desk", storeName: "Information", description: "Customer assistance"),
        ShoppingItem(name: "Washroom", storeName: "Washroom", description: "Restrooms & facilities"),
        ShoppingItem(name: "Escalator", storeName: "Escalator", description: "Access to upper floors"),
        ShoppingItem(name: "Parking", storeName: "Parking", description: "Parking area"),
        ShoppingItem(name: "Call it Spring", storeName: "Call it Spring", description: "Call It Spring is your go-to destination for all things footwear, handbags and accessories."),
        ShoppingItem(name: "Caryl Baker Visage", storeName: "Caryl Baker Visage", description: "Professional beauty, skincare and makeup."),
        ShoppingItem(name: "Build-A-Bear Workshop", storeName: "Build-A-Bear Workshop", description: "Create your own custom teddy bears and soft toys."),
        ShoppingItem(name: "Tommy Gun's Original Barbershop", storeName: "Tommy Gun's Original Barbershop", description: "Premium men's grooming and barber services."),
        ShoppingItem(name: "Perfumes 4 U", storeName: "Perfumes 4 U", description: "Designer fragrances and gifts."),
        ShoppingItem(name: "Swatch", storeName: "Swatch", description: "Swiss watches and accessories."),
        ShoppingItem(name: "Koodo Mobile", storeName: "Koodo Mobile", description: "Mobile phones and wireless plans."),
        ShoppingItem(name: "Attrattivo", storeName: "Attrattivo", description: "Women's fashion and accessories."),
        ShoppingItem(name: "Planta", storeName: "Planta", description: "Plant-based restaurant."),
        ShoppingItem(name: "Coles", storeName: "Coles", description: "Books, gifts and stationery."),
        ShoppingItem(name: "INDOCHINO", storeName: "INDOCHINO", description: "Custom men's suits."),
        ShoppingItem(name: "Venus Home Furnishings", storeName: "Venus Home Furnishings", description: "Furniture and home decor."),
        ShoppingItem(name: "Champs Sports", storeName: "Champs Sports", description: "Sports apparel and footwear."),
        ShoppingItem(name: "Patrizia Pepe", storeName: "Patrizia Pepe", description: "Luxury fashion."),
        ShoppingItem(name: "Zuri", storeName: "Zuri", description: "Women's clothing."),
        ShoppingItem(name: "Geox", storeName: "Geox", description: "Comfort footwear."),
        ShoppingItem(name: "Garage", storeName: "Garage", description: "Casual fashion."),
        ShoppingItem(name: "Eddie Bauer", storeName: "Eddie Bauer", description: "Outdoor apparel."),
        ShoppingItem(name: "Kiehl's Since 1851", storeName: "Kiehl's", description: "Skin care and cosmetics."),
        ShoppingItem(name: "Eternal By Ajmal", storeName: "Ajmal", description: "Luxury perfumes."),
        ShoppingItem(name: "R.U.A. Sports Fanatic", storeName: "R.U.A. Sports Fanatic", description: "Sports merchandise."),
        ShoppingItem(name: "Peoples", storeName: "Peoples", description: "Jewellery and diamonds."),
        ShoppingItem(name: "Fossil", storeName: "Fossil", description: "Watches and lifestyle accessories.")
    ]

    static func shoppingItems(for mode: MapNavigationMode) -> [ShoppingItem] {
        switch mode {
        case .singleFloor:
            return singleFloorShoppingItems
        case .multiFloor:
            return multiFloorShoppingItems
        }
    }

    static func setupStoreShoppingItems(for mode: MapNavigationMode) {
        ShoppingItemsProvider.shared.setCustomItems(shoppingItems(for: mode))
    }
}
