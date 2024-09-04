import SwiftUI

struct SnippetsSoloView: View {
    let pasteboard = NSPasteboard.general
    
    @State private var isAppearing = false
    @State private var isAppearingC = false
    @State private var cardsOfType: [Snippets] = []
    @State var cardClicked = ""
    
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    let collection: String
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 300))]
    
    func isFav(card: Snippets) -> Bool{
        if cardClicked == card.id.uuidString{
            SnippetsUserManager.shared.getAll()
            
            print("\nChecagem do card \(card.name)\n")

            for i in SnippetsUserManager.shared.snippetsUserFav{
                print("Comaprando com: \(i.name)")
                if i.name == card.name+" (Favourite)"{
                    print("Retornei True!")
                    return true
                }else{
                    //
                }
            }
        }
        
        return false
    }
    
    func BotaoFav(card: Snippets){
        if isFav(card: card){
            SnippetsUserManager.shared.RemoveFav(card: card)
            print("Card \(card.name) removed from fav.")
        } else {
            SnippetsUserManager.shared.addFav(snippet: card)
            print("Card \(card.name) added to fav.")
            print(SnippetsUserManager.shared.snippetsUserFav)
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack{
                ScrollView{
                    VStack{
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(cardsOfType.indices, id: \.self) { index in
                                let card = cardsOfType[index]
                                ZStack{
                                    VStack{
                                        ZStack{
                                            Rectangle()
                                                .frame(width: 300, height: 30)
                                                .background(Color.black)
                                                .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 20, topTrailing: 20), style: .circular))
                                                .opacity(0.4)
                                            HStack{
                                                Button{
                                                    cardClicked = card.id.uuidString
                                                    
                                                    BotaoFav(card: card)
                                                    
                                                    print("Estado do card \(card.name): \(isFav(card: card))")
                                                    
                                                }label:{
                                                    Image(systemName: isFav(card: card) && cardClicked == card.id.uuidString ? "star.fill" : "star")
                                                }
                                                Text(card.name)
                                                    .foregroundColor(.white)
                                                
                                                Button {
                                                    pasteboard.setString(card.snippet, forType: .string)
                                                    isAppearing.toggle()
                                                    cardClicked = card.id.uuidString
                                                } label:{
                                                    Image(systemName: "clipboard")
                                                }
                                            }
                                        }

                                        ZStack{
                                            ScrollView {
                                                card.formatted()
                                                    .font(Font.custom("Source Code Pro", size: 14))
                                                    .foregroundColor(.white)
                                                    .background(Color.black)
                                                    .draggable(card.snippet)
                                            }
                                            .frame(width: 300, height: 300) // Ajuste a altura conforme necessário
                                            .background(Color.black)
                                            .clipShape(.rect(cornerRadii: RectangleCornerRadii(bottomLeading: 20, bottomTrailing: 20), style: .circular))
                                            .multilineTextAlignment(.leading)
                                            
                                            if isAppearing && cardClicked == card.id.uuidString {
                                                ZStack{
                                                    Rectangle()
                                                        .foregroundStyle(.black)
                                                        .opacity(0.3)
                                                    ActionView(action: "base")
                                                        .onReceive(timer) { _ in
                                                            withAnimation(.easeInOut(duration: 0.2)){
                                                                isAppearing.toggle()
                                                                cardClicked = ""
                                                                timer.upstream.connect().cancel()
                                                            }
                                                        }
                                                }
                                            }
                                        }
                                        
                                        Spacer()
                                    }
                                }
                                .padding(10) // Espaçamento entre os cards
                                .offset(y: isAppearingC ? 0 : -geometry.size.height)
                                .animation(.easeInOut(duration: 0.5).delay(Double(index) * 0.1), value: isAppearingC)
                            }
                        }
                        .padding(.top, 25)
                        Spacer()
                    }
                    .onAppear {
                        pasteboard.declareTypes([.string], owner: nil)
                        
                        //Por que não funciona?
                        cardsOfType.removeAll()
                        
                        if collection != "Custom"{
                            if collection == "Favourites"{
                                SnippetsUserManager.shared.getAll()
                                for i in SnippetsUserManager.shared.snippetsUserFav {
                                    if i.type == collection {
                                        cardsOfType.append(i)
                                    }
                                }
                            }else{
                                for i in SnippetsManager.shared.snippets {
                                    if i.type == collection {
                                        cardsOfType.append(i)
                                    }
                                }
                            }
                            
                        }else{
                            SnippetsUserManager.shared.getAll()
                            for i in SnippetsUserManager.shared.snippetsUser {
                                if i.type == collection {
                                    cardsOfType.append(i)
                                }
                            }
                        }

                        withAnimation{
                            isAppearingC.toggle()
                        }

                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color(red: 0.02, green: 0, blue: 0.11))
        }
    }
}

#Preview {
    SnippetsSoloView(collection: "")
}

