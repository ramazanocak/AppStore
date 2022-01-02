//
//  AppGroupModel.swift
//  AppStoreApp
//
//  Created by Ramazan Ocak on 1.01.2022.
//

import Foundation

struct AppGroupModel: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable {
    let artistName, id: String
    let name: String
    let artworkUrl100: String
}
