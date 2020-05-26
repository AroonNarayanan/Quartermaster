//
//  LocationRow.swift
//  Quartermaster
//
//  Created by Aroon Narayanan on 5/25/20.
//  Copyright © 2020 Aroon Narayanan. All rights reserved.
//

import SwiftUI

struct LocationRow: View {
    var location: Location
    
    var body: some View {
        HStack {
            Text(location.name ?? "")
            Spacer()
        }
    }
}

struct LocationRow_Previews: PreviewProvider {
    static var previews: some View {
        LocationRow(location: getSampleLocationData()[0])
    }
}
