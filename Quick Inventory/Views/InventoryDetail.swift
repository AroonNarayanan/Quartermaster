//
//  InventoryDetail.swift
//  Quartermaster
//
//  Created by Aroon Narayanan on 5/25/20.
//  Copyright © 2020 Aroon Narayanan. All rights reserved.
//

import SwiftUI

struct InventoryDetail: View {
    var inventoryItem: InventoryItem
    
    var body: some View {
        Form {
            Section(header: Text("Item Description")) {
                Text(inventoryItem.itemDescription ?? "")
            }
            Section(header: Text("Item Location")) {
                Text(inventoryItem.location?.name ?? "")
            }
            Section(header: Text("Item Attributes")) {
                ForEach(convertAttributesToArray(inventoryItem: inventoryItem), id: \.key) { inventoryAttribute in
                    HStack {
                        Text(inventoryAttribute.key ?? "")
                        Text(inventoryAttribute.value ?? "")
                    }
                }
            }
            Section(header: Text("Metadata")) {
                Text(createDateFormatter(inventoryItem: inventoryItem))
                    .navigationBarTitle(Text(inventoryItem.name ?? ""), displayMode: .inline)
            }
        }
    }
    
    func convertAttributesToArray(inventoryItem: InventoryItem) -> [InventoryAttribute] {
        let set = inventoryItem.attributes as? Set<InventoryAttribute> ?? []
        return set.sorted {
            $0.key ?? "" < $1.key ?? ""
        }
    }
}

struct InventoryDetail_Previews: PreviewProvider {
    static var previews: some View {
        InventoryDetail(inventoryItem: getSampleItemData()[0])
    }
}
