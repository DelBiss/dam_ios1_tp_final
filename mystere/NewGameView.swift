//
//  NewGameView.swift
//  mystere
//
//  Created by Philippe Allard-Rousse (Étudiant) on 1/19/1401 AP.
//

import SwiftUI

struct NewGameView:View{
    @State var gameTypes:[GameType]
    @State private var selectedType:Int = 2

    var body: some View {
        Form {
            
            List{
                Section(header:Text("Type de la partie")){
                    Picker("Type de partie", selection: $selectedType) {
                        ForEach(0..<gameTypes.count) { index in
                            Text(gameTypes[index].id)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header:Text("Parametre de la partie")){
                    
                    
                    Stepper(
                    value:$gameTypes[selectedType].props.min,
                    in:1...gameTypes[selectedType].props.max-1)
                    {
                        HStack{
                            Text("Borne Minimal:").bold()
                            Text("\(gameTypes[selectedType].props.min)")
                        }
                    }
                    
                    Stepper(
                    value:$gameTypes[selectedType].props.max,
                    in:gameTypes[selectedType].props.min+1...999)
                    {
                        HStack{
                            Text("Borne Minimal:").bold()
                            Text("\(gameTypes[selectedType].props.max)")
                        }
                    }
                    
                    Stepper(
                        value:$gameTypes[selectedType].props.nbTry,
                    in:0...100)
                    {
                        HStack{
                            Text("Borne Minimal:").bold()
                            Text("\(gameTypes[selectedType].props.nbTry)")
                        }
                    }
                
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
