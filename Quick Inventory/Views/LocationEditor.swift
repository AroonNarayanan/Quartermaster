//
//  LocationEditor.swift
//  Quartermaster
//
//  Created by Aroon Narayanan on 5/25/20.
//  Copyright © 2020 Aroon Narayanan. All rights reserved.
//

import SwiftUI

struct LocationEditor: View {
    @Environment(\.managedObjectContext) var moc
    
    @Binding var showSheet: Bool
    
    @State private var name: String = ""
    @State private var showAlert = false
        
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Location Name", text: $name)
                }
            }
            .navigationBarTitle(Text("New Location"))
            .navigationBarItems(leading: Button("Close") {
                self.showSheet.toggle()
                },trailing: Button("Save"){
                    self.saveLocation()
            })
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error saving location - please try again."))
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func saveLocation() {
        let location = Location(context: self.moc)
        location.id = UUID()
        location.name = self.name
        do {
            try self.moc.save()
            self.showSheet.toggle()
        } catch {
            print(error)
            self.showAlert = true
        }
    }
}

struct LocationEditor_Previews: PreviewProvider {
    static var previews: some View {
        LocationEditor(showSheet: .constant(true))
    }
}
