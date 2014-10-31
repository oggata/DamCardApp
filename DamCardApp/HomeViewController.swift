//
//  ViewController.swift
//  DamCardApp
//
//  Created by Fumitoshi Ogata on 2014/10/27.
//  Copyright (c) 2014年 Fumitoshi Ogata. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var logoutButton: UIButton!
    @IBAction func logoutButtonPushed(sender : AnyObject) {
        PFUser .logOut()
    }    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        /*
        Parse.setApplicationId("dBzkl9gkGPsQoyRHq5WOv9wzbUmK9QEhJXBpO6mf", clientKey: "HtkhZciPZ3p5M8elvwJBrI1ORvhBgU95bOSjCRJ2")
        if (PFUser.currentUser() == nil) {
            var loginAlert:UIAlertController = UIAlertController(title: "Sign UP / Loign", message: "Plase sign up or login", preferredStyle: UIAlertControllerStyle.Alert)
            
            // ユーザーネームとパスワードの入力
            loginAlert.addTextFieldWithConfigurationHandler({
                textfield in
                textfield.placeholder = "Your username"
            })
            
            loginAlert.addTextFieldWithConfigurationHandler({
                textfield in
                textfield.placeholder = "Your Password"
                textfield.secureTextEntry = true
            })
            
            loginAlert.addAction(UIAlertAction(title: "Login", style: UIAlertActionStyle.Default, handler: {
                alertAction in
                
                let textFields:Array<UITextField>? =  loginAlert.textFields as Array<UITextField>?
                var tweeter:PFUser = PFUser()
                for textField:UITextField in textFields! {
                    //各textにアクセス                                    
                    if(textField.placeholder == "Your username"){
                        tweeter.username = textField.text
                    }
                    if(textField.placeholder == "Your Password"){
                        tweeter.password = textField.text
                    }
                }
                tweeter.email = "email@example.com";
                tweeter["phone"] = "650-555-0000";
                
                var checkExist = PFUser.query()
                checkExist.whereKey("username", equalTo: tweeter.username) // usernameをキーにしてDBを検索
                checkExist.findObjectsInBackgroundWithBlock {
                    (objects: [AnyObject]!, error: NSError!) -> Void in
                    if(objects.count > 0){
                        println("its username is already taken \(objects.count)")
                        self.signIn(tweeter.username, password:tweeter.password) // Login for already registerd user
                    } else {                                                    
                        println("its username hasn't token yet. Let's register!")
                        self.signUp(tweeter) // Sign up for new user
                    }                       
                }
            }))
            
            self.presentViewController(loginAlert, animated: true, completion: nil)
            
        }
        */
    }
    
    func signIn(username:NSString, password:NSString) {
        PFUser.logInWithUsernameInBackground(username, password: password) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                println("existed user")
            } else {
                println("not existed user")
            }
        }
    }
    
    func signUp(tweeter:PFUser) {
        tweeter.signUpInBackgroundWithBlock{
            (success:Bool!, error:NSError!)->Void in
            if error == nil{
                println("Sign up succeeded.")
            }else{
                //let errorString = error.userInfo["error"] as NSString
                //println(errorString)
            }
        }
    }
}

