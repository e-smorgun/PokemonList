//
//  DataFetching.swift
//  PokemonList
//
//  Created by Evgeny on 22.02.24.
//

import Foundation

protocol DataFetching {
    func fetchData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

class URLSessionDataFetching: DataFetching {
    func fetchData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "Data is nil", code: 0, userInfo: nil)))
                return
            }
            completion(.success(data))
        }.resume()
    }
}
