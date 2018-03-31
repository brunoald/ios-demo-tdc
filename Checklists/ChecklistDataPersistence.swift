//
//  ChecklistDataPersistence.swift
//  Checklists
//
//  Created by Larissa Barra Conde on 30/03/18.
//  Copyright © 2018 CapDev ThoughtWorks. All rights reserved.
//

import Foundation

class ChecklistDataPersistence {
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Checklists.plist")
    }
    
    func saveChecklistItems(items: [ChecklistItem]) {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(items)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding item array!")
        }
    }
    
    func loadChecklistItems() -> [ChecklistItem] {
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                let items = try decoder.decode([ChecklistItem].self, from: data)
                return items
            } catch {
                print("Error decoding item array!")
            }
        }
        return []
    }
}
