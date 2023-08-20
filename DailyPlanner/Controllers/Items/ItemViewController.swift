//
//  ItemViewController.swift
//  DailyPlanner
//
//  Created by Oliwia Procyk on 16/08/2023.
//

import UIKit
import SnapKit
import RealmSwift

final class ItemViewController: UIViewController {
    private let tableView = UITableView()
    private lazy var addButton: Button = {
        let button = Button()
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    private let emptyView = EmptyStateView(message: "No items added yet 😰\nAdd one on the screen. ☺️")
    
    private var toDoItems: Results<Item>?
    private let realm = try! Realm()
    
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureAddButton()
        configureEmptyView()
        navigationController?.navigationBar.tintColor = .orange
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.reuseID)
        tableView.frame = view.bounds
    }
    
    private func configureEmptyView() {
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.right.top.left.bottom.equalToSuperview()
        }
    }
    
    private func configureAddButton() {
        view.addSubview(addButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
    }
    
    private func loadItems() {
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    
    private func showEmptyState() {
        if toDoItems?.count == 0 {
            emptyView.isHidden = false
        }
    }
    
    @objc func addButtonTapped() {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Item", message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add", style: .default) { action in
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        if !newItem.title.isEmpty {
                            currentCategory.items.append(newItem)
                        } else {
                            let alert = UIAlertController(title: "Alert", message: "To add new item, write one 🌼", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                } catch {
                    print("Error saving context \(error)")
                }
            }
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            alertTextField.tintColor = .black
            textField = alertTextField
        }
        
        addAction.setValue(UIColor.black, forKey: "titleTextColor")
        
        alert.addAction(addAction)
        present(alert, animated: true)
    }
}

//MARK: - UITableViewDataSource

extension ItemViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.reuseID, for: indexPath) as! ItemTableViewCell
        
        if let item = toDoItems?[indexPath.row] {
            cell.itemName.text = item.title
            cell.tintColor = .black
            cell.accessoryType = item.done ? .checkmark : .none
            emptyView.isHidden = true
        } else {
            cell.itemName.text = "No items added"
            emptyView.isHidden = true
        }
        showEmptyState()
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ItemViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = toDoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done.toggle()
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        if let item = toDoItems?[indexPath.row] {
            
            do {
                try realm.write {
                    realm.delete(item)
                    showEmptyState()
                }
            } catch {
                print("Error saving done status, \(error)")
            }
            tableView.reloadData()
        }
    }
}

