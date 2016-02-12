//
//  ChatViewController.swift
//  ChatClient
//
//  Created by Douglas on 2/11/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit
import Parse



class ChatViewController: UIViewController {

    @IBOutlet var messageText: UITextView!
    
    @IBOutlet var composeButton: UIButton!
    
    var message: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

}
