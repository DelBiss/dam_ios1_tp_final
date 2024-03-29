//
//  ContentView.swift
//  mystere
//
//  Created by Philippe Allard-Rousse (Étudiant) on 1/19/1401 AP.
//

import SwiftUI

private var idiom : String {
    switch UIDevice.current.userInterfaceIdiom {
    case .pad:
        return "iPad"
    case .phone:
        return "iPhone"
    case .carPlay:
        return "Voiture"
    case .tv:
        return "Téléviseur"
    default:
        return "Fun"
    }
    
}

struct ContentView: View {
    @State var askNewGame:Bool = false
    @ObservedObject var controler:GameControler = GameControler()
    var body: some View {
        NavigationView{
            
                if(controler.asActiveGame){
                    GameView(game: controler.currentGame!)
                        .navigationBarItems(
                            leading: Text("Version \(idiom)"),
                            trailing:
                                Button("Nouvelle Partie"){
                                    askNewGame = true
                                }
                        )
                }
                else{
                    NewGameView(controler:controler)
                        .navigationBarItems(leading: Text("Version \(idiom)"))
                }
            
            
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $askNewGame, content: {
            NavigationView{
                NewGameViewSheet(controler:controler)
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12 Pro Max")
    }
}
