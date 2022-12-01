//
//  AppModel.swift
//  FurnishAR
//
//  Created by Tushar Kalra.
//

import Foundation

class AppModel: ObservableObject {
    
    //MARK: - Cart
    @Published var totalItems: Int = 0
    @Published var totalAmount: Int = 0
    @Published var cart: [Item] = []
    
    //MARK: - New Arrivals
    @Published var newItems = [ Item(name: "Hallingdal Chair", company: "Hay", rating: 5.0, price: 400, category: [.chair]),
                                Item(name: "Drawer Table", company: "Ikea", rating: 4.0, price: 560, category: [.table,.storage]),
                                Item(name: "Classic Table", company: "Hay", rating: 5.0, price: 600, category: [.table]),
                                Item(name: "Hallingdal Chair", company: "Hay", rating: 5.0, price: 400, category: [.chair])
                                
    ]
    
    //MARK: - All Items
    @Published var items = [ Item(name: "Hallingdal Chair", company: "Hay", rating: 5.0, price: 400, category: [.chair]),
                             Item(name: "Drawer Table", company: "Ikea", rating: 4.0, price: 560, category: [.table,.storage]),
                             Item(name: "Hallingdal Chair", company: "Hay", rating: 5.0, price: 400, category: [.chair]),
                             Item(name: "Classic Table", company: "Hay", rating: 5.0, price: 600, category: [.table]),
                             Item(name: "Hallingdal Chair", company: "Hay", rating: 5.0, price: 400, category: [.chair]),
                             Item(name: "Modern Table", company: "Ikea", rating: 4.0, price: 760, category: [.table,.storage]),
                             Item(name: "Hallingdal Chair", company: "Hay", rating: 5.0, price: 400, category: [.chair]),
                             Item(name: "Table", company: "Hayde", rating: 3.0, price: 200, category: [.table]),
                             Item(name: "Hallingdal Chair", company: "Hay", rating: 5.0, price: 400, category: [.chair]),
                             Item(name: "Hallingdal Chair", company: "Hay", rating: 5.0, price: 400, category: [.chair]),
    ]
    
    //MARK: - Filter items
    func filterItems(by category: ItemCategory) -> [Item]{
        items.filter{$0.category.contains(category)}
    }
}
