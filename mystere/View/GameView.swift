//
//  GameView.swift
//  mystere
//
//  Created by Philippe Allard-Rousse (Étudiant) on 1/20/1401 AP.
//

import SwiftUI

struct ActiveGameState:View{
    @ObservedObject var game:ActiveGameControler
    
    var body: some View{
        VStack{
            Text("Trouver le nombre mystere")
                .font(.title)
                .fontWeight(.bold)
                
            
            HStack{
                Text("Entre")
                Text("\(game.min)")
                    .font(.largeTitle)
                Text("et")
                Text("\(game.max)")
                    .font(.largeTitle)
                Text("en")
                Text("\(game.remainingTry)")
                    .font(.largeTitle)
                Text("essaies")
            }
            TriesView(data: game.tries.reversed())
        }
    }
}

struct ActiveGameInput:View{
    @ObservedObject var game:ActiveGameControler
    @State var nextGuest:Int
    
    
    
    init(game myGame:ActiveGameControler) {
        game = myGame
        _nextGuest = State(initialValue: myGame.props.min)
    }
    
    var body: some View{
        VStack{
            Button(action:{
                let result:TryData = game.find(nextGuest)
                nextGuest = nextGuest - result.result
            }){
                Text("Essayer le nombre \(nextGuest)")
                    .font(.largeTitle)
            }
            Picker("Type de partie", selection: $nextGuest) {
                ForEach(game.possible, id:\.self) { v in
                    Text("\(v)")
                }
                
            }
            .pickerStyle(WheelPickerStyle())
            .onChange(of: game.min){newMin in
                if(nextGuest<newMin){
                    nextGuest = newMin
                }
            }
            .onChange(of: game.max){newMax in
                if(nextGuest>newMax){
                    nextGuest = newMax
                }
            }
        }
    }
}
struct ActiveGame:View{
    var game:ActiveGameControler
    @Environment(\.verticalSizeClass) var SizeClass
    var body: some View{
        Group{
            switch SizeClass {
                case .compact:
                    HStack{
                        ActiveGameState(game: game)
                        ActiveGameInput(game: game)
                    }
                default:
                    VStack{
                        ActiveGameState(game: game)
                        ActiveGameInput(game: game)
                    }
            }
        }
        .navigationTitle("Partie \(game.props.name)")
        
    }
}

struct GameView:View{
    @ObservedObject var game:ActiveGameControler
    
    var body: some View{
        switch game.result {
        case GameState.OnGoing:
            ActiveGame(game: game)
        case GameState.Win:
            WinView(game: game)
        case GameState.Fail:
            FailView(game: game)
        
        }
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ActiveGame(game:ActiveGameControler(GameControler().gameData[0].props))
        }
        .previewDevice("iPhone 12 Pro Max")
    }
}
