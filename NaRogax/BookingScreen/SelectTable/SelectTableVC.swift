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
    @IBOutlet weak var NoEmptyTablesLabel: UIStackView!
    
    var date = "2019-02-13"
    var time_from = "10:00:00"
    var date_to = "2019-02-13"
    var time_to = "12:00:00"
    var tables = ResponseTablesList(data: [])

    private var selectedTable = Table()
    private var item = -1
    private var table_id = 0
    private var table_info = ""
    private let alertSpinner = AlertSpinner()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tables.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
        cell.displayTable(table: tables.data[indexPath.row], index: indexPath.row)
        if (indexPath.row == tables.data.count - 1){
            cell.separatorHide()
        }
        return cell
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        TableView.delegate = self
        TableView.dataSource = self
        
        var date = RequestPostEmptyPlaces()
        date.date = self.date
        date.time_from = self.time_from
        date.date_to = self.date_to
        date.time_to = self.time_to
    }
    

    @IBAction func selectTable(_ sender: UIButton) {
        item = sender.tag
        startReserveScreen()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        alertSpinner.removeSpinner()
    }
    
    private func startReserveScreen(){
        alertSpinner.showSpinner(onView: view)
        if (!DataLoader.shared().testNetwork()){
            self.present(Alert.shared().noInternet(protocol: self), animated: true, completion: nil)
        } else {
            //TO DO: прилизать немного код, что б выглядело получше
            // Сделать что бы передавалась имя для брони
            if (item > -1){
                self.table_id = tables.data[item].table_id
                self.selectedTable = tables.data[item]
                
                var tableCountString = ""
                if selectedTable.chair_count == 4 {
                    tableCountString = String(selectedTable.chair_count) + " места"
                } else {
                    tableCountString = String(selectedTable.chair_count) + " мест"
                }
                
                if selectedTable.position?.isEmpty ?? true{
                    table_info = "Стол: № \(table_id) на \(tableCountString), \(selectedTable.chair_type)"
                }else{
                    table_info = "Стол: № \(table_id) на \(tableCountString), \(selectedTable.position ?? ""), \(selectedTable.chair_type)"
                }

                
                let storyboard = UIStoryboard(name: "ReserveScreen", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ReserveScreen") as! ReserveScreenVC
                
                vc.table_id = table_id
                vc.date = date
                vc.time_from = time_from
                vc.date_to = date_to
                vc.time_to = time_to
                vc.table_info = self.table_info
                
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "ru_RU")
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                dateFormatter.dateFormat = "HH:mm:ss"
                let start_time = dateFormatter.date(from: time_from)
                let end_time = dateFormatter.date(from: time_to)
                dateFormatter.dateFormat = "HH:mm"
                let s_time = dateFormatter.string(from: start_time!)
                let e_time = dateFormatter.string(from: end_time!)
                vc.table_time = s_time + " - " + e_time
                
                let today = Date()
                
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let today_str = dateFormatter.string(from: today)
                let resDate = dateFormatter.date(from: date)
                dateFormatter.dateFormat = "d MMMM"
                if today_str == date {
                    vc.table_date = "Сегодня, \(dateFormatter.string(from: today))"
                } else {
                    vc.table_date = dateFormatter.string(from: resDate!)
                }
                
                DataLoader.shared().checkAuto(){ result in
                    switch (result?.code){
                    case 200:
                        self.alertSpinner.removeSpinner()
                        self.navigationController?.pushViewController(vc, animated: true)
                        break
                    case 401:
                        self.alertSpinner.removeSpinner()
                        let storyboardSingIn = UIStoryboard(name: "SignInScreen", bundle: nil)
                        let vcSignIn = storyboardSingIn.instantiateViewController(withIdentifier: "SignInScreen") as! SignInVC
                        self.navigationController?.pushViewController(vcSignIn, animated: true)
                        break
                    default:
                        self.alertSpinner.removeSpinner()
                        break
                    }
                }
                
                //TO DO: сделать проверку на авторизованного пользователя
                
            }
        }
    }
}

extension SelectTableVC: AlertProtocol{
    func clickButtonPositiv(status: Int) {
        startReserveScreen()
    }
    
    func clickButtonCanсel(status: Int) {}

}
