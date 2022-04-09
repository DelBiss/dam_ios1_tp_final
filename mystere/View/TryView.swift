//
//  TryView.swift
//  mystere
//
//  Created by Philippe Allard-Rousse (Étudiant) on 1/20/1401 AP.
//

import SwiftUI

struct ArrowUp: View {
    var sideSize:CGFloat = 20
    var arrowColor:Color = Color.green
    var body: some View{
        VStack{
            Group{
                Rectangle()
                    .fill(arrowColor)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    .rotationEffect(Angle(degrees: 45))
                    .offset(y:10)
                    .frame(width: sideSize, height: sideSize)
            
            }
            .frame( maxWidth: .infinity)
            .clipped()
            Spacer()
        }
        
    }
}

struct ArrowDown:View {
    var sideSize:CGFloat = 20
    var arrowColor:Color = Color.green
    var body: some View{
        ArrowUp(sideSize: sideSize, arrowColor: arrowColor).rotationEffect(Angle(degrees: 180))
    }
}

struct Arrow:View {
    var side:Int
    var sideSize:CGFloat = 15
    var arrowColor:Color = Color.green
    var body: some View{
        VStack{
            if(side == 0){
                EmptyView()
            }
            else{
                Group{
                    Rectangle()
                        .fill(arrowColor)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        .rotationEffect(Angle(degrees: 45))
                        .offset(y:sideSize/2)
                        .frame(width: sideSize, height: sideSize)
                }
                .frame( maxWidth: .infinity)
                .clipped()
                Spacer()
            }
        
        }
        .rotationEffect(Angle(degrees: 90))
        .rotationEffect(Angle(degrees: 90.0*Double(side)))
    }
}
struct TryView: View {
    var data:TryData
    var sideSize:CGFloat = 20
    var body: some View {
        ZStack{
            //data.result == 0 ? Color.green : Color.red
            Arrow(side:data.result)
                
            
                
            VStack(spacing:0){
                
            Text("#\(data.id)")
                .font(.body)
            Text("\(data.number)")
                .font(.largeTitle)
                .fontWeight(.black)
               
            
        }
        .padding()
            
        }
        .frame(width: 90.0, height: 90.0)
        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
        .overlay(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).stroke())
        
    }
}

struct TryView_Previews: PreviewProvider {
    static var previews: some View {
        TryView(data:TryData(id:100,number:45,result:1))
            .previewLayout(.sizeThatFits)
    }
}
