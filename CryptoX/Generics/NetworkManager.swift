//
//  NetworkManager.swift
//  CryptoX
//
//  Created by Marcelo de Araújo on 08/09/2023.
//

import Combine
import Foundation

enum NetworkingError: LocalizedError {
    case badUrlResponse(url: URL)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .badUrlResponse(let url):
           return "[🔥] Bad response from URL: \(url)."
        case .unknown:
           return "[⚠️] Unknown error occured."
        }
    }
}

final class NetworkManager {
    
    static func download(from url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap( { try handleURLResponse(output: $0, url: url) } )
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            throw NetworkingError.badUrlResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished: break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
