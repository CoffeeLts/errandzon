//
//  AcceptedTableViewController.swift
//  Errandzon
//
//  Created by RTC13 on 2017/6/22.
//  Copyright © 2017年 Revolutionaries. All rights reserved.
//

import UIKit

class AcceptedTableViewController: UITableViewController {
    var Server:ServerManage!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var local_errands = [Errands]()

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return local_errands.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //    let myAcceptErrands = appDelegate.myAcceptErrands
        let cellIdentifier = "Cell"
      
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AcceptedTableViewCell
        // Configure the cell...
        //cell.AcceptedtitleLabel.text = AcceptedJobTitles[indexPath.row]
        
        cell.publisher.text = local_errands[indexPath.row].publisher
        cell.title.text = local_errands[indexPath.row].title
        cell.details.text = local_errands[indexPath.row].details
        cell.rewards.text = local_errands[indexPath.row].rewards
        
        return cell
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Server = appDelegate.Server
        local_errands = Server.acceptedErrands
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let myAcceptErrands = appDelegate.myAcceptErrands
        if segue.identifier == "showAcceptedPostDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! AcceptedDetailTableViewController
                destinationController.errands = local_errands[indexPath.row]
            } }
    }
  
    
}
