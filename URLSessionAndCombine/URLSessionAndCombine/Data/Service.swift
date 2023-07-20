//
//  Service.swift
//  URLSessionAndCombine
//
//  Created by Jeofferson Dela Peña on 7/21/23.
//

import Foundation
import Combine

enum Endpoint: String {
    case posts
}

class Service {

    static let shared = Service()

    private static _const let baseURL = "https://jsonplaceholder.typicode.com/"

    private var cancellables = Set<AnyCancellable>()

    private init() {}

    func getData<T: Decodable>(endpoint: Endpoint, id: Int? = nil, type: T.Type) -> Future<[T], Error> {
        return Future<[T], Error> { [weak self] promise in
            guard let self = self, let url = URL(
                string: Service.baseURL.appending(endpoint.rawValue).appending(id == nil ? "" : "/\(id ?? 0)")
            ) else {
                return promise(.failure(NetworkError.invalidURL))
            }

            print("URL is \(url.absoluteString)")

            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.responseError
                    }
                    return data
                }
                .decode(type: [T].self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink(
                    receiveCompletion: { completion in
                        if case let .failure(error) = completion {
                            switch error {
                            case let decodingError as DecodingError:
                                promise(.failure(decodingError))
                            case let apiError as NetworkError:
                                promise(.failure(apiError))
                            default:
                                promise(.failure(NetworkError.unknown))
                            }
                        }
                    },
                    receiveValue: {
                        promise(.success($0))
                    }
                )
                .store(in: &self.cancellables)
        }
    }
}
