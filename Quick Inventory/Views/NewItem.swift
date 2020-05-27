//
//  NewItem.swift
//  Quick Inventory
//
//  Created by Aroon Narayanan on 5/25/20.
//  Copyright © 2020 Aroon Narayanan. All rights reserved.
//

import SwiftUI

struct ItemEditor: View {
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        NavigationView {
            VStack() {
                TextField("Item Name", text: $name)
                TextField("Item Description", text: $description)
                Spacer()
            }.padding()
                .navigationBarTitle(Text("New Item"))
                .navigationBarItems(trailing: Button("Save"){
                    let inventoryItem = InventoryItem(context: self.moc)
                    inventoryItem.id = UUID()
                    inventoryItem.name = self.name
                    inventoryItem.itemDescription = self.description
                    do {
                        try self.moc.save()
                        self.presentation.wrappedValue.dismiss()
                    } catch {
                        print(error)
                        self.showAlert = true
                    }
                })
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error saving item - please try again."))
            }
        }
    }
}

struct NewItem_Previews: PreviewProvider {
    static var previews: some View {
        ItemEditor()
    }
}
