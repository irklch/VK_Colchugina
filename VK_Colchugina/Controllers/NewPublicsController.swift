//
//  NewPublicsController.swift
//  L2_Colchugina_Irina
//
//  Created by Ирина Кольчугина on 11/8/20.
//

import UIKit


class NewPublicsController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newPublics.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewPublicCell", for: indexPath) as! NewPublicCell
        cell.nemeLable.text = newPublics[indexPath.row].name
        cell.iconImageView.image = newPublics[indexPath.row].icon
        return cell
    }

    

}
