//
//  Emoji.swift
//  Emoji-AppDevWSwift
//
//  Created by Admin on 25.09.17.
//  Copyright © 2017 NS. All rights reserved.
//

import Foundation

class Emoji {
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    init(symbol: String, name: String, description: String, usage: String) {
        self.symbol = symbol
        self.name = name
        self.description = description
        self.usage = usage
    }
}


