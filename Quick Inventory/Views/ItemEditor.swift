//
//  NewItem.swift
//  Quick Inventory
//
//  Created by Aroon Narayanan on 5/25/20.
//  Copyright © 2020 Aroon Narayanan. All rights reserved.
//

import SwiftUI

struct ItemEditor: View {
    @Environment(\.managedObjectContext) var moc
    
    //    private var inventoryItem: InventoryItem
    @Binding var showSheet: Bool
    
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var showAlert = false
    @State private var locationIndex = 0
    @State private var locationName = ""
    
    @State private var attributes: Dictionary<String, String> = [:]
    @State private var attributeKey = ""
    @State private var attributeValue = ""
    
    @FetchRequest(entity: Location.entity(), sortDescriptors: []) var locationList: FetchedResults<Location>
    
    //    init(inventoryItem: InventoryItem, showSheet: Binding<Bool>) {
    //        self.inventoryItem = inventoryItem
    //        self._showSheet = showSheet
    //        self.name = inventoryItem.name ?? ""
    //        self.description = inventoryItem.description
    //    }
    //
    init(showSheet: Binding<Bool>) {
        //        self.inventoryItem = InventoryItem(context: self.moc)
        self._showSheet = showSheet
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section
                    {
                        TextField("Item Name", text: $name)
                        TextField("Item Description", text: $description)
                }
                self.locationPicker()
                Section(header: Text("Attributes")) {
                    ForEach(attributes.sorted(by: >), id: \.key) { key, value in
                        HStack {
                            Text(key)
                            Text(value)
                        }
                    }
                    HStack {
                        TextField("Attribute Name", text: $attributeKey)
                        TextField("Attribute Value", text: $attributeValue)
                    }
                    Button("Add Attribute") {
                        self.addAttribute()
                    }
                }
            }
            .navigationBarTitle(Text("New Item"))
            .navigationBarItems(leading: Button("Close") {
                self.showSheet.toggle()
                } ,trailing: Button("Save"){
                    self.saveItem()
            })
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error saving item - please try again."))
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func addAttribute() {
        if (self.attributeKey.count > 0) {
            self.attributes[self.attributeKey] = self.attributeValue
            self.attributeKey = ""
            self.attributeValue = ""
        }
    }
    
    func saveAttribute(attributeKey: String, attributeValue: String, inventoryItemId: UUID) {
        let attribute = InventoryAttribute(context: self.moc)
        attribute.id = UUID()
        attribute.itemId = inventoryItemId
        attribute.key = attributeKey
        attribute.value = attributeValue
    }
    
    func saveItem() {
        let inventoryItem = InventoryItem(context: self.moc)
        inventoryItem.id = UUID()
        inventoryItem.name = self.name
        inventoryItem.itemDescription = self.description
        if (self.locationList.count > 0) {
            inventoryItem.location = self.locationList[self.locationIndex]
        }
        inventoryItem.dateCreated = Date()
        self.attributes.forEach { key, value in
            self.saveAttribute(attributeKey: key, attributeValue: value, inventoryItemId: inventoryItem.id!)
        }
        do {
            try self.moc.save()
            self.showSheet.toggle()
        } catch {
            print(error)
            self.showAlert = true
        }
    }
    
    func locationPicker() -> some View {
        return Section {
            if (locationList.count > 0) {
                Picker(selection: self.$locationIndex, label: Text("Item Location")) {
                    ForEach(locationList, id: \.id) { location in
                        Text(location.name ?? "")
                    }
                }
            } else {
                EmptyView()
            }
        }
    }
}

struct NewItem_Previews: PreviewProvider {
    static var previews: some View {
        ItemEditor(showSheet: .constant(true))
    }
}
