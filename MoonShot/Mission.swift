//
//  Mission.swift
//  MoonShot
//
//  Created by Anthony Da cruz on 14/04/2021.
//

import Foundation


// MARK: - Mission
struct Mission: Codable, Identifiable {
    
    //Because only used to describe a mission
    //So we can put in a nested struct
    struct CrewRole: Codable {
        // MARK: - CrewRole
        let name, role: String
    }
    
    let id: Int
    let launchDate: Date? //Not always there
    let crew: [CrewRole]
    let missionDescription: String
    var displayName: String {
        "Apollo \(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
    
    var image: String {
        "apollo\(id)"
    }

    enum CodingKeys: String, CodingKey {
        case id, launchDate, crew
        case missionDescription = "description"
    }
}

