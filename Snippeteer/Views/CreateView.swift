//
//  CreateView.swift
//  Snippeteer
//
//  Created by Afonso Rekbaim on 29/09/23.
//

import SwiftUI

struct CreateView: View {
    @State var showView = false
    @State var showView2 = false
    
    @State var showInfo = false
    @State var showInfo2 = false
    
    @State var collection = "Snippeteer"
    @State var op = 1.0
    @State var op2 = 1.0
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Binding var tela: Int
    
    func handleHover(hover2: Bool) {
        op2 = hover2 ? 0.4 : 1.0
        showInfo2 = hover2
        //NSCursor.pointingHand.push()
//        if hover2 {
//            print("Dentro")
//            NSCursor.pointingHand.push()
//        } else {
//            print("Fora")
//            NSCursor.pop()
//        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack{
                ZStack{
                    VStack(spacing: 40){
                        
                        HStack(spacing: 40){
                            ZStack{
                                BlockView(geometry: geometry)
                                    .opacity(op2)
                                    .onTapGesture {
                                        withAnimation(){
                                            collection = "Your Snippets"
                                            showView2.toggle()
                                        }
                                    }
                                Text(showInfo2 ? """
                                        ()
                                        """ :
                                        """
                                        Your Snippets
                                        """)
                                    .font(
                                      Font.custom("Source Code Pro", size: geometry.size.height*0.08)
                                        .weight(.semibold)
                                    )
                                    .foregroundColor(.white)
                            }
                            .onHover(perform: handleHover)
                            
                            
                            ZStack{
                                BlockView(geometry: geometry)
                                    .opacity(op)
                                    .onTapGesture {
                                        withAnimation(){
                                            collection = "Create Snippet"
                                            showView.toggle()
                                            tela = 2
                                        }
                                    }
                                
                                if showInfo == true{
                                    Text("""
                                            ()
                                            """)
                                        .font(
                                            Font.custom("Source Code Pro", size: geometry.size.height*0.08)
                                            .weight(.semibold)
                                        )
                                        .foregroundColor(.white)
                                } else{
                                    Text("Create Snippet +")
                                        .font(
                                            Font.custom("Source Code Pro", size: geometry.size.height*0.08)
                                            .weight(.semibold)
                                        )
                                        .foregroundColor(.white)
                                }
                            }
                            .onHover(perform: { hover in
                                op = hover ? 0.4 : 1.0
                                
                                showInfo = hover ? true : false
                                
                                //if (showInfo) {
                                  //  NSCursor.pointingHand.push()
                                //} else {
                                  //  NSCursor.pop()
                                //}
                            })

                        }
                        
                        
                    }
                    .frame(width: 400, height: 200)
                    
                    if showView && tela == 2{
                        ZStack{
                            MakeSnippet(tela: $tela)
                                .padding(.top, geometry.size.height * 0.1)
                            
                            VStack(spacing: 0){
                                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                                    
                                    Spacer()

                                    Text(collection)
                                        .font(Font.custom("Source Code Pro", size: 40))
                                    
                                    Spacer()
                                    
                                    Button("Back"){
                                        withAnimation{
                                            collection = "Snippeteer"
                                            showView.toggle()
                                        }
                                    }
                                    
                                }
                                .frame(height: geometry.size.height * 0.1)
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
                                
                                
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.clear)
                                    .background(
                                    LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: Color(white: 1, opacity: 1.0), location: 0.00),
                                        Gradient.Stop(color: Color(white: 1, opacity: 0.0), location: 1.00),
                                    ],
                                    startPoint: UnitPoint(x: 0, y: 0),
                                    endPoint: UnitPoint(x: 1, y: 0)
                                    )
                                    .frame(height: 1)
                                    
                                    )
                                
                                Spacer()
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.black)
                    }else if showView2{
                        ZStack{
                            SnippetsSoloView(collection: "Custom")
                                .padding(.top, geometry.size.height * 0.1)
                            
                            VStack(spacing: 0){
                                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                                    
                                    Spacer()

                                    Text(collection)
                                        .font(Font.custom("Source Code Pro", size: 40))
                                    
                                    Spacer()
                                    
                                    Button("Back"){
                                        withAnimation{
                                            collection = "Snippeteer"
                                            showView2.toggle()
                                        }
                                    }
                                    
                                }
                                .frame(height: geometry.size.height * 0.1)
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
                                
                                
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.clear)
                                    .background(
                                    LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: Color(white: 1, opacity: 1.0), location: 0.00),
                                        Gradient.Stop(color: Color(white: 1, opacity: 0.0), location: 1.00),
                                    ],
                                    startPoint: UnitPoint(x: 0, y: 0),
                                    endPoint: UnitPoint(x: 1, y: 0)
                                    )
                                    .frame(height: 1)
                                    
                                    )
                                
                                Spacer()
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.black)
                    }else{
                        VStack(spacing: 0){
                            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                                
                                Spacer()
                                
                                Text(collection)
                                    .font(Font.custom("Source Code Pro", size: 40))
                                
                                Spacer()
                                
                            }
                            .frame(height: geometry.size.height * 0.1)
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
                            
                            
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.clear)
                                .background(
                                LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(white: 1, opacity: 1.0), location: 0.00),
                                    Gradient.Stop(color: Color(white: 1, opacity: 0.0), location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0, y: 0),
                                endPoint: UnitPoint(x: 1, y: 0)
                                )
                                .frame(height: 1)
                                
                                )
                            
                            Spacer()
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.02, green: 0, blue: 0.11))
        }
    }
}

#Preview {
    CreateView(tela: .constant(1))
}
