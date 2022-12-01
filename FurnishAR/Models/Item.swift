//
//  Item.swift
//  FurnishAR
//
//  Created by Tushar Kalra.
//

import Foundation
import SwiftUI

//MARK: - Item Category
enum ItemCategory: String, CaseIterable{
    
    case chair = "Chairs"
    case table = "Tables"
    case bed = "Beds"
    case storage = "Storage"
}

extension ItemCategory: Identifiable{
    var id: String {
        self.rawValue
    }
}

//MARK: - Item
struct Item: Identifiable {
    
    var id = UUID()
    let name: String
    let description: String = "A chair with a high back will provide optimum comfort. The fashionable design will allow you to decorate any room"
    let company: String
    let rating: Float
    let price: Int
    let category: [ItemCategory]
}


