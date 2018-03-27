//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Larissa Barra Conde on 27/03/18.
//  Copyright © 2018 CapDev ThoughtWorks. All rights reserved.
//

import Foundation

class ChecklistItem {
    var text = ""
    var checked = false
    
    init(text : String, checked : Bool) {
        self.text = text
        self.checked = checked
    }
}