//
//  DamDetailViewController.swift
//  DamCardApp
//
//  Created by Fumitoshi Ogata on 2014/10/27.
//  Copyright (c) 2014年 Fumitoshi Ogata. All rights reserved.
//

import UIKit

class DamDetailViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var urlLabel: UILabel!
    @IBOutlet var distPlaceLable: UILabel!
    @IBOutlet var distDateLabel: UILabel!
    
    var damId : String?
    var damName : String?
    var distributionPlaceName : String?
    var distributionDate : String?
    var prefectureName : String?
    var address : String?
    var url : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.nameLabel?.text = damName
        self.distPlaceLable?.text = distributionPlaceName
        self.distDateLabel?.text = distributionDate
        self.addressLabel?.text = address
        self.urlLabel?.text = url
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
