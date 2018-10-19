//
//  ChecklistDataProvider.swift
//  Checklists
//
//  Created by Larissa Barra Conde on 27/03/18.
//  Copyright © 2018 CapDev ThoughtWorks. All rights reserved.
//

import Foundation

protocol ChecklistDataProviderDelegate {
    func getItems() -> [ChecklistItem]
    func addItem(text: String, checked: Bool)
    func editItem(item: ChecklistItem)
    func removeItem(index: Int)
}

class ChecklistDataProvider: ChecklistDataProviderDelegate {

    let persistence = ChecklistDataPersistence()

    var data: [ChecklistItem] = []

    func getItems() -> [ChecklistItem] {
        let loadedItems = persistence.loadChecklistItems()
        if !loadedItems.isEmpty {
            data = loadedItems
        }
        return data
    }

    func addItem(text: String, checked: Bool = false) {
        let newItem = ChecklistItem(text: text, checked: checked)
        data.append(newItem)
        persist()
    }

    func editItem(item: ChecklistItem) {
        if let index = data.index(of: item) {
            data[index] = item
            persist()
        }
    }

    func removeItem(index: Int) {
        data.remove(at: index)
        persist()
    }

    func persist() {
        persistence.saveChecklistItems(items: data)
    }
}
