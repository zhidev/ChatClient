//
//  ChatViewController.swift
//  ChatClient
//
//  Created by Douglas on 2/11/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit
import Parse



class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var messageText: UITextView!
    
    @IBOutlet var composeButton: UIButton!
    
    var message: String?
    @IBOutlet var tableView: UITableView!
    var rows: Int?
    var objDict: [PFObject]?
    
    var createdTime: NSDate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onTimer", userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func composeMessage(sender: AnyObject) {
        message = messageText.text
        
        var messageObj = PFObject(className:"Message")
        messageObj["text"] = message
        messageObj.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                print("saved")
                print(messageObj)
                
            } else {
                // There was a problem, check error.description
            }
        }
  
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell", forIndexPath: indexPath) as! MessageTableViewCell
        let mess = objDict![indexPath.row]
        print("Mess[text]: \(mess) #################")
        if mess["text"] != nil{
            print("********************CREATED: \(mess.createdAt)")
            
            cell.labelText.text = mess["text"] as! String
        }
        //cell.labelText.text = mess["body"] as! String
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("#rowofsections")
        if let rows = rows{
            return rows
        }
        return 0
    }
    
    func onTimer(){
        
        print("ONTIMER CALLED!!!!!!!!!!!!!!")
        var query = PFQuery(className:"Message")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                print("################################")
                self.rows = objects!.count
                // Do something with the found objects
                if let objects = objects {
                    self.objDict = objects
                    self.objDict = self.objDict?.reverse()
                    print("RELOADING TABLEVIEW()")
                   self.tableView.reloadData()
                }
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }

        

    }
    
    
}


