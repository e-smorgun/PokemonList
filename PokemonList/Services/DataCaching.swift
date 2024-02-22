//
//  DataCaching.swift
//  PokemonList
//
//  Created by Evgeny on 22.02.24.
//

import Foundation

protocol DataCaching {
    func object(forKey key: NSURL) -> Data?
    func setObject(_ object: Data, forKey key: NSURL)
}

class NSCacheDataCaching: DataCaching {
    private let cache = NSCache<NSURL, NSData>()
    
    func object(forKey key: NSURL) -> Data? {
        return cache.object(forKey: key as NSURL) as Data?
    }
    
    func setObject(_ object: Data, forKey key: NSURL) {
        cache.setObject(object as NSData, forKey: key as NSURL)
    }
}
