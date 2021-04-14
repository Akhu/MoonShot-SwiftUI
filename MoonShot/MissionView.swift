//
//  MissionView.swift
//  MoonShot
//
//  Created by Anthony Da cruz on 14/04/2021.
//

import SwiftUI

//Displaying detail of an Apollo mission
struct MissionView: View {
    let mission: Mission
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let astronauts: [CrewMember]
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else { fatalError ("Missing \(member)")}
        }
        
        self.astronauts = matches
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical){
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                    
                    Text(self.mission.missionDescription)
                        .padding()
                    
                    Spacer(minLength: 25)
                    
                    //Displaying astronauts that took part of this mission
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(
                            destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                                VStack(alignment: .leading){
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
