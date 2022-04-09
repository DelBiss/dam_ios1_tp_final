//
//  GameView.swift
//  mystere
//
//  Created by Philippe Allard-Rousse (Étudiant) on 1/20/1401 AP.
//

import SwiftUI

struct GameView:View{
    var gameConfig:GameType
    @State var props:Int = 0
    var body: some View{
        VStack{
            Text("Trouver le nombre mystere")
                .font(.title)
                .fontWeight(.bold)
            
            HStack{
                Text("Entre")
                Text("\(gameConfig.props.min)")
                    .font(.largeTitle)
                Text("et")
                Text("\(gameConfig.props.max)")
                    .font(.largeTitle)
                Text("en")
                Text("\(gameConfig.props.nbTry)")
                    .font(.largeTitle)
                Text("essaies")
            }
            ScrollView{
                
                
                LazyVGrid(
                    columns:[GridItem(.adaptive(minimum:90))],
                    spacing:8
                ){
                    ForEach(0..<20){ index in
                        TryView(data: TryData(id:index+1,number:45,result:-1))
                    }
                }
            }
            Button(action:{}){
                Text("Essayer le nombre \(props+gameConfig.props.min)")
                    .font(.largeTitle)
            }
            Picker("Type de partie", selection: $props) {
                ForEach(gameConfig.props.min..<gameConfig.props.max+1) { index in
                    Text("\(index)")
                }
            }
            .pickerStyle(WheelPickerStyle())
        }.padding()
            .navigationTitle("Partie \(gameConfig.id)")
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            GameView(gameConfig: gameData[0])
        }
        .previewDevice("iPhone 12 Pro Max")
    }
}
