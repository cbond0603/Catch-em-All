//
//  Creatures.swift
//  Catch 'em All
//
//  Created by Chris Bond on 4/11/22.
//

import Foundation

class Creatures {
    
    private struct Returned: Codable {
        var count: Int
        var next: String?
        var results: [Creature]
    }
    
    struct Creature: Codable {
        var name: String
        var url: String
    }
    
    var count = 0
    var urlString = "https://pokeapi.co/api/v2/pokemon/"
    var creatureArray: [Creature] = []
    var isFetching = false
    
    
    func getData(completed: @escaping () -> ()) {
        guard isFetching == false else {
//            completed()
            return
        }
        
        isFetching = true
        
        print("🕸🕸 We are accessing the url \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("🤬 ERROR: Couldn't create a URL from \(urlString)")
            isFetching = false
            completed()
            return
        }
        
        //Create Session
        let session = URLSession.shared
        
        //get data with .datatask method
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("🤬 ERROR: \(error.localizedDescription)")
            }
            //deal with data
            do {
                let returned = try JSONDecoder().decode(Returned.self, from: data!)
                self.count = returned.count
                self.urlString = returned.next ?? ""
                self.creatureArray = self.creatureArray + returned.results
            } catch {
                print("🤬 JSON ERROR: \(error.localizedDescription)")
            }
            self.isFetching = false
            completed()
        }
    
        task.resume()
    }
}
