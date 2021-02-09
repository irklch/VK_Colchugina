//
//  NewsControllerTableViewController.swift
//  L2_Colchugina_Irina
//
//  Created by Ирина Кольчугина on 22.11.2020.
//

import UIKit

class NewsController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPublics.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.publicIconImageView.image = allPublics[indexPath.row].icon
        cell.publicNameLable.text = allPublics[indexPath.row].name
        cell.publicationDateLable.text = String(generateRandomDate())
        cell.newsIconImageView.image = allPublics[indexPath.row].newsIcon
        cell.newsTextLable.text = allPublics[indexPath.row].newsText
        return cell
    }
    
    func generateRandomDate() -> String {
        let monthNumber = Int.random(in: 1...12)
        var monthName: String = ""
        var daysInMonth: Int = 0
        switch monthNumber{
        case 1:
            daysInMonth = 31
            monthName = "January"
        case 2:
            daysInMonth = 30
            monthName = "February"
        case 3:
            daysInMonth = 31
            monthName = "March"
        case 4:
            daysInMonth = 30
            monthName = "Aprile"
        case 5:
            daysInMonth = 31
            monthName = "May"
        case 6:
            daysInMonth = 30
            monthName = "June"
        case 7:
            daysInMonth = 31
            monthName = "Jule"
        case 8:
            daysInMonth = 31
            monthName = "August"
        case 9:
            daysInMonth = 30
            monthName = "September"
        case 10:
            daysInMonth = 31
            monthName = "October"
        case 11:
            daysInMonth = 30
            monthName = "November"
        case 12:
            daysInMonth = 31
            monthName = "December"
            
        default: print()
        }
        let day = Int.random(in: 1...daysInMonth)
        let hourNumber = Int.random(in: 0...23)
        let minutesNumber = Int.random(in: 0...59)
        var hour: String = ""
        var minutes: String = ""
        switch hourNumber {
        case 0...9:
            hour = "0\(hourNumber)"
        default: hour = "\(hourNumber)"
        }
        
        switch minutesNumber {
        case 0...9:
            minutes = "0\(minutesNumber)"
        default: minutes = "\(minutesNumber)"
        }
        
        let randomDateTime = "\(monthName), \(day) at \(hour):\(minutes)"
        return randomDateTime
    }
    
}
