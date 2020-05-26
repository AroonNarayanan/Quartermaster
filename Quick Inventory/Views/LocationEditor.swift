//
//  LocationEditor.swift
//  Quartermaster
//
//  Created by Aroon Narayanan on 5/25/20.
//  Copyright © 2020 Aroon Narayanan. All rights reserved.
//

import SwiftUI

struct LocationEditor: View {
    @State private var name: String = ""
    @State private var showAlert = false
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Location Name", text: $name)
                }
            }
            .navigationBarTitle(Text("New Location"))
            .navigationBarItems(trailing: Button("Save"){
                let location = Location(context: self.moc)
                location.id = UUID()
                location.name = self.name
                do {
                    try self.moc.save()
                    self.presentation.wrappedValue.dismiss()
                } catch {
                    print(error)
                    self.showAlert = true
                }
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error saving location - please try again."))
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct LocationEditor_Previews: PreviewProvider {
    static var previews: some View {
        LocationEditor()
    }
}
