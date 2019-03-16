//
//  HoursWork.swift
//  NaRogax
//
//  Created by User on 15/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import Foundation

class HoursWork{
    private let PRINT_DEBUG = false
    //для интервала времени
    private let TIME_INTERVAL: TimeInterval = 30
    private var startTimeD: Double = 0
    private var endTimeD: Double = 0
    private var arrayTime: [String] = []
    private var indexSelectTime: Int = 0
    //переменные для выбора сколько сидим
    private var arrayDurationTime: [String] = []
    private var indexSelectDuration: Int = 0
    private let START_DURATION: Double = 2
    private let STOP_DURATION: Double = 4
    
    //перерасчет времени
    func changeDay(day: String, today: Bool) {
        (startTimeD, endTimeD) = getOpenClose(day: day)
        calcTime(today: today)
    }
    
    //возвращает рабочие часы для брони
    private func getOpenClose(day: String) -> (open: Double, close: Double){
        switch day {
        case "вс":
            return (13, 20)
        case "сб":
            return (13, 23)
        case "пт":
            return (12, 21)
        default:
            return (12, 21)
        }
    }
   
    //Расчет интервала времени
    private func calcTime(today: Bool = false){
        var chekH = true
        if (today){
            chekH = setTimeToday()
        }
        var currentTime = startTimeD
        arrayTime.removeAll()
        //arrayTime.append("\(Int(startTimeD)):00")
        while currentTime < endTimeD {
            startTimeD += (TIME_INTERVAL/60)
            let hours = Int(floor(startTimeD))
            let minutes = Int(startTimeD.truncatingRemainder(dividingBy: 1)*60)
            currentTime = Double(hours)
            if chekH {
                arrayTime.append("\(hours):00")
            }else if minutes == 0 {
                arrayTime.append("\(hours):00")
            } else {
                arrayTime.append("\(hours):\(minutes)")
            }
        }
        if (PRINT_DEBUG){
            print(arrayTime)
        }
    }

    func getCountDurationTime() -> Int{
        return arrayDurationTime.count
    }
    
    func getItemDurationTime(index: Int) -> String {
        if (arrayDurationTime.count > 0){
            return arrayDurationTime[index]
        }else{
            return "Error"
        }
    }
    
    func getCountTime() -> Int {
        return arrayTime.count
    }
    
    func setIndexDuration(index: Int){
        indexSelectDuration = index
    }
    
    func getItemTime(item: Int) -> String {
        if (arrayTime.count > 0){
            return arrayTime[item]
        }else{
            return "Error"
        }
    }
    
    //расчитываем на сколько можно забронировть
    func calcDurationTime(){
        arrayDurationTime.removeAll()
        var culcTime = START_DURATION
        while culcTime <= STOP_DURATION{
            let time = culcTimeTo(interval: String(culcTime))
            if (PRINT_DEBUG){
                print(time)
            }
            if (time.timeH < 0 || time.timeM < 0){
                break
            }
            if (PRINT_DEBUG){
                print(culcTime, time)
            }
            if (Double(time.timeH) < endTimeD + 2){
                arrayDurationTime.append(String(culcTime))
                culcTime += 0.5
            } else {
                if (time.timeM < 30){
                    arrayDurationTime.append(String(culcTime))
                }
                break
            }
            
        }
        if (PRINT_DEBUG){
            print(arrayDurationTime)
        }
    }
    
    //когда пользователь выбирает время индекс передается сюда
    // и сохраняется
    func selectIndex(index: Int){
        indexSelectTime = index
    }
    
    //расчитывает до скольки будет сидеть
    private func culcTimeTo(interval: String) -> (timeH: Int, timeM: Int){
        let timeInterval = interval.split(separator: ".")
        if (arrayTime.count > 0){
            let selectTime = arrayTime[indexSelectTime].split(separator: ":")
            //считаем минуты
            var timeToM:Int = Int(selectTime[1])! + Int(timeInterval[1])!
            var addHours = 0
            if (timeToM == 10){
                timeToM = 0
                addHours = 1
            }
            //расчет часов
            let timeToH: Int = Int(selectTime[0])! + Int(timeInterval[0])! + addHours
            return (timeToH, timeToM)
        }
        return (-1,-1)
    }
    
    func getDataToServer(day: String) -> (timeFrom: String, timeTo: String, dateFrom: String, dateTo: String) {
        let time = getTime()
        let data = getDate(timeTo: time.timeTo, day: day)
        return (time.timeFrom, time.timeTo, data.date, data.dateTo)
    }
    
    //получает время для отпаврки на сервер
    //где interval - на сколько люди будут бронировать
    //возвращает: timeFrom - со сколько, timeTo - до скольки
    private func getTime() -> (timeFrom: String, timeTo: String) {
        var timeTo = ""
        if (indexSelectDuration < arrayDurationTime.count){
            let time = culcTimeTo(interval: arrayDurationTime[indexSelectDuration])
            if !(time.timeH < 0 || time.timeM < 0){
                switch time.timeH {
                case 24:
                    timeTo = "00:"
                    break
                case 25:
                    timeTo = "01:"
                    break
                default:
                    timeTo = "\(time.timeH):"
                }
                //дописываем минуты
                if (time.timeM == 0){
                    timeTo += "00:00"
                }else{
                    timeTo += "30:00"
                }
                return (arrayTime[indexSelectTime]+":00", timeTo)
            }
        }
        return ("", "")
    }
 
    //для сервера
    //возращает дату в ячейке и расчитывает дату до какого бронируют
    private func getDate(timeTo time: String, day: String) -> (date: String, dateTo: String){
        var dateTo = ""
        switch time.split(separator: ":")[0] {
        case "01", "00":
            let splitDate = day.split(separator: "-")
            var day: Int = Int(splitDate[2]) ?? 0
            day += 1
            dateTo = splitDate[0] + "-" + splitDate[1] + "-" + String(day)
            break
        default:
            dateTo = day
            break
        }
        return (day, dateTo)
    }
    
    func getSelectTime() -> String {
        if (arrayTime.count > 0){
            return arrayTime[indexSelectTime]
        }
        return ""
    }
    
    /*
     *  Методы для текущего дня
     */
    //метод для расчета текущего часа
    private func setTimeToday() -> Bool{
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        if !(Double(hour) < startTimeD){
            var hourAdd = 3
            if (calendar.component(.minute, from: date) >= 30){
                hourAdd += 1
            }else{
                return false
            }
            //Ограничение на сегоднешнний день + 3 часа от текущего времени
            startTimeD = Double(calendar.component(.hour, from: date) + hourAdd)
        }
        return true
    }
    
    
    func isBookingCloseToday(day: String) -> Bool{
        let calendar = Calendar.current
        let hours = calendar.component(.hour, from: Date())
        let workhours = getOpenClose(day: day)
        if (PRINT_DEBUG){
            print("isBookingCloseToday", hours, workhours)
        }
        return Int((workhours.close - 2)) < hours
    }
}
