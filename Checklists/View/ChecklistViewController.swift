//
//  ViewController.swift
//  Checklists
//
//  Created by Larissa Barra Conde on 27/03/18.
//  Copyright © 2018 CapDev ThoughtWorks. All rights reserved.
//
import Foundation
import UIKit
import RxSwift

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {

    var dataProvider: ChecklistDataProviderType!
    var items: [ChecklistItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(self.loadItems), for: .valueChanged)

        loadItems()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let itemDetailScreen = segue.destination as! ItemDetailViewController
        itemDetailScreen.delegate = self
        itemDetailScreen.dataProvider = dataProvider

        if segue.identifier == "goToEditItem" {
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                itemDetailScreen.itemToEdit = items[indexPath.row]
            }
        }
    }

    /* ItemDetail delegate */
    func newItemAdded() {
        loadItems()
        dismissItemDetailScreen()
    }

    func itemEdited() {
        loadItems()
        dismissItemDetailScreen()
    }

    func actionCancelled() {
        dismissItemDetailScreen()
    }

    /* Data Source section */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: "ChecklistItem", for: indexPath)
        let item = items[indexPath.row]

        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)

        return cell
    }

    /* Delegate section */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for: cell, with: item)
            dataProvider.editItem(item: item)
                .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
                .subscribe(onCompleted: {
                self.loadItems()
            })
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        dataProvider.removeItem(index: indexPath.row)
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .subscribe(onCompleted: {
            self.loadItems()
        })
    }

    /* class methods */
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1001) as! UILabel
        label.text = item.checked ? "√" : ""
    }

    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }

    @objc func loadItems() {
        _ = dataProvider.getItems()
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: {
            self.items = $0
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        })
    }
    
    func dismissItemDetailScreen() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
