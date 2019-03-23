//
//  SelectTableShowBookingViewController.swift
//  NaRogax
//
//  Created by User on 23/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class SelectTableShowBookingViewController: UIViewController {
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var NoEmptyTablesLabel: UIStackView!
    private var userBooking = ResponseShowUserBooking()
    var chekAuto = RequestPostCheckAuto()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (!DataLoader.shared().testNetwork()){
            
        }else{
            DataLoader.shared().showUserBooking(data: chekAuto){ result, error in
                if error?.code == 200{
                    self.userBooking = result
                }else{
                    
                }
            }
        }
    }
}

extension SelectTableShowBookingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userBooking.bookings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
        cell.displayCancelBooking(booking: userBooking.bookings[indexPath.row], index: indexPath.row)
        return cell
    }
}
