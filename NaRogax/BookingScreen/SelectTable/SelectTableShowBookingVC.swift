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
    var chekAuto = RequestUserEmail()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        chekAuto.email = UserDefaults.standard.string(forKey: "email") ?? "zlobrynya@gmail.com"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkUserData()
    }
    
    private func checkUserData(){
        //тут происходит обращение к внутреней памяти и достаем данные
        if (!DataLoader.shared().testNetwork()){
            self.present(Alert.shared().noInternet(protocol: self), animated: true, completion: nil)
        }else{
            DataLoader.shared().checkAuto(){ error in
                print("checkUserData", error)
                switch error?.code{
                case 200:
                    self.getData()
                    break
                case 401, 422, 404:
                    self.startStoryAuto()
                    break
                default:
                    self.present(Alert.shared().couldServerDown(protocol: self), animated: true, completion: nil)
                    break
                }
            }
        }
    }
    
    private func startStoryAuto(){
        let storyboard = UIStoryboard(name: "SignInScreen", bundle: nil)
        let auto = storyboard.instantiateViewController(withIdentifier: "SignInScreen") as! SignInVC
        self.navigationController?.pushViewController(auto, animated: true)
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
                print("checkUserData", self.chekAuto)
                print("checkUserData", error)
                switch error?.code{
                case 200:
                    self.userBooking = result
                    self.TableView.reloadData()
                    break
                case 404:
                    self.startStoryAuto()
                    break
                default:
                    self.present(Alert.shared().couldServerDown(protocol: self), animated: true, completion: nil)
                    break
                }
            }
        }
    }
    
    private func deleteBooking(){
        let deleteUserBooking = RequestPostDeleteUserBooking(email: chekAuto.email, booking_id:userBooking.bookings[index].booking_id)
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
        return userBooking.bookings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
        cell.displayCancelBooking(booking: userBooking.bookings[indexPath.row], index: indexPath.row)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
