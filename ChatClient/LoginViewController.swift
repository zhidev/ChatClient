//
//  LoginViewController.swift
//  ChatClient
//
//  Created by Douglas on 2/11/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit
import Parse
class LoginViewController: UIViewController {

    @IBOutlet var LoginButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var emailText: UITextField!
    @IBOutlet var passwordText: UITextField!
    
    
    var user: PFUser?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signUp(sender: AnyObject) {
        user = PFUser()
        user!.username = emailText.text
        user!.password = passwordText.text
        user!.email = emailText.text
        
        //user["phone"] = 415-392-0202
        //aznd13@hotmail.com

        user!.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                print(error)
            }else{
                // No error use app
            }
        }
        
    }
    
    @IBAction func login(sender: AnyObject) {
            print(user)
        PFUser.logInWithUsernameInBackground(user!.username!, password:user!.password!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                self.performSegueWithIdentifier("login", sender: self)
                
                
            } else {
                // The login failed. Check error to see why.
            }
        }
        
}
    /*override func performSegueWithIdentifier(identifier: String, sender: AnyObject?) {
    
        presentViewController(chatVC, animated: true, completion: nil)

    }*/

}
