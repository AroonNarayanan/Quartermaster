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
    var attributeFetchRequest: FetchRequest<InventoryAttribute>
    @FetchRequest(entity: Location.entity(), sortDescriptors: []) var locationList: FetchedResults<Location>
    
    init(inventoryItem: InventoryItem) {
        self.inventoryItem = inventoryItem
        attributeFetchRequest = FetchRequest<InventoryAttribute>(entity: InventoryAttribute.entity(), sortDescriptors: [], predicate: NSPredicate(format: "id == %@", inventoryItem.id! as CVarArg))
    }
    
    var body: some View {
        Form {
            Section(header: Text("Item Description")) {
                Text(inventoryItem.itemDescription ?? "")
            }
            Section(header: Text("Item Location")) {
                Text(inventoryItem.location?.name ?? "")
            }
            Section(header: Text("Item Attributes")) {
                ForEach(attributeFetchRequest.wrappedValue, id: \.id) { inventoryAttribute in
//                    HStack {
//                        Text(inventoryAttribute.key)
//                        Text(inventoryAttribute.value)
//                    }
                    Text("stack")
                }
            }
            Section(header: Text("Metadata")) {
                Text(createDateFormatter(inventoryItem: inventoryItem))
                    .navigationBarTitle(Text(inventoryItem.name ?? ""), displayMode: .inline)
            }
        }
    }
}

struct InventoryDetail_Previews: PreviewProvider {
    static var previews: some View {
        InventoryDetail(inventoryItem: getSampleItemData()[0])
    }
}
