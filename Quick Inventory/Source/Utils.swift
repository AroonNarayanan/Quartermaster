//
//  Utils.swift
//  Quartermaster
//
//  Created by Aroon Narayanan on 5/25/20.
//  Copyright © 2020 Aroon Narayanan. All rights reserved.
//

import Foundation
import CSV
import SwiftUI

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

func createCSVFile(inventoryList: FetchedResults<InventoryItem>) throws -> URL {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMddhhmmss"
    let fileName = "inventory-\(dateFormatter.string(from: Date())).csv"
    let fileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
    let csvStream = OutputStream(toFileAtPath: fileURL.path, append: false)
    let csv = try CSVWriter(stream: csvStream!)
    try csv.write(row: ["Item ID", "Item Name", "Item Description", "Item Location", "Date Created"])
    dateFormatter.dateFormat = "MM/dd/yyyy h:mm:ss a"
    try inventoryList.forEach { inventoryItem in
        try csv.write(row: [inventoryItem.id?.uuidString ?? "", inventoryItem.name ?? "", inventoryItem.itemDescription ?? "", inventoryItem.location?.name ?? "", dateFormatter.string(from: inventoryItem.dateCreated ?? Date())])
    }
    csv.stream.close()
    return fileURL
}

// MARK: share sheet shim
// copied from stack overflow, so god help me
struct ShareSheet: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIActivityViewController

    var sharing: [Any]

    func makeUIViewController(context: UIViewControllerRepresentableContext<ShareSheet>) -> UIActivityViewController {
        UIActivityViewController(activityItems: sharing, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ShareSheet>) {

    }
}
