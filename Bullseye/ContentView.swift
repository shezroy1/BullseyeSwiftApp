//
//  ContentView.swift
//  Bullseye
//
//  Created by Sherin Roy on 19/06/2020.
//  Copyright © 2020 Sherin Roy. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var overallScore = 0
    @State var currentRoundNumber = 1
    let midnightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)
    
    func alertTitle() -> String {
        let difference = amountOffInt()
        let title: String
        if difference == 0 {
            title = "Perfect!"
        } else if difference < 5 {
            title = "You almost had it!"
        } else if difference <= 10 {
            title = "Not bad."
        } else {
            title = "Are you even trying?"
        }
        
        return title
    }
    
    func startOver() -> Void {
        overallScore = 0
        currentRoundNumber = 1
        sliderValue = 50.0
        target = randomNumber()
    }
    
    func randomNumber() -> Int {
        return Int.random(in: 1...100)
    }
    
    func amountOffInt() -> Int {
        return abs(target - sliderValueRounded())
    }
 
    func sliderValueRounded() -> Int {
        return Int(sliderValue.rounded())
    }
    
    func pointsForCurrentRound() -> Int {
        let maximumScore = 100
        let difference = amountOffInt()
        let bonus: Int
        if difference == 0 {
            bonus = 100
        } else if difference == 1 {
            bonus = 50
        } else {
            bonus = 0
        }
        return maximumScore - difference + bonus
    }
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content.foregroundColor(Color.white)
            .modifier(Shadow())
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content.foregroundColor(Color.yellow)
            .font(Font.custom("Arial Rounded MT Bold", size: 24))
            .modifier(Shadow())
        }
    }
    
    struct LargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
                .foregroundColor(Color.black)
        }
    }
    
    struct SmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .font(Font.custom("Arial Rounded MT Bold", size: 12))
            .foregroundColor(Color.black)
        }
    }
    
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content.shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                Text("Put the bullseye as close as you can to:")
                    .modifier(LabelStyle())
                Text("\(target)")
                .modifier(ValueStyle())
                Spacer()
            }
            
            Spacer()
            
            HStack {
                Text("1")
                .modifier(LabelStyle())
                Slider(value: $sliderValue, in: 1...100).accentColor(Color.green)
                Text("100")
                .modifier(LabelStyle())
            }
            Button(action: {
                self.alertIsVisible = true
                self.overallScore += self.pointsForCurrentRound()
            }) {
                Text(/*@START_MENU_TOKEN@*/"Hit me!"/*@END_MENU_TOKEN@*/)
                .modifier(LargeTextStyle())
            }.alert(isPresented: $alertIsVisible) {() -> Alert in
                return Alert(title: Text("\(alertTitle())"),
                             message: Text("The slider's value is \(sliderValueRounded()).\n" +
                                "You scored \(pointsForCurrentRound()) points this round."
                ), dismissButton: .default(Text("Awesome!")) {
                    self.target = self.randomNumber()
                    self.currentRoundNumber += 1
                })
                }.background(Image("Button")).modifier(Shadow())
            
            Spacer()
            
            HStack {
                Button(action: {
                    self.startOver()
                }) {
                    HStack {
                        Image("StartOverIcon")
                        Text("Start Over")
                        .modifier(SmallTextStyle())
                    }
                }.background(Image("Button")).modifier(Shadow())
                Spacer()
                HStack {
                    Text("Score:")
                    .modifier(LabelStyle())
                    Text("\(overallScore)")
                    .modifier(ValueStyle())
                }
                Spacer()
                HStack {
                    Text("Round:")
                    .modifier(LabelStyle())
                    Text("\(currentRoundNumber)")
                    .modifier(ValueStyle())
                }
                Spacer()
                NavigationLink(destination: AboutView()) {
                    HStack {
                        Image("InfoIcon")
                        Text("Info")
                        .modifier(SmallTextStyle())
                    }
                }.background(Image("Button")).modifier(Shadow())
            }
            .padding(.bottom, 20)
        }
        .background(Image("Background"), alignment: .center)
    .accentColor(midnightBlue)
    .navigationBarTitle("Bullseye")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 898, height: 414))
    }
}
