//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Larissa Barra Conde on 28/03/18.
//  Copyright © 2018 CapDev ThoughtWorks. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD

protocol ItemDetailViewControllerDelegate: class {
    func newItemAdded()
    func actionCancelled()
    func itemEdited()
}

protocol ItemDetailView: class {
    func enableDoneButton()
    func disableDoneButton()
    func showLoading()
    func fillEditForm(content: String)
    func setScreenTitle(screenTitle: String)
    func showUpdatedItemList()
    func close()
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate, ItemDetailView {
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    var presenter: ItemDetailPresenter!
    var delegate: ItemDetailViewControllerDelegate?
    var dataProvider: ChecklistDataProviderType?
    var itemToEdit: ChecklistItem?

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        presenter.handleClickCancel()
    }

    @IBAction func done(_ sender: Any) {
        presenter.handleClickDone()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        presenter.changedTitle(title: textField.text!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ItemDetailPresenter(view: self, itemToEdit: itemToEdit, dataProvider: dataProvider!)
        presenter.start()
        
        navigationItem.largeTitleDisplayMode = .never
        _ = textField.rx.controlEvent([.editingChanged])
            .asObservable()
            .subscribe(onNext: {
                self.presenter.changedTitle(title: self.textField.text!)
            })

    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    func enableDoneButton() {
        doneBarButton.isEnabled = true
    }
    
    func disableDoneButton() {
        doneBarButton.isEnabled = false
    }
    
    func showLoading() {
        ProgressHUD.show()
    }
    
    func setScreenTitle(screenTitle: String) {
        title = screenTitle
    }
    
    func fillEditForm(content: String) {
        textField.text = content
    }
    
    func showUpdatedItemList() {
        self.delegate?.itemEdited()
    }
    
    func close() {
        delegate?.actionCancelled()
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print("Destroyed ItemDetailViewController")
    }
}
