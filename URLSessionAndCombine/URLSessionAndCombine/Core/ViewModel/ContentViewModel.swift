//
//  ViewModel.swift
//  URLSessionAndCombine
//
//  Created by Jeofferson Dela Peña on 7/21/23.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    @Published var posts: [Post] = []

    private var cancellables = Set<AnyCancellable>()

    func fetchData() {
        Service.shared.getData(endpoint: .posts, type: Post.self)
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print("Error is \(err.localizedDescription)")
                case .finished:
                    print("Finished")
                }
            }
            receiveValue: { [weak self] posts in
                self?.posts = posts
            }
            .store(in: &cancellables)
    }
}
