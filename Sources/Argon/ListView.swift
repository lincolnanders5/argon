//
//  ListView.swift
//  
//
//  Created by Lincoln Anders on 2/7/22.
//

import SwiftUI
import PublishedObject
import os.log

public class ARListView<T: ARModel, Content> where Content : View  {
    @State var items: [T]?
    var modifier: (T) -> Content
    var action  : Optional<() async -> Void>
    
    public init(_ items: [T]?,
                @ViewBuilder content modifier: @escaping (T) -> Content,
                populate action: @escaping @Sendable () async -> Void)
    {
        self.items    = items
        self.modifier = modifier
        self.action   = action
    }
    
    public init(_ items: [T]?, @ViewBuilder
                _ modifier: @escaping (T) -> Content)
    {
        self.items    = items
        self.modifier = modifier
        self.action   = nil
    }
    
    public var body: some View {
        ZStack { // NOTE: This cannot be reduced to `List.refreshable.task`
            List(items ?? [T]()) { self.modifier($0) }
                .refreshable { await self.action?() }
        }.task { await self.action?() }
    }
}

import SerializedSwift
final class Post: ARModel {
    static var all: [Post]?
    @Serialized var userId: String
    @Serialized var title:  String
    @Serialized var body:   String
}
struct ARListView_Previews: PreviewProvider {
    static var previews: some View {
        ARListView(Post.all, content: { post in
            VStack(alignment: .leading) {
                Text(post.title)
                    .fontWeight(.bold)
                    .lineLimit(1)
                Text(post.body)
                    .fontWeight(.light)
                    .lineLimit(1)
            }
        }, populate: { await Post.fetchInto(&Post.all) }).body
    }
}
