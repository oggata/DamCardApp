//
//  WriteCommentViewController.swift
//  DamCardApp
//
//  Created by Fumitoshi Ogata on 2014/10/30.
//  Copyright (c) 2014年 Fumitoshi Ogata. All rights reserved.
//

import UIKit

protocol DamCommentViewControllerDelegate{
    func reloadCommentListTable(writeCommentViewController:WriteCommentViewController)
}

class WriteCommentViewController: UIViewController {
    
    var damId:Int? = 1
    var delegate:DamCommentViewControllerDelegate? = nil
        
    @IBOutlet var cancelButton: UIButton!
    @IBAction func cancelButtonDidTouch(sender: AnyObject) {
         self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBOutlet var sendButton: UIButton!
    @IBAction func sendButtonDidTouch(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        saveData()
        
        self.delegate?.reloadCommentListTable(self)
    }
    
    @IBOutlet var inputComment: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        inputComment.frame = CGRectMake(0, 0, 300, 300)
        inputComment.allowsEditingTextAttributes = true
        inputComment.layer.borderWidth = 1
        inputComment.layer.borderColor = UIColor.blackColor().CGColor
        inputComment.layer.cornerRadius = 8
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func saveData(){
        var dameComments:PFObject=PFObject(className: "DamComments")
        dameComments.setObject(self.damId, forKey: "DamId")
        dameComments.setObject(self.inputComment!.text, forKey: "Comment")
        dameComments.setObject("ogahamu", forKey: "userName")
        dameComments.saveInBackgroundWithBlock {
            (success: Bool!,error: NSError!) -> Void in
            if success==true {
                //print("parse edildi score id = \(score.objectId) ")
                println("success")
                self.delegate?.reloadCommentListTable(self)
            }else{
                print(error)
            }
        }
    }
}
