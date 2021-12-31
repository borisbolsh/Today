//
//  ViewController.swift
//  Today
//
//  Created by Boris Bolshakov on 30.12.21.
//

import UIKit

final class ViewController: UIViewController {

    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupTableView()
    }

    override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
       
       tableView.frame = view.bounds
   }

}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ItemTableViewCell.preferredHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identfier, for: indexPath) as! ItemTableViewCell
        
        cell.configure(with: "Test \(indexPath.row)", date: "test date \(indexPath.row)")
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
}

// MARK: - Setup UI

private extension ViewController {
    func setupTableView() {
        view.addSubview(self.tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self

        tableView.register(ItemTableViewCell.self,
                           forCellReuseIdentifier: ItemTableViewCell.identfier)
    }
    
}
