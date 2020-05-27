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
            VStack {
            List {
                ForEach(locationList, id: \.id) { location in
                    LocationRow(location: location)
                }
                .onDelete(perform: deleteLocation)
            }
                Button("New Location") {
                    self.showAddPopover = true
                }.padding()
            }
            .navigationBarTitle(Text("Your Locations"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $showAddPopover) {
        LocationEditor(showSheet: self.$showAddPopover).environment(\.managedObjectContext, self.moc)
        }
    }
    
    func deleteLocation(at offsets: IndexSet) {
        for index in offsets {
            let location = locationList[index]
            moc.delete(location)
            try! moc.save()
        }
    }
}

struct LocationList_Previews: PreviewProvider {
    static var previews: some View {
        LocationList()
    }
}
