//
//  Utils.swift
//  Quartermaster
//
//  Created by Aroon Narayanan on 5/25/20.
//  Copyright © 2020 Aroon Narayanan. All rights reserved.
//

import Foundation

func getSampleItemData() -> [InventoryItem] {
    let macbook = InventoryItem()
    macbook.id = UUID()
    macbook.name = "Macbook"
    macbook.itemDescription = "Apple laptop"
    return [macbook]
}

func getSampleLocationData() -> [Location] {
    let basement = Location()
    basement.id = UUID()
    basement.name = "Basement"
    return [basement]
}

func createDateFormatter(inventoryItem: InventoryItem) -> String {
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    timeFormatter.dateFormat = "h:mm a"
    let formattedDate = inventoryItem.dateCreated != nil
        ? "on \(dateFormatter.string(from: inventoryItem.dateCreated!)) at \(timeFormatter.string(from: inventoryItem.dateCreated!))"
        : "at an unknown time"
    return "Created \(formattedDate)"
}
