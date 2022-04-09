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
                        Text(gameTypes[index].id)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            else
            {
                Picker("Type de partie", selection: $selectedIndex) {
                    ForEach(0..<gameTypes.count) { index in
                        Text(gameTypes[index].id)
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
struct NewGameView:View{
    @State var gameTypes:[GameType]
    @State private var selectedType:Int = 0

    var body: some View {
        
        return Form {
            
            List{
                GamePresetPicker(gameTypes: $gameTypes, selectedIndex: $selectedType)
                
                Section(header:Text("Parametre de la partie")){
                    
                    PropsStepper(
                        label: "Borne Minimal",
                        max: gameTypes[selectedType].props.max-1,
                        props: $gameTypes[selectedType].props.min
                    )
                    PropsStepper(
                        label: "Borne Maximal",
                        min: gameTypes[selectedType].props.min+1,
                        props: $gameTypes[selectedType].props.max
                    )
                    PropsStepper(
                        label: "Nb d'essaies",
                        max: 100,
                        props: $gameTypes[selectedType].props.nbTry
                    )
                
                }
                .disabled(!gameTypes[selectedType].editable)
                Section{
                    Button("Commencer une Partie \(gameTypes[selectedType].id)", action:{})
                }
            }
            
            
            
                
        }.navigationTitle("Nouvelle Partie")
        
    }
}

struct NewGameView_Previews: PreviewProvider {
    static var previews: some View {
        
        NewGameView(gameTypes: gameData)
            .previewDevice("iPhone 12 Pro Max")
    }
}
