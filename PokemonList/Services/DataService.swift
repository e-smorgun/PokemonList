//
//  DataService.swift
//  PokemonList
//
//  Created by Evgeny on 17.02.24.
//

import Foundation

class DataService {
    private let caching: DataCaching
    private let fetching: DataFetching
    
    init(caching: DataCaching, fetching: DataFetching) {
        self.caching = caching
        self.fetching = fetching
    }
    
    func fetchModel<T: Decodable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        if let cachedData = caching.object(forKey: url as NSURL) {
            decodeData(data: cachedData, completion: completion)
            return
        }
        
        fetching.fetchData(from: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.caching.setObject(data, forKey: url as NSURL)
                self.decodeData(data: data, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func decodeData<T: Decodable>(data: Data, completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(T.self, from: data)
            completion(.success(result))
        } catch {
            completion(.failure(error))
        }
    }
}
