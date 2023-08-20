//
//  ViewController.swift
//  DailyPlanner
//
//  Created by Oliwia Procyk on 29/07/2023.
//

import UIKit
import SnapKit
import RealmSwift

final class MainViewController: UIViewController {
    
    private let tableView = UITableView()
    private lazy var addButton: Button = {
        let button = Button()
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    private let emptyView = EmptyStateView(message: "No categories added yet 💔\nAdd one on the screen. ❤️")
    
    private let realm = try! Realm()
    private var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureAddButton()
        configureUI()
        configureEmptyView()
        loadCategories()
    }
    
    private func configureUI() {
        title = "DailyPlanner👩🏼‍💻"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemGray2]
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseID)
        tableView.frame = view.bounds
    }
    
    private func configureAddButton() {
        view.addSubview(addButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
    }
    
    private func configureEmptyView() {
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.right.top.left.bottom.equalToSuperview()
        }
    }
    
    private func saveCategories(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
    private func loadCategories() {
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    private func showEmptyState() {
        if categories?.count == 0 {
            emptyView.isHidden = false
        }
    }
    
    @objc func addButtonTapped() {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { action in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            if !newCategory.name.isEmpty {
                self.saveCategories(category: newCategory)
            } else {
                let alert = UIAlertController(title: "Alert", message: "To add new category, write one 🌼", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new category"
            alertTextField.tintColor = .black
            textField = alertTextField
        }
        
        action.setValue(UIColor.black, forKey: "titleTextColor")
        
        alert.addAction(action)
        present(alert, animated: true)
    }
}

//MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseID, for: indexPath) as! MainTableViewCell
        
        if let category = categories?[indexPath.row] {
            cell.categoryName.text = category.name
            emptyView.isHidden = true
        } else {
            cell.categoryName.text = "No categories added yet"
            emptyView.isHidden = true
        }
        showEmptyState()
        
        cell.categoryName.text = categories?[indexPath.row].name ?? "No categories added yet"
        return cell
    }
}

//MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = ItemViewController()
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        if let category = categories?[indexPath.row] {
            
            do {
                try realm.write {
                    realm.delete(category)
                    showEmptyState()
                }
            } catch {
                print("Error saving done status, \(error)")
            }
            tableView.reloadData()
        }
    }
}

