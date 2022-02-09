//
//  SwiftUIView.swift
//  
//
//  Created by Lincoln Anders on 2/7/22.
//

import SwiftUI

public struct ARListView<T: ARModel, Content> where Content : View  {
    @State var items: [T]?
    @State var error: String?
    var modifiers: (T) -> Content
    
    public init(_ dest: inout [T]?, @ViewBuilder _ content: @escaping (T) -> Content) {
        modifiers = content
    }
    
    func loadBody() async {
        items = await WebCommunicator.sendRequest(url: "http://192.168.1.151:3000/notifications.json", option: .get)
    }
    
    public var body: some View {
        ZStack {
            if items == nil {
                Text("Searching for notifications...")
                    .task { await loadBody() }
            } else if items!.count == 0 {
                Text("No notifications found.")
            } else {
                List(items ?? [T]()) { modifiers($0) }
                .refreshable { await loadBody() }
            }
        }
    }
}

//struct ARListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ARListView()
//    }
//}
