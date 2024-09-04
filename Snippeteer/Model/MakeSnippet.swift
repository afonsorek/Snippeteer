import SwiftUI

struct MakeSnippet: View {
    
    @State private var codeText = ""
    @State private var title = ""
    @State private var draggedText: String? = nil
    
    @Binding var tela: Int 
    
    func add(){
        _ = Snippets(name: title, snippet: codeText, type: "Custom")
        print(codeText)
    }
    
    var body: some View {
        VStack {
            Text("Snippet's Title")
                .font(.headline)
            
            TextField("", text: $title)
                .border(.gray)
            
            Text("Snippets's Code:")
                .font(.headline)
            
            TextEditor(text: $codeText)
                .frame(minWidth: 200, minHeight: 200)
                .font(.system(size: 30))
                .border(Color.gray)
                .padding()
                .onDrop(of: ["public.text"], isTargeted: nil) { providers, location in
                    if let itemProvider = providers.first {
                        itemProvider.loadItem(forTypeIdentifier: "public.text") { (data, error) in
                            if let textData = data as? Data, let text = String(data: textData, encoding: .utf8) {
                                self.draggedText = text
                            }
                        }
                    }
                    return true
                }
            
            if let draggedText = draggedText {
                Text("Texto Arrastado: \(draggedText)")
                    .padding()
            }
            
            Button("Save Snippet") {
                add()
                tela = 1
            }
            .font(.system(size: 20))
            .frame(width: 300, height: 30)
            .padding(10)
        }
        .padding()
    }
}



#Preview {
    MakeSnippet(tela: .constant(2))
}
