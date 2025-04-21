//
//  TablePlan.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 28/01/2025.
//

import SwiftUI
import Foundation

@MainActor

struct TablePlan2View: View {
    @State private var appleProducts: [String] = ["iphone", "macbook.and.iphone", "ipad", "applewatch.watchface"]
    @State private var dropImage = Image(systemName: "square.and.arrow.down")
    @State var rectangleIsTargeted = false

    var body: some View {
        VStack {
            HStack {
                ForEach(appleProducts, id: \.self) { product in
                    Image(systemName: product)
                        .frame(minWidth: 50, minHeight: 50)
                        .background(.white)
                        .foregroundStyle(.black)
                        .cornerRadius(10)
                        .draggable(product)
                }
            }
            .frame(minWidth: 250, minHeight: 70)
            .cornerRadius(10)
            .background(.yellow)
            
            Text("Drop items here:")
            Rectangle()
            // we are lightening the rectange if someone is hovering over it with the expected payload
            // to help users know that this is a target they can drop something onto
            .foregroundStyle(.secondary.opacity(rectangleIsTargeted ? 0.3 : 1))
            .dropDestination(for: String.self) { items, location in
                guard let firstItem = items.first else {
                    // if we don't have anything in our first item,
                    // then something must have gone wrong and we want to let the system know
                    // so we return false
                    return false
                }
                
                print("firstItem:", firstItem)
                
                //if the drop was successful, we will want to return true
                return true
            } isTargeted: { isTargeted in
                // this lets our state variable know that our drop destination has been targeted
                // meaning that it could be about to recieve a transferrable object
                print(isTargeted)
            }
        }
    }
}




#Preview {
    TablePlan2View()
}
