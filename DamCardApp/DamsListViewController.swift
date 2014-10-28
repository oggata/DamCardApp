//
//  DamsListViewController.swift
//  DamCardApp
//
//  Created by Fumitoshi Ogata on 2014/10/27.
//  Copyright (c) 2014年 Fumitoshi Ogata. All rights reserved.
//

import UIKit

class DamsListViewController: UIViewController {
    
    @IBOutlet var damsList: UITableView!
    var damsData:NSArray = NSArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Parseからデータの取得
    func loadData(){
        Parse.setApplicationId("dBzkl9gkGPsQoyRHq5WOv9wzbUmK9QEhJXBpO6mf",clientKey: "HtkhZciPZ3p5M8elvwJBrI1ORvhBgU95bOSjCRJ2")
        
        var query:PFQuery = PFQuery(className: "Dams")
        //query.whereKey("user", equalTo: PFUser.currentUser())
        query.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]!, error:NSError!)->Void in
            if error != nil{
                //println("error occured")
                //println(error)
            }else{
                //println("got data")
                let array:NSArray = objects
                self.damsData = objects
                self.damsList.reloadData()
            }
        }
    }

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int  {
        return damsData.count as Int
    }
    
    func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath:NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = "xxxx"
        cell.textLabel?.text = self.damsData[indexPath.row]["name"] as String
        return cell
    }
    
    func tableView(tableView: UITableView?, didSelectRowAtIndexPath indexPath:NSIndexPath!) {
    }
    
}
