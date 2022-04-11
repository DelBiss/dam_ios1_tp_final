//
//  GameController.swift
//  mystere
//
//  Created by Philippe Allard-Rousse (Étudiant) on 1/21/1401 AP.
//

import Foundation
import SwiftUI

enum GameState {
    case OnGoing
    case Win
    case Fail
}

class ActiveGameControler: ObservableObject{
    @Published var tries:[TryData]
    @Published var possible:[Int]
    var mysteryNumber:Int
    
    var props:GameProperties
    @Published var result:GameState = GameState.OnGoing
    var min:Int
    var max:Int
    var nbTryDone:Int = 0
    
    var remainingTry:Int {
        props.nbTry - nbTryDone
    }
    
    var isFinished:Bool{
        result != GameState.OnGoing
    }
    
    init(_ newGameProps:GameProperties) {
        props = newGameProps
        tries = []
        min = newGameProps.min
        max = newGameProps.max
        possible = Array(newGameProps.min...newGameProps.max)
        mysteryNumber = Int.random(in: newGameProps.min...newGameProps.max)
        objectWillChange.send()
        
    }
    
    
    
    func find(_ no:Int) -> TryData {
        nbTryDone = nbTryDone+1
        
        if(no == mysteryNumber){
            result = GameState.Win
            //min = no
            //max = no
            let newTry = TryData(id: nbTryDone, number: no, result: 0)
            tries.append(newTry)
            possible = []
            return newTry
        }
        
        
        if(remainingTry <= 0){
            result = GameState.Fail
        }
        print("------")
        print(remainingTry)
        print(result)
        if(no<mysteryNumber){
            let newTry = TryData(id: nbTryDone, number: no, result: -1)
            if(props.easyMode){
                min = Swift.max(no+1,min)
                possible = Array(min...max)
            }
            tries.append(newTry)
            return newTry
        }
        else{
            let newTry = TryData(id: nbTryDone, number: no, result: 1)
            if(props.easyMode){
                max = Swift.min(no-1,max)
                possible = Array(min...max)
            }
            tries.append(newTry)
            return newTry
        }
        
    }
}

class GameControler: ObservableObject {
    var currentGame: ActiveGameControler?{
        willSet{
            objectWillChange.send()
        }
        didSet{
           if(currentGame == nil)
           {
            asActiveGame = false
           }
           else{
            asActiveGame = true
           }
        }
    }
    
    @Published var gameData: [GameType] = load("GameTypeData.json")
    @Published var asActiveGame:Bool = false
    @Published var gameTypeIndex:Int = 0
    
    
    func StartNewGame(newGameProps:GameProperties){
        currentGame = ActiveGameControler(newGameProps)
    }
    
    
}
