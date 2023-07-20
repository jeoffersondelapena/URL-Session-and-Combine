//
//  Post.swift
//  URLSessionAndCombine
//
//  Created by Jeofferson Dela Peña on 7/21/23.
//

import Foundation

class Post: Decodable, Identifiable {
    static let sample = Post(
        id: -1,
        userId: -1,
        title: "Sample Title",
        body: "Sample body"
    )

    let id: Int
    let userId: Int
    let title: String
    let body: String

    init(id: Int, userId: Int, title: String, body: String) {
        self.id = id
        self.userId = userId
        self.title = title
        self.body = body
    }
}
