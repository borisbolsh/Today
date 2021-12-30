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

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        cell.textLabel?.text = "text \(indexPath.row)"
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}

private extension ViewController {
    func setupTableView() {
        view.addSubview(self.tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self

    }
    
}
