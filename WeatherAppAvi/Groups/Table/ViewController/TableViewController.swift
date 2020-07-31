//
//  TableViewController.swift
//  WeatherAppAvi
//
//  Created by Alexandr Avizhits on 25.04.2020.
//  Copyright © 2020 AA. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var tableView: UITableView!
    
    // - Act
    @IBAction func addButtonAction(_ sender: Any) {
    let berlin = WeatherModel()
               berlin.name = "Berlin"
               berlin.main.temp = 14
               let insertIndexPath = IndexPath(item: weathers.count, section: 0)
               weathers.append(berlin)
               tableView.insertRows(at: [insertIndexPath], with: .right)
    }
    

    // - Data
    var weathers = [WeatherModel] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: -
// MARK: - Table View Data Source

extension TableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.nameLabel.text = weathers[indexPath.row].name
        return cell
    }
}

// MARK: -
// MARK: - Table View Delegate

extension TableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        weathers.remove(at: indexPath.row)
               if weathers.count > 0 {
                   tableView.deleteRows(at: [indexPath], with: .left)
               } else {
                   dismiss(animated: true, completion: nil)
               }
//        if indexPath.row % 2 == 0 {
//            cellsCount = cellsCount + 1
//            let insertIndexPath = IndexPath(item: cellsCount - 1, section: 0)
//            tableView.insertRows(at: [insertIndexPath], with: .automatic)
//        } else {
//            cellsCount = cellsCount - 1
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
    }
}

// MARK: -
// MARK: - Configure

private extension TableViewController {
    
    func configure() {
        configureTableView()
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}


