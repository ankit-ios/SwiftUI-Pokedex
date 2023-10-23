//
//  NetworkManager.swift
//  Pokedex
//
//  Created by Ankit Sharma on 21/10/23.
//

import Foundation
import Combine


class NetworkManager : ObservableObject {
    static let shared = NetworkManager()
    @Published var cancellables: Set<AnyCancellable> = []

    func request<T: Decodable>(_ apiRequest: APIRequest, responseType: T.Type) -> AnyPublisher<T, Error> {
        let request = apiRequest.buildURLRequest()
        print(request)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
