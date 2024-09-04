import SwiftUI

struct ContentView: View {
	@State var showView = false
    @State var showInfo = false
    @State var showInfo2 = false
	@State var collection = "Snippeteer"
    @State var op = 1.0
    @State var op2 = 1.0
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	
	init(){
		SnippetsManager.shared.removeAll()
		addSnippets()
	}
    
    func handleHover(hover2: Bool) {
        op2 = hover2 ? 0.4 : 1.0
        showInfo2 = hover2
        //NSCursor.crosshair.push()
//        if hover2 {
//            print("Dentro")
//            NSCursor.crosshair.push()
//        } else {
//            print("Fora")
//            NSCursor.pop()
//        }
    }
// TAMANHO FONTE; geometry.size.height*0.08
	//-------------------------------------------------------------//

    
    
    
    var body: some View {
		GeometryReader { geometry in
			HStack{
				ZStack{
					VStack(spacing: 40){
                        
						HStack(spacing: 40){
                            ZStack{
                                BlockView(geometry: geometry)
                                    .opacity(op2)
                                Text(showInfo2 ? """
                                        view
                                        """ :
                                        """
                                        Basic
                                        """)
                                    .font(
                                        Font.custom("Source Code Pro", size: geometry.size.height*0.08)
                                        .weight(.semibold)
                                    )
                                    .foregroundColor(.white)
                            }
                            .onTapGesture {
                                withAnimation(){
                                    collection = "Basics"
                                    showView.toggle()
                                }
                            }
                            .onHover(perform: handleHover)
                            
                            
                            ZStack{
                                BlockView(geometry: geometry)
                                    .opacity(op)
                                if showInfo == true{
                                    Text("""
                                            view
                                            """)
                                        .font(
                                          Font.custom("Source Code Pro", size: geometry.size.height*0.08)
                                            .weight(.semibold)
                                        )
                                        .foregroundColor(.white)
                                } else{
                                    Text("Advanced")
                                        .font(
                                          Font.custom("Source Code Pro", size: geometry.size.height*0.08)
                                            .weight(.semibold)
                                        )
                                        .foregroundColor(.white)
                                }
                            }
                            .onTapGesture {
                                withAnimation(){
                                    collection = "Advanced"
                                    showView.toggle()
                                }
                            }
                            .onHover(perform: { hover in
                                op = hover ? 0.4 : 1.0
                                
                                showInfo = hover ? true : false
                                
//                                        if (showInfo) {
//                                            NSCursor.pointingHand.push()
//                                        } else {
//                                            NSCursor.pop()
//                                        }
                            })

						}
						
						
					}
					.frame(width: 400, height: 200)
					
					if showView{
						ZStack{
							SnippetsSoloView(collection: self.collection)
                                .padding(.top, geometry.size.height * 0.1)
							
                            VStack(spacing: 0){
                                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                                    
                                    Spacer()

                                    Text(collection)
                                        .font(Font.custom("Source Code Pro", size: geometry.size.height*0.05))
                                    
                                    Spacer()
                                    
                                    Button("voltar"){
                                        withAnimation{
                                            collection = "Snippeteer"
                                            showView.toggle()
                                        }
                                    }
                                    .padding(.trailing, geometry.size.width*0.1)
                                    
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
	
	//-------------------------------------------------------------//

	func addSnippets(){
		_ = Snippets(name: "if statement", snippet: """
		if condition {
			Action
		} else if condition {
			Action
		} else {
			Action
		}
		""", type: "Basics")

		_ = Snippets(name: "for statement", snippet: """
		for variable in collection {
			print(variable)
		}
		""", type: "Basics")

		_ = Snippets(name: "while statement", snippet: """
		var count = 0

		while condition {
			count += 1
			if count == 5 {
				//Stop
				condition = false
			}
		}
		""", type: "Basics")

		_ = Snippets(name: "switch statement", snippet: """
		switch value {
		case pattern1:
			Action1
		case pattern2:
			Action2
		default:
			DefaultAction
		}
		""", type: "Basics")

		_ = Snippets(name: "function declaration", snippet: """
		func functionName(parameter1: Type1, parameter2: Type2) -> ReturnType {
			// Function body
			return someValue
		}
		""", type: "Basics")

		_ = Snippets(name: "class declaration", snippet: """
		class ClassName {
			var property1: Type1
			var property2: Type2

			init(property1: Type1, property2: Type2) {
				self.property1 = property1
				self.property2 = property2
			}

			func method() {
				// Method body
			}
		}
		""", type: "Basics")
        
        _ = Snippets(name: "Concurrency with async/await", snippet: """
            async {
                let result = await someAsyncTask()
                // Handle the result
            }
            """, type: "Advanced")

        _ = Snippets(name: "Combine Framework Publisher", snippet: """
            let publisher = URLSession.shared.dataTaskPublisher(for: url)
                .map(\\.data)
                .decode(type: MyModel.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        // Handle completion
                    case .failure(let error):
                        // Handle error
                    }
                } receiveValue: { model in
                    // Handle the received model
                }
            """, type: "Advanced")

         _ = Snippets(name: "Custom Operators", snippet: """
            infix operator <^>: AdditionPrecedence
            func <^><A, B>(lhs: (A) -> B, rhs: A?) -> B? {
                return rhs.map(lhs)
            }
            // Usage: let result = someFunction <^> optionalValue
            """, type: "Advanced")

         _ = Snippets(name: "Core Data Fetch Request", snippet: """
            let request: NSFetchRequest<NSManagedObject> = MyEntity.fetchRequest()
            request.predicate = NSPredicate(format: "attribute = %@", someValue)
            request.sortDescriptors = [NSSortDescriptor(key: "attribute", ascending: true)]
            let fetchedObjects = try? context.fetch(request)
            """, type: "Advanced")

        _ = Snippets(name: "Advanced Pattern Matching", snippet: """
            switch someValue {
            case .case1(let associatedValue):
                // Handle case1 with associatedValue
            case .case2 where condition:
                // Handle case2 with condition
            case .case3, .case4:
                // Handle case3 or case4
            default:
                // Handle other cases
            }
            """, type: "Advanced")
	}
	
}




#Preview {
    ContentView()
}
