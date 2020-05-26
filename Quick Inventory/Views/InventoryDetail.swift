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
        VStack{
            VStack {
                Text(inventoryItem.itemDescription ?? "")
                Text(inventoryItem.location?.name ?? "")
                Spacer()
            }
            Text(createDateFormatter(inventoryItem: inventoryItem))
                .navigationBarTitle(Text(inventoryItem.name ?? ""), displayMode: .inline)
        }
        .padding()
    }
}

struct InventoryDetail_Previews: PreviewProvider {
    static var previews: some View {
        InventoryDetail(inventoryItem: getSampleItemData()[0])
    }
}
