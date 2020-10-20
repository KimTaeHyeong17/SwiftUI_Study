//
//  ContentView.swift
//  BullsEye
//
//  Created by USER on 2020/10/19.
//

import SwiftUI

struct ContentView: View {
    
    let target = Double.random(in: 0..<1)
    @State var guess : Double
    @State var showAlert = false
    
    func computeScore() -> Int {
        let diff = guess - target
        
        return lround((1.0 - sqrt(diff*diff))*100)
    }
    
    var body: some View {
        VStack {
            Text("Put the Bull's Eye as close as you can to: \(Int(target*100.0))")
                .padding()
            HStack {
                Text("1")
                Slider(value: $guess)
                Text("100")
            }.padding()
            Button(action: {self.showAlert = true}) {
                Text("Hit Me!")
            }.alert(isPresented: $showAlert, content: {
                Alert(title: Text("Your Score"), message: Text(String(computeScore())))
            })
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(guess: 0.5)
    }
}
