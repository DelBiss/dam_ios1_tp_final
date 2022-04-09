//
//  ContentView.swift
//  mystere
//
//  Created by Philippe Allard-Rousse (Étudiant) on 1/19/1401 AP.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
        NewGameView(gameTypes: gameData)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12 Pro Max")
    }
}
