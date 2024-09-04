//
//  BlockView.swift
//  Snippeteer
//
//  Created by Afonso Rekbaim on 28/09/23.
//

import SwiftUI

struct BlockView: View {
    @State var geometry: GeometryProxy?
    
    var body: some View {
        ZStack{
            
        }
        .frame(width: geometry!.size.width/2.5, height: geometry!.size.height/2)
        .background(
            LinearGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 0.02, green: 0, blue: 0.11), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.03, green: 0, blue: 0.2), location: 1.00),
                ],
                startPoint: UnitPoint(x: 0, y: 0),
                endPoint: UnitPoint(x: 1, y: 1)
            )
        )
        .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 60, bottomLeading: 60, bottomTrailing: 60, topTrailing: 60)))
        .overlay(
            RoundedRectangle(cornerRadius: 60)
                .inset(by: 0.5)
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [Color.white, Color(white: 1, opacity: 0.0)]), startPoint: .topLeading, endPoint: .bottomTrailing),
                    lineWidth: 1
                )
        )
//        .onHover(perform: { hover in
//            print("Dentro")
//            NSApp.windows.forEach { window in
//                window.disableCursorRects()
//            }
//            NSCursor.pointingHand.push()
//        })
    }
}

#Preview {
    BlockView()
}
