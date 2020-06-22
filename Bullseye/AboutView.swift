//
//  AboutView.swift
//  Bullseye
//
//  Created by Sherin Roy on 22/06/2020.
//  Copyright © 2020 Sherin Roy. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    let backgroundColor = Color(red: 255.0 / 255.0, green: 214.0 / 255.0, blue: 179.0 / 255.0)
    
    struct headingStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content.font(Font.custom("Arial Rounded MT Bold", size: 30))
                .foregroundColor(Color.black)
                .padding(.top, 20)
                .modifier(paddingBottomStyle())
        }
    }
    
    struct textViewStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content.font(Font.custom("Arial Rounded MT Bold", size: 16))
                .foregroundColor(Color.black)
                .padding(.leading, 60)
                .padding(.trailing, 60)
                .modifier(paddingBottomStyle())
                .multilineTextAlignment(.center)
                .lineLimit(nil)
        }
    }
    
    struct paddingBottomStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .padding(.bottom, 20)
        }
    }
    var body: some View {
        Group {
            VStack {
                Text("🎯Bullseye🎯").modifier(headingStyle())
                Text("This is bullseye where you can win points by dragging the slider as close to the target value as possible.").modifier(textViewStyle())
                Text("The closer you are, the more points you score!").modifier(textViewStyle())
                Text("Good luck!").modifier(textViewStyle())
            }.background(backgroundColor)
            .navigationBarTitle("About Bullseye")
        }.background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 898, height: 414))
    }
}
