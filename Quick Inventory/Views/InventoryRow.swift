//
//  InventoryRow.swift
//  Quick Inventory
//
//  Created by Aroon Narayanan on 5/25/20.
//  Copyright © 2020 Aroon Narayanan. All rights reserved.
//

import SwiftUI

struct InventoryRow: View {
    var inventoryItem: InventoryItem
    
    var body: some View {
        HStack {
            Text(inventoryItem.name ?? "")
            Spacer()
        }
    }
}

struct InventoryRow_Previews: PreviewProvider {
    static var previews: some View {
        InventoryRow(inventoryItem: getSampleItemData()[0])
    }
}
