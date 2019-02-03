import RxSwift

class ItemDetailPresenter {
    weak var view: ItemDetailView!
    var itemToEdit: ChecklistItem?
    var currentTitle: String?
    var dataProvider: ChecklistDataProviderType?
    
    init(view: ItemDetailView, itemToEdit: ChecklistItem?, dataProvider: ChecklistDataProviderType) {
        self.itemToEdit = itemToEdit
        self.view = view
        self.dataProvider = dataProvider
        
        if let item = itemToEdit {
            currentTitle = item.text
        }
        print("Created ItemDetailPresenter")
    }
    
    deinit {
        print("Destroyed ItemDetailPresenter")
    }
    
    func start() {
        if let item = itemToEdit {
            view.setScreenTitle(screenTitle: "Edit Item")
            view.fillEditForm(content: item.text)
            view.enableDoneButton()
        }
    }
    
    func handleClickCancel() {
        view.close()
    }
    
    func handleClickDone() {
        if let itemText = currentTitle {
            if let item = itemToEdit {
                item.text = itemText
                view.showLoading()
                _ = dataProvider?.editItem(item: item)
                    .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
                    .subscribe {
                        self.view.showUpdatedItemList()
                    }
                
            } else {
                view.showLoading()
                _ = dataProvider?.addItem(text: itemText, checked: false)
                    .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
                    .subscribe {
                        self.view.showUpdatedItemList()
                    }
            }
        }
    }
    
    func changedTitle(title: String) {
        currentTitle = title
        
        if currentTitle!.isEmpty {
            view.disableDoneButton()
        } else {
            view.enableDoneButton()
        }
    }
}
