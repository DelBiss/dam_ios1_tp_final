//
//  NewGameView.swift
//  mystere
//
//  Created by Philippe Allard-Rousse (Étudiant) on 1/19/1401 AP.
//

import SwiftUI

struct GamePresetPicker:View {
    
    @Binding var gameTypes:[GameType]
    @Binding var selectedIndex:Int
    
    var body: some View{
        Section(header:Text("Type de la partie")){
            if(gameTypes.count <= 3){
                Picker("Type de partie", selection: $selectedIndex) {
                    ForEach(0..<gameTypes.count) { index in
                        Text(gameTypes[index].props.name)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            else
            {
                Picker("Type de partie", selection: $selectedIndex) {
                    ForEach(0..<gameTypes.count) { index in
                        Text(gameTypes[index].props.name)
                    }
                }
                .pickerStyle(WheelPickerStyle())
            }
        }
    }
}

struct PropsStepper:View {
    var label:String
    var min:Int = 1
    var max:Int = 999
    @Binding var props:Int
    
    var body: some View{
        Stepper(
            value: $props,
            in: min...max){
            HStack{
                Text("\(label):").bold()
                Text("\(props)")
            }
        }
    }
    
}

struct NewGameViewSheet:View{
    var controler:GameControler
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View{
        NewGameView(controler: controler)
            .navigationBarItems(leading: Button("Annuler"){
                presentationMode.wrappedValue.dismiss()
            })
    }
}
struct NewGameView:View{
    @Environment(\.presentationMode) var presentationMode
    //@State private var selectedType:Int = 0
    @ObservedObject var controler:GameControler
    var body: some View {
        
        Form {
            
            List{
                GamePresetPicker(gameTypes: $controler.gameData, selectedIndex: $controler.gameTypeIndex)
                
                Section(header:Text("Parametre de la partie")){
                    
                    PropsStepper(
                        label: "Borne Minimal",
                        max: controler.gameData[controler.gameTypeIndex].props.max-1,
                        props: $controler.gameData[controler.gameTypeIndex].props.min
                    )
                    PropsStepper(
                        label: "Borne Maximal",
                        min: controler.gameData[controler.gameTypeIndex].props.min+1,
                        props: $controler.gameData[controler.gameTypeIndex].props.max
                    )
                    PropsStepper(
                        label: "Nb d'essaies",
                        max: 100,
                        props: $controler.gameData[controler.gameTypeIndex].props.nbTry
                    )
                
                }
                .disabled(!controler.gameData[controler.gameTypeIndex].editable)
                
                Section(
                    header: Text("Difficulté"),
                    footer:Text("Le mode facile ajuste automatiquement les entrés possibles")
                ){
                    Toggle("Mode facile", isOn:$controler.gameData[controler.gameTypeIndex].props.easyMode)
                }
                Section{
                    Button(
                        "Commencer une Partie \(controler.gameData[controler.gameTypeIndex].props.name)",
                        action:{
                            controler.StartNewGame(
                                newGameProps: controler.gameData[controler.gameTypeIndex].props
                            )
                            presentationMode.wrappedValue.dismiss()
                        }
                    )
                    
                }
            }
            
        }
        .navigationBarItems(trailing: NavigationLink(
            destination: GameView(controler: controler),
            isActive: $controler.asActiveGame
        ){
            Text("Continuer la partie")
        })
        .navigationTitle("Nouvelle Partie")
        
    }
}

struct NewGameView_Previews: PreviewProvider {
    static var previews: some View {
        
        NewGameView(controler:GameControler())
            .previewDevice("iPhone 12 Pro Max")
    }
}
