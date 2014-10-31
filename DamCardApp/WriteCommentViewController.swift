//
//  WriteCommentViewController.swift
//  DamCardApp
//
//  Created by Fumitoshi Ogata on 2014/10/30.
//  Copyright (c) 2014年 Fumitoshi Ogata. All rights reserved.
//

import UIKit

class WriteCommentViewController: UIViewController {
        
    @IBOutlet var cancelButton: UIButton!
    @IBAction func cancelButtonDidTouch(sender: AnyObject) {
         self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBOutlet var sendButton: UIButton!
    @IBAction func sendButtonDidTouch(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    
        saveData()
    }
    
    @IBOutlet var inputComment: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
                
        inputComment.frame = CGRectMake(0, 0, 300, 300)
        inputComment.allowsEditingTextAttributes = true
        inputComment.layer.borderWidth = 1
        inputComment.layer.borderColor = UIColor.blackColor().CGColor
        inputComment.layer.cornerRadius = 8
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func saveData(){
        Parse.setApplicationId("dBzkl9gkGPsQoyRHq5WOv9wzbUmK9QEhJXBpO6mf",clientKey: "HtkhZciPZ3p5M8elvwJBrI1ORvhBgU95bOSjCRJ2")
println(self.inputComment!.text)
        var dameComments:PFObject=PFObject(className: "DamComments")
        dameComments.setObject(1, forKey: "DamId")
        dameComments.setObject("aaaaaaaaaaaa", forKey: "Comment")
        dameComments.setObject("ogahamu", forKey: "userName")
        dameComments.saveInBackgroundWithBlock {
            (success: Bool!,error: NSError!) -> Void in
            if success==true {
                //print("parse edildi score id = \(score.objectId) ")
                println("success")
            }else{
                print(error)
            }
        }
    }

}






