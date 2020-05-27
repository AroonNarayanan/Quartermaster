//
//  ContentView.swift
//  Quick Inventory
//
//  Created by Aroon Narayanan on 5/25/20.
//  Copyright © 2020 Aroon Narayanan. All rights reserved.
//

import SwiftUI

struct InventoryList: View {
    @State private var showAddPopover: Bool = false
    @State private var showShareSheet: Bool = false
    @State private var showAlert: Bool = false
    @State private var shareURL: URL?
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: InventoryItem.entity(), sortDescriptors: []) var inventoryList: FetchedResults<InventoryItem>
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(inventoryList, id: \.id) { inventoryItem in
                        NavigationLink(destination: InventoryDetail(inventoryItem: inventoryItem)) {
                            InventoryRow(inventoryItem: inventoryItem)
                        }
                    }
                    .onDelete(perform: deleteItem)
                }
                Button("New Item") {
                    self.showAddPopover = true
                }.padding()
            }
            .navigationBarTitle(Text("Your Items"))
            .navigationBarItems(trailing:
                Button(action: {
                    do {
                        try self.shareURL = createCSVFile(inventoryList: self.inventoryList)
                        self.showShareSheet = true
                    } catch {
                        print(error)
                        self.showAlert = true
                    }
                }){
                    Image(systemName: "square.and.arrow.up")
                }
                .sheet(isPresented: $showShareSheet){
                    ShareSheet(sharing: [self.shareURL!])
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("We ran into an issue creating a file for you to share."))
                }
            )
                .sheet(isPresented: $showAddPopover) {
                    ItemEditor(showSheet: self.$showAddPopover).environment(\.managedObjectContext, self.moc)
            }
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            let inventoryItem = inventoryList[index]
            moc.delete(inventoryItem)
            try! moc.save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryList()
    }
}
