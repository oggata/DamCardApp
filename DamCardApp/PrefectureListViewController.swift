//
//  PrefectureListViewController.swift
//  DamCardApp
//
//  Created by Fumitoshi Ogata on 2014/10/27.
//  Copyright (c) 2014年 Fumitoshi Ogata. All rights reserved.
//

import UIKit


class PrefectureListViewController: UIViewController {
    
    @IBOutlet var prefectureList: UITableView!

    var postPrefectureName:String?
        
    var PrifecturesArray:Array<Dictionary<String,String>> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJSONFile()
    }
        
    func loadJSONFile() -> NSArray {
        var filePath:String? = NSBundle.mainBundle().pathForResource("prefecture",ofType:"json") as String?
        var err: NSError
        var fileHandle : NSFileHandle = NSFileHandle(forReadingAtPath: filePath!)
        var acceptData : NSData = fileHandle.readDataToEndOfFile()
        let str = NSString(data:acceptData, encoding:NSUTF8StringEncoding)
        var hogeJson = JSON.parse(str)
        for (i, v) in hogeJson {
            var _data = [
                "id":v["id"].asString!,
                "name":v["name"].asString!,
                "en":v["name"].asString!
            ]
            PrifecturesArray.append(_data)
        }
        //ID順でソートする
        sort(&PrifecturesArray) {
            (a:Dictionary, b:Dictionary) -> Bool in
            return a["id"] < b["id"]
        }
        return PrifecturesArray
    }
            
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int  {
        return PrifecturesArray.count as Int
    }
    
    func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath:NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = PrifecturesArray[indexPath.row]["name"] as String!
        //cell.detailTextLabel?.text = self.timelineData[indexPath.row][0]["comment"];
        return cell
    }
    
    func tableView(tableView: UITableView?, didSelectRowAtIndexPath indexPath:NSIndexPath!) {        
        postPrefectureName = PrifecturesArray[indexPath.row]["name"]
        performSegueWithIdentifier("traditionToDamsListView",sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "traditionToDamsListView") {
            var destViewController: DamsListViewController = segue.destinationViewController as DamsListViewController
            destViewController.prefectureName = postPrefectureName as String!
        }
    }
}


