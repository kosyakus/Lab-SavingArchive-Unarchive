//
//  Emoji.swift
//  Emoji-AppDevWSwift
//
//  Created by Admin on 25.09.17.
//  Copyright © 2017 NS. All rights reserved.
//

import Foundation

class Emoji: NSObject, NSCoding {
    
    var symbol: String
    var name: String
    var detailDescription: String
    var usage: String
    
    init(symbol: String, name: String, detailDescription: String, usage: String) {
        self.symbol = symbol
        self.name = name
        self.detailDescription = detailDescription
        self.usage = usage
    }
    
    struct PropertyKey {
        static let symbol = "symbol"
        static let name = "name"
        static let detailDescription = "detailDescription"
        static let usage = "usage"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(symbol, forKey: PropertyKey.symbol)
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(detailDescription, forKey: PropertyKey.detailDescription)
        aCoder.encode(usage, forKey: PropertyKey.usage)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        guard let symbol = aDecoder.decodeObject(forKey: PropertyKey.symbol) as? String,
            let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String,
            let detailDescription = aDecoder.decodeObject(forKey: PropertyKey.detailDescription) as? String,
            let usage = aDecoder.decodeObject(forKey: PropertyKey.usage) as? String
            else {return nil}
        self.init(symbol: symbol, name: name, detailDescription: detailDescription, usage: usage)
        
    }
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("emojis")
    
    static func loadFromFile() -> [Emoji]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Emoji.ArchiveURL.path) as? [Emoji]
    }
    
    static func loadSampleEmojis() -> [Emoji] {
        return [
            Emoji(symbol:"🍋", name: "Lemon", detailDescription: "It is a fruit", usage: "Add to tea"),
            Emoji(symbol:"🥑", name: "Avocado", detailDescription: "It is a vegetable", usage: "Add to salads"),
            Emoji(symbol:"🥕", name: "Carrot", detailDescription: "It is a vegetable", usage: "Add to soup"),
            Emoji(symbol:"🍌", name: "Banana", detailDescription: "It is a fruit", usage: "Eat on breakfast"),
            Emoji(symbol:"🧀", name: "Cheese", detailDescription: "It is a food", usage: "Add to spagetty")
        ]
    }
    
    static func saveToFile(emojis: [Emoji]) {
        NSKeyedArchiver.archiveRootObject(emojis, toFile: Emoji.ArchiveURL.path)
    }
        
}


