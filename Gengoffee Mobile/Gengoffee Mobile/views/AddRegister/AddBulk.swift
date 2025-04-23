//
//  AddBulk.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 22/02/2025.
//

import Foundation
import SwiftUI
import SwiftData

struct AddBulk: View {
    @State var session:MainModel
    @State var idEvent:Int = 0
    @State var result:Any = 0

    @State var text:String = "Japonais\nShiori\nMayu\n\nFrançais\nAlan\nJules\n\nハーフ\nDaigo"
    @State private var typeList:String = "jp"
    @State private var pastedText = "Tap 'Paste' to see clipboard text"

    
    
    var body: some View {
        VStack{
            Button{
                do {
                    text = UIPasteboard.general.string ?? ""
                }
            }label: {designButton(icon: "arrow.right.doc.on.clipboard", text: "Paste Clipboard")}
            
            Text("Add Bulk")
                .font(.system(size: 36))
            TextEditor(
                text:$text
            )
            .border(.secondary)
            .frame(width: 340, height: 400)
            .cornerRadius(8)
            .lineLimit(5...150)
            
            Button{
                do {
                    if(session.token != "1"){
                        addTemporaryAttendee(message: temporaryAttendees(
                            type:1,
                            attendees:SplitName(text:text, typeList: &typeList, idEvent:idEvent)
                        ), token:session.token, completion: { success in
                            print(success)
                        })
                    }
                    let encoder = JSONEncoder()
                    if let encoded = try? encoder.encode(SplitName(text:text, typeList: &typeList, idEvent:idEvent)) {
                        UserDefaults.standard.set(encoded, forKey: "attendees")
                    }
                }
                
            }label: {designButton(icon: "person.fill.badge.plus", text: "Add Users")}
        }
        .onTapGesture {
            hideKeyboard()
        }
    } //body

} //struct

#Preview {
    struct Preview: View {
        @State var session: MainModel = MainModel(events: [blankEvent], attendees: getLocalAttendees(), selectedTab: .checkIn, token:"")
        var body: some View {
            //ContentView(events:events, attendees:attendees)
            AddBulk(session: session)
        }
    }
    return Preview()
}
