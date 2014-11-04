//
//  DamsListViewController.swift
//  DamCardApp
//
//  Created by Fumitoshi Ogata on 2014/10/27.
//  Copyright (c) 2014年 Fumitoshi Ogata. All rights reserved.
//

import UIKit

class DamsListViewController: UIViewController {
    
    var prefectureId = "";
    var prefectureName = "";
    
    var postDamId:Int?
    var postDamName:String?
    var postDistributionPlaceName : String?
    var postDistributionDate : String?
    var postPrefectureName : String?
    var postAddress : String?
    var postUrl : String?
    
    @IBOutlet var damsList: UITableView!
    var damsData:NSArray = NSArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Parseからデータの取得
    func loadData(){        
        var query:PFQuery = PFQuery(className: "Dams")
        query.whereKey("prefectureName", equalTo: prefectureName)
        query.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]!, error:NSError!)->Void in
            if error != nil{
                //println("error occured")
                //println(error)
            }else{
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
        cell.textLabel?.text = self.damsData[indexPath.row]["name"] as String?
        return cell
    }
    
    func tableView(tableView: UITableView?, didSelectRowAtIndexPath indexPath:NSIndexPath!) {
        postDamId = self.damsData[indexPath.row]["xlsManageId"] as Int?
        postDamName = self.damsData[indexPath.row]["name"] as String?
        postDistributionPlaceName = self.damsData[indexPath.row]["distributionPlaceName"] as String?
        postDistributionDate = self.damsData[indexPath.row]["distributionDate"] as String?
        postPrefectureName = self.damsData[indexPath.row]["prefectureName"] as String?
        postAddress = self.damsData[indexPath.row]["address"] as String?
        postUrl = self.damsData[indexPath.row]["url"] as String?        
        performSegueWithIdentifier("traditionToDamDetailView",sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        //println("traditionToDamDetailView")
        if (segue.identifier == "traditionToDamDetailView") {
            var destViewController: DamDetailViewController = segue.destinationViewController as DamDetailViewController
            
            destViewController.damId = postDamId as Int!
            destViewController.damName = postDamName as String!
            destViewController.distributionPlaceName = postDistributionPlaceName as String!
            destViewController.distributionDate = postDistributionDate as String!
            destViewController.prefectureName = postPrefectureName as String!
            destViewController.address = postAddress as String!
            destViewController.url = postUrl as String!
        }
    }
    
}
