//
//  ActionView.swift
//  Nano3
//
//  Created by Afonso Rekbaim on 26/09/23.
//

import SwiftUI

struct ActionView: View {
    @State var action: String
    @State var opacity = 0.0
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        switch action{
        case "base":
            ZStack{
                RoundedRectangle(cornerRadius: 32)
                    .frame(width: 200, height: 30)
                    .background(.black)
                    .opacity(opacity)
                HStack{
                    Text("Copied to clipboard.")
                        .font(.system(size: 14))
                        .foregroundStyle(.black)
                }
                .frame(width: 200, height: 30)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeInOut(duration: 0.2)){
                        opacity = 1.0
                    }
                }
                .onReceive(timer) { _ in
                    withAnimation(.easeInOut(duration: 0.2)){
                        opacity = 0.0
                        timer.upstream.connect().cancel()
                    }
                }
            }
            
        default:
            Text("Erro")
        }
    }
}


#Preview {
    ActionView(action: "base")
}
