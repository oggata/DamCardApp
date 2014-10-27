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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int  {
        return 10
        //return self.timelineData2.count as Int
    }
    
    func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath:NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        //cell.textLabel?.text = self.timelineData2[indexPath.row]["name"] as String
        //cell.detailTextLabel?.text = self.timelineData[indexPath.row][0]["comment"];
        return cell
    }
    
    
    func tableView(tableView: UITableView?, didSelectRowAtIndexPath indexPath:NSIndexPath!) {
        //requestURL = "http://qiita.com/"
        //requestURL = ArticleArray[indexPath.row][0]["url"]
        //performSegueWithIdentifier("TRADITION_ArticleDetailVIew",sender: nil)
    }
}


