//
//  StoreLocations.swift
//  RetailBrainApp
//
//  Created by ajith.a.s on 24/06/26.
//

import Foundation
import RetailBrainSDK

struct StoreLocations {
    static let shoppingItems: [ShoppingItem] = [
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

    static func setupStoreShoppingItems() {
        ShoppingItemsProvider.shared.setCustomItems(shoppingItems)
    }
}
