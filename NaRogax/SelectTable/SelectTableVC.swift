//
//  SelectTableVC.swift
//  NaRogax
//
//  Created by User on 11/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class SelectTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var TableView: UITableView!
    
    
    /*struct Table {
        var table_id = 0
        var title = ""
        var desc = ""
    }*/
    
    var Tables: [Table] = []
    
    func createTable(id: Int, title: String, desc: String) {
        var table = Table()
        table.table_id = id
        table.desc = desc
        table.title = title
        
        Tables.append(table)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Tables.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
        cell.displayTable(table: Tables[indexPath.row])
            return cell
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        createTable(id: 0, title: "4 места", desc: "СТУЛЬЯ")
        createTable(id: 0, title: "4 места", desc: "ДИВАНЫ")
        createTable(id: 0, title: "4 места, у окна", desc: "СТУЛЬЯ")
        createTable(id: 0, title: "6 мест, у окна", desc: "ДИВАНЫ")
        createTable(id: 0, title: "8 мест, у окна", desc: "ДИВАНЫ")

        // Do any additional setup after loading the view.
        TableView.reloadData()
    }
    

}
