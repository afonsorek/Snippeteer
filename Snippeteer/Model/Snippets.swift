import SwiftUI
import Foundation


let palavras = ["if", "else if", "else", "return", "class", "struct", "func", "var", "let", "true", "false", "for", "switch", "case"]

class Snippets: Identifiable, Codable{
    let id: UUID
    var name: String
    var snippet: String
    var type: String
    
    init(name: String, snippet: String, type: String) {
        self.id = UUID()
        self.name = name
        self.snippet = snippet
        self.type = type
        
        if type != "Custom"{
            register()
        }else{
            registerUser()
        }
    }
    
    func registerUser(){
        SnippetsUserManager.shared.add(snippet: self)
    }
    
    func register(){
        SnippetsManager.shared.add(snippet: self)
    }
    
    func getName() -> String{
        return name
    }
    
    func getSnippet() -> String{
        return snippet
    }
    
    func getType() -> String{
        return type
    }
    
    func getSelf() -> Snippets{
        return self
    }

    func formatted() -> Text{
        var final = Text("")
        let abc:[String] =  snippet.components(separatedBy: " ")
        
        for word in abc{
            if palavras.contains(word){
                final = final + Text("\(word) ").foregroundColor(.red)
            }else if word.hasPrefix("."){
                final = final + Text("\(word) ").foregroundColor(.purple)
            }else if word.hasSuffix(")"){
                final = final + Text("\(word) ").foregroundColor(.purple)
            }else if word.hasPrefix("//"){
                final = final + Text("\(word) ").foregroundColor(.gray)
            }else {
                final = final + Text("\(word) ")
            }
        }
        
        return final
    }
}

class SnippetsManager: ObservableObject {
    @Published var snippets: [Snippets] = []
    
    static let shared = SnippetsManager()
    
    private init(){}
    
    func add(snippet: Snippets) {
        snippets.append(snippet)
    }
    
    func removeAll() {
        snippets.removeAll()
    }
}

class SnippetsUserManager {
    @Published var snippetsUser: [Snippets] = []
    @Published var snippetsUserFav: [Snippets] = []
    
    static let shared = SnippetsUserManager()
    
    private init(){}
    
    func add(snippet: Snippets) {
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(snippet){
            UserDefaults.standard.set(encoded, forKey: snippet.name)
        }

        //snippetsUser.append(snippet)
    }
    
    func addFav(snippet: Snippets) {
        let encoder = JSONEncoder()
        
        snippet.name+=" (Favourite)"
        
        if let encoded = try? encoder.encode(snippet){
            UserDefaults.standard.set(encoded, forKey: snippet.name)
            print("ADICIONADO SNIPPET COM CHAVE: \(snippet.name)")
        }

        //snippetsUser.append(snippet)
    }
    
    func getAll(){
        snippetsUser.removeAll()
        
        let decoder = JSONDecoder()
        
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        
        dictionary.keys.forEach { key in
            
            if let data = defaults.data(forKey: key){
                let decoded = try? decoder.decode(Snippets.self, from: data)
                
                snippetsUser.append(decoded!)
                
                if key.hasSuffix(" (Favourite)"){
                    if !snippetsUserFav.contains(where: {key == $0.name}){
                        print("Adicionei o snippet \(key) aos favoritos")
                        snippetsUserFav.append(decoded!)
                    }
                }
            }
        }
        
        snippetsUser.sort{
            $0.name < $1.name
        }
        snippetsUserFav.sort{
            $0.name < $1.name
        }
    }
    func RemoveFav(card: Snippets){
        UserDefaults.standard.dictionaryRepresentation().keys.forEach { key in
            if key == card.name{
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }
    
    func RemoveDefault(){
        UserDefaults.standard.dictionaryRepresentation().keys.forEach { key in
            UserDefaults.standard.removeObject(forKey: key)
        }
    }
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}
