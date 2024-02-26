//
//  DataService.swift
//  PokemonList
//
//  Created by Evgeny on 17.02.24.
//

import Foundation

class DataService {
    private let cacheManager: CacheManager
    private let fetching: DataFetching
    
    init(cacheManager: CacheManager, fetching: DataFetching) {
        self.cacheManager = cacheManager
        self.fetching = fetching
    }
    
    func fetchModel<T: Decodable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        fetching.fetchData(from: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                // Convert URL to a valid file URL
                let fileURL = self.cacheFileURL(for: url)
                self.cacheManager.saveToCache(cachePath: fileURL, data: data)
                self.decodeData(data: data, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchCachedModell<T: Decodable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        // Convert URL to a valid file URL
        let fileURL = self.cacheFileURL(for: url)
        
        if let cachedData = cacheManager.loadFromCache(cachePath: fileURL) {
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: cachedData)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        } else {
            completion(.failure(NSError(domain: "No internet connection and no cached data", code: 0, userInfo: nil)))
        }
    }

    private func cacheFileURL(for url: URL) -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(url.lastPathComponent)
        return fileURL
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
