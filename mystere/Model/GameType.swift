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
    var name: String
    var min: Int
    var max:Int
    var nbTry:Int
    var easyMode:Bool = false
    
}

struct GameType: Hashable, Codable {
    var props: GameProperties
    var editable:Bool
}
