//
//  Service.swift
//  AppStoreApp
//
//  Created by Ramazan Ocak on 28.12.2021.
//

import Foundation

class Service {
    
    static let shared = Service() // Singleton
    
    func fetchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> ()) {
        print("Fetch apps from service layer")
        
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        guard let url = URL(string: urlString) else { return }
        // fetch data from internet
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("Failed to fetch ", error)
                completion([], error)
                return
            }
            
            //succes
            guard let data = data else { return }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(searchResult.results, nil)
                
                //searchResult.results.forEach({print($0.trackName,$0.primaryGenreName)})
            } catch let jsonError {
                print("Failed to decode json", jsonError)
                completion([], jsonError)
            }
            
        }.resume()
    }
    
    func fetchFreeApps( completion: @escaping ( AppGroupModel?, Error? ) -> ()) {
        
        print("Starting fetch group apps")
        let urlString = "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/10/apps.json"
        fetchGenericJSONData(urlString: urlString, completion: completion)
        
    }
    
    func fetchPaidApps(completion: @escaping ( AppGroupModel?, Error? ) -> ()) {
        
        print("Starting fetch group apps")
        let urlString = "https://rss.applemarketingtools.com/api/v2/us/apps/top-paid/10/apps.json"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchTopPodcasts (completion: @escaping (AppGroupModel?, Error?) -> ()) {
        let urlString = "https://rss.applemarketingtools.com/api/v2/tr/podcasts/top/10/podcast-episodes.json"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    // MARK: HELPER
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to fetch ", error)
                completion(nil, error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let objects = try JSONDecoder().decode(T.self, from: data)
                completion(objects, nil)
            }
            catch {
                print("error",error)
            }
        }.resume()
    }
}
