//
//  PostItem.swift
//  URLSessionAndCombine
//
//  Created by Jeofferson Dela Peña on 7/21/23.
//

import SwiftUI

struct PostItem: View {
    let post: Post

    var body: some View {
        VStack {
            Text(post.title)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()

            Text(post.body)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
}

struct PostItem_Previews: PreviewProvider {
    static var previews: some View {
        PostItem(post: Post.sample)
    }
}
