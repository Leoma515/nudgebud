//
//  Item.swift
//  NudgeBud
//
//  Created by Jerry Moffett on 11/5/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
