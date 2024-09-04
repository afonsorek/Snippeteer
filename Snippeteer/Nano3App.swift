import SwiftUI
import Foundation

@main
struct Nano3App: App {
    @State var tela = 0
    @State var telaMake = 0
    var body: some Scene {
            WindowGroup {
                GeometryReader{ geometry in
                    HStack(spacing: 0){
                        List{
                            Spacer()
                                .frame(height: (geometry.size.height*0.1))
                            Button{
                                withAnimation{
                                    tela = 0
                                }
                            }label:{
                                Text("Home")
                                    .buttonStyle(.plain)
                                    .frame(maxWidth: .infinity)
                                    .multilineTextAlignment(.center)
                                    .padding(.vertical, 10)
                            }
                            .buttonStyle(.borderless)
                            
                            Button{
                                withAnimation{
                                    tela = 1
                                }
                            }label:{
                                Text("Create")
                                    .buttonStyle(.plain)
                                    .frame(maxWidth: .infinity)
                                    .multilineTextAlignment(.center)
                                    .padding(.vertical, 10)
                            }
                            .buttonStyle(.borderless)
                            
                            Button{
                                withAnimation{
                                    tela = 2
                                }
                            }label:{
                                Text("Favourites")
                                    .buttonStyle(.plain)
                                    .frame(maxWidth: .infinity)
                                    .multilineTextAlignment(.center)
                                    .padding(.vertical, 10)
                            }
                            .buttonStyle(.borderless)
                            
//                            Button{
//                                withAnimation{
//                                    tela = 2
//                                }
//                            }label:{
//                                Text("Home")
//                                    .buttonStyle(.plain)
//                                    .frame(maxWidth: .infinity)
//                                    .multilineTextAlignment(.center)
//                                    .padding(.vertical, 10)
//                            }
//                            .buttonStyle(.plain)
                            
                        }
                        .scrollContentBackground(.hidden)
                        .frame(width: 200)
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
                            .frame(width: 1, height: (geometry.size.height*0.8))
                            .foregroundColor(.clear)
                            .offset(y: geometry.size.height/3)
                            .background(
                            LinearGradient(
                            stops: [
                                Gradient.Stop(color: Color(white: 1, opacity: 1.0), location: 0.00),
                                Gradient.Stop(color: Color(white: 1, opacity: 0.0), location: 1.00),
                            ],
                            startPoint: UnitPoint(x: 0, y: 0),
                            endPoint: UnitPoint(x: 0, y: 1)
                            )
                            .frame(width: 1)
                            
                            )
                        
                        

                        switch tela{
                        case 0:
                            ContentView()
                        case 1:
                            CreateView(tela: $telaMake)
                        case 2:
                            SnippetsSoloView(collection: "Favourites")
                        default:
                            ContentView()
                        }
                        
                }
            }
                .background(Color(red: 0.02, green: 0, blue: 0.11))
//                .onAppear{
//                    SnippetsUserManager.shared.RemoveDefault()
//                }
        }
            .windowResizability(.contentSize)
    }
}
