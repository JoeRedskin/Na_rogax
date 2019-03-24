//
//  SelectTableShowBookingViewController.swift
//  NaRogax
//
//  Created by User on 23/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class SelectTableShowBookingVC: UIViewController {
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var NoEmptyTablesLabel: UIStackView!
    private var userBooking = ResponseShowUserBooking()
    private var CODE_ALERT_DELETE = 100
    private var index = -1
    var chekAuto = RequestPostCheckAuto()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getData()
    }
    
    @IBAction func clickButton(_ sender: UIButton) {
        index = sender.tag
        self.present(Alert.shared().canselBooking(status: CODE_ALERT_DELETE, protocol: self,time: userBooking.bookings[index].configData()), animated: true, completion: nil)
    }
    
    private func getData(){
        if (!DataLoader.shared().testNetwork()){
            self.present(Alert.shared().noInternet(protocol: self), animated: true, completion: nil)
        }else{
            DataLoader.shared().showUserBooking(data: chekAuto){ result, error in
                if error?.code == 200{
                    self.userBooking = result
                    self.TableView.reloadData()
                }else{
                    self.present(Alert.shared().couldServerDown(protocol: self), animated: true, completion: nil)
                }
            }
        }
    }
    
    private func deleteBooking(){
        let deleteUserBooking = RequestPostDeleteUserBooking(email: chekAuto.email, uuid: chekAuto.uuid, booking_id:userBooking.bookings[index].booking_id)
        if (!DataLoader.shared().testNetwork()){
            self.present(Alert.shared().noInternet(protocol: self), animated: true, completion: nil)
        }else{
            DataLoader.shared().userDeleteUserBooking(data: deleteUserBooking){ result in
                if result?.code == 200{
                    self.userBooking.bookings.remove(at: self.index)
                    self.TableView.reloadData()
                }else{
                    self.present(Alert.shared().couldServerDown(protocol: self), animated: true, completion: nil)
                }
            }
        }
    }
}

extension SelectTableShowBookingVC: AlertProtocol{
    func clickButtonPositiv(status: Int) {
        if (status == CODE_ALERT_DELETE){
            deleteBooking()
        }else{
            getData()
        }
    }
    
    func clickButtonCanсel(status: Int) {}
}

extension SelectTableShowBookingVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableView",userBooking.bookings.count)
        return userBooking.bookings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
        cell.displayCancelBooking(booking: userBooking.bookings[indexPath.row], index: indexPath.row)
        print("tableView",cell)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
