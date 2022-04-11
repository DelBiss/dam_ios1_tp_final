//
//  WinView.swift
//  mystere
//
//  Created by Philippe Allard-Rousse (Étudiant) on 1/21/1401 AP.
//

import SwiftUI

struct WinView: View {
    var game:ActiveGameControler
    var body: some View {
        
        VStack{
            VStack(alignment: .center){
                Text("Vous avez gagné!")
                    .font(.largeTitle)
                    //.fontWeight(.heavy)
                    
                Text("Vous avez trouvez le nombre mystère en \(game.nbTryDone) essaies")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
            }
                .foregroundColor(Color.black)
                .padding()
                .background(Color("GoodTry"))
            .cornerRadius(30)
            .shadow(radius: 5)
            TriesView(data: game.tries)
        }
        
    }
}

struct FailView: View {
    var game:ActiveGameControler
    var body: some View {
        VStack{
            VStack(alignment: .center){
                Text("Vous avez perdu!")
                    .font(.largeTitle)
                    //.fontWeight(.heavy)
                    
                Text("Le nombre mystère était")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                Text("\(game.mysteryNumber)")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
            }
                .foregroundColor(Color.black)
                .padding()
                .background(Color("BadTry"))
                .cornerRadius(30)
                .shadow(radius: 5)
            TriesView(data: game.tries)
            
        }
        
    }
}
struct WinView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WinView(game: ActiveGameControler(GameControler().gameData[0].props))
            FailView(game: ActiveGameControler(GameControler().gameData[0].props))
                
        }
    }
}
