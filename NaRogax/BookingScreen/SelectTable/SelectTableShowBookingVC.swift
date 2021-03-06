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
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var buttonAuto: UIButton!
    
    private let TEXT_NO_BOOKING = "У вас нет активных  бронирований."
    private let TEXT_NO_AUTO = "Для просмотра списка бронирований, пожалуйста, войдите в свой профиль."
    private var userBooking = ResponseShowUserBooking()
    private var CODE_ALERT_DELETE = 100
    private var index = -1
    private let alertSpinner = AlertSpinner()
    
    var chekAuto = RequestUserEmail()

    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let newEmail = UserDefaults.standard.string(forKey: "email") ?? ""
        if (chekAuto.email != newEmail){
            chekAuto.email = newEmail
            self.TableView.isHidden = true
            userBooking.bookings.removeAll()
            self.TableView.reloadData()
        }
        checkUserData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.TableView.isHidden = true
    }
    
    private func checkUserData(){
        //тут происходит обращение к внутреней памяти и достаем данные
        if (!DataLoader.shared().testNetwork()){
            self.present(Alert.shared().noInternet(protocol: self), animated: true, completion: nil)
        }else{
            DataLoader.shared().checkAuto(){ error in
                switch error?.code{
                case 200:
                    self.buttonAuto.isHidden = true
                    self.TableView.isHidden = false
                    self.labelText.isHidden = true
                    if (self.userBooking.bookings.count == 0){
                        self.alertSpinner.showSpinner(onView: self.view)
                    }
                    self.getData()
                    break
                case 401, 422, 404:
                    //self.startStoryAuto()
                    self.TableView.isHidden = true
                    self.buttonAuto.isHidden = false
                    self.labelText.isHidden = false
                    self.labelText.text = self.TEXT_NO_AUTO
                    self.alertSpinner.removeSpinner()
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
        alertSpinner.showSpinner(onView: view)
        index = sender.tag
        self.present(Alert.shared().canselBooking(status: CODE_ALERT_DELETE, protocol: self,time: userBooking.bookings[index].configData()), animated: true, completion: nil)
    }
    
    @IBAction func clickButtonAuto(_ sender: UIButton) {
        buttonAuto.isHidden = true
        labelText.isHidden = true
        startStoryAuto()
    }
    
    
    private func getData(){
        if (!DataLoader.shared().testNetwork()){
            self.present(Alert.shared().noInternet(protocol: self), animated: true, completion: nil)
        }else{
            DataLoader.shared().showUserBooking(){ result, error in
                switch error?.code{
                case 200:
                    if (result.bookings.count == 0){
                        self.labelText.isHidden = false
                        self.TableView.isHidden = true
                        self.labelText.text = self.TEXT_NO_BOOKING
                        self.userBooking.bookings.removeAll()
                        self.TableView.reloadData()
                    }else{
                        self.userBooking = result
                        self.TableView.isHidden = false
                        self.TableView.reloadData()
                    }
                    break
                case 401:
                    self.startStoryAuto()
                    break
                case 404:
                    DataLoader.shared().exitLogin()
                    self.TableView.isHidden = true
                    self.buttonAuto.isHidden = false
                    self.labelText.isHidden = false
                    self.labelText.text = self.TEXT_NO_AUTO
                    break
                default:
                    self.present(Alert.shared().couldServerDown(protocol: self), animated: true, completion: nil)
                    break
                }
                self.alertSpinner.removeSpinner()
            }
        }
    }
    
    private func deleteBooking(){
        //self.alertSpinner.showSpinner(onView: view)
        let deleteUserBooking = RequestPostDeleteUserBooking(email: chekAuto.email, booking_id:userBooking.bookings[index].booking_id)
        if (!DataLoader.shared().testNetwork()){
            self.present(Alert.shared().noInternet(protocol: self), animated: true, completion: nil)
        }else{
            DataLoader.shared().userDeleteUserBooking(data: deleteUserBooking){ result in
                switch result?.code{
                case 200, 404:
                    self.userBooking.bookings.remove(at: self.index)
                    self.TableView.reloadData()
                    if self.userBooking.bookings.count == 0{
                        self.labelText.isHidden = false
                        self.labelText.text = self.TEXT_NO_BOOKING
                        self.TableView.isHidden = true
                    }
                    self.alertSpinner.removeSpinner()
                    break
                case 401:
                    self.alertSpinner.removeSpinner()
                    self.startStoryAuto()
                    break
                default:
                    self.alertSpinner.removeSpinner()
                    self.present(Alert.shared().couldServerDown(protocol: self), animated: true, completion: nil)
                    break
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
        cell.separatorHide(isHidden: indexPath.row == userBooking.bookings.count - 1)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
