//
//  Bundle-Decodable.swift
//  MoonShot
//
//  Created by Anthony Da cruz on 14/04/2021.
//

import Foundation

extension Bundle {
    //Function to decode a json file containing data
    //Generic method
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        //Displaying date
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        //finally we should get our data as object here 🤌
        return loaded
    }
}
