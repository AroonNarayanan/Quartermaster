//
//  LocationList.swift
//  Quartermaster
//
//  Created by Aroon Narayanan on 5/25/20.
//  Copyright © 2020 Aroon Narayanan. All rights reserved.
//

import SwiftUI

struct LocationList: View {
    @State private var showAddPopover: Bool = false
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Location.entity(), sortDescriptors: []) var locationList: FetchedResults<Location>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(locationList, id: \.id) { location in
                    LocationRow(location: location)
                }
                .onDelete(perform: deleteItem)
            }
            .navigationBarTitle(Text("Your Locations"))
            .navigationBarItems( trailing: Button(action: {
                self.showAddPopover = true
            }){
                Image(systemName: "plus")
            }.sheet(isPresented: $showAddPopover) {
                LocationEditor().environment(\.managedObjectContext, self.moc)
                }
            )
        } .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            let location = locationList[index]
            moc.delete(location)
        }
    }
}

struct LocationList_Previews: PreviewProvider {
    static var previews: some View {
        LocationList()
    }
}