//
//  GameType.swift
//  NombreMystere
//
//  Created by Philippe Allard-Rousse (Étudiant) on 1/19/1401 AP.
//

import Foundation
import SwiftUI
import CoreLocation

struct GameProperties: Hashable, Codable{
    var min: Int
    var max:Int
    var nbTry:Int
    
}

struct GameType: Hashable, Codable {
    
    var id: String
    var props: GameProperties
    var editable:Bool
    
    
    
}
