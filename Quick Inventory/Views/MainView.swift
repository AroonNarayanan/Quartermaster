//
//  MainView.swift
//  Quartermaster
//
//  Created by Aroon Narayanan on 5/25/20.
//  Copyright © 2020 Aroon Narayanan. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            InventoryList()
                .tabItem {
                    Text("Inventory Items")
                    Image(systemName: "cube.box.fill")
            }
            LocationList()
                .tabItem {
                    Text("Locations")
                    Image(systemName: "map.fill")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
