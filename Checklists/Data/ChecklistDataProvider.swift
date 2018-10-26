//
//  ChecklistDataProvider.swift
//  Checklists
//
//  Created by Larissa Barra Conde on 27/03/18.
//  Copyright © 2018 CapDev ThoughtWorks. All rights reserved.
//

import Foundation
import RxSwift

protocol ChecklistDataProviderType: class {
    func getItems() -> Observable<[ChecklistItem]>
    func addItem(text: String, checked: Bool) -> Observable<Void>
    func editItem(item: ChecklistItem) -> Observable<Void>
    func removeItem(index: Int) -> Observable<Void>
}

class ChecklistDataProvider: ChecklistDataProviderType {
    var persistence: ChecklistDataPersistenceDelegate
    var data: [ChecklistItem] = []

    init(persistence: ChecklistDataPersistenceDelegate) {
        self.persistence = persistence
    }

    func getItems() -> Observable<[ChecklistItem]> {
        return Observable<[ChecklistItem]>.create { (observer) -> Disposable in
            let loadedItems = self.persistence.loadChecklistItems()
            if !loadedItems.isEmpty {
                self.data = loadedItems
            }
            observer.onNext(self.data)
            observer.onCompleted()
            return Disposables.create()
        }
    }

    func addItem(text: String, checked: Bool = false) -> Observable<Void> {
        return Observable<Void>.create { (observer) -> Disposable in
            let newItem = ChecklistItem(text: text, checked: checked)
            self.data.append(newItem)
            self.persist()
            observer.onCompleted()
            return Disposables.create()
        }
    }

    func editItem(item: ChecklistItem) -> Observable<Void> {
        return Observable<Void>.create { (observer) -> Disposable in
            if let index = self.data.index(of: item) {
                self.data[index] = item
                self.persist()
                observer.onCompleted()
            } else {
                observer.onError(NSError())
            }
            return Disposables.create()
        }
    }

    func removeItem(index: Int) -> Observable<Void> {
        return Observable<Void>.create { (observer) -> Disposable in
            self.data.remove(at: index)
            self.persist()
            observer.onCompleted()
            return Disposables.create()
        }
    }

    private func persist() {
        persistence.saveChecklistItems(items: data)
    }
}
