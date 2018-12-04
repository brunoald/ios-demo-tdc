//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Larissa Barra Conde on 28/03/18.
//  Copyright © 2018 CapDev ThoughtWorks. All rights reserved.
//

import UIKit
import RxSwift
import ProgressHUD

protocol ItemDetailViewControllerDelegate: class {
    func newItemAdded()
    func actionCancelled()
    func itemEdited()
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!

    var delegate: ItemDetailViewControllerDelegate?
    weak var dataProvider: ChecklistDataProviderType?

    var itemToEdit: ChecklistItem?

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.actionCancelled()
    }

    @IBAction func done(_ sender: Any) {
        if let itemText = textField.text {
            if let item = itemToEdit {
                item.text = itemText
                ProgressHUD.show()
                dataProvider?.editItem(item: item)
                    .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
                    .subscribe (onCompleted: {
                        self.delegate?.itemEdited()
                    })

            } else {
                ProgressHUD.show()
                dataProvider?.addItem(text: itemText, checked: false)
                    .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
                    .subscribe (onCompleted: {
                        self.delegate?.newItemAdded()
                    })
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never

        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
        }
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }

    /* text field delegate */
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        doneBarButton.isEnabled = !newText.isEmpty
        return true
    }
}
