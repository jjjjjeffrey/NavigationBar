//
//  TableViewController.swift
//  NavigationBar
//
//  Created by zengdaqian on 16/8/2.
//  Copyright © 2016年 zengdaqian. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, NavigationStackController {

    var navigationBarColor: UIColor {
        get {
            return UIColor(colorLiteralRed: 0/255, green: 188/255, blue: 225/255, alpha: 1)
        }
    }
    
    var navigationBarTitleColor: UIColor {
        get {
            return UIColor.blackColor()
        }
    }
    
    var tintColor: UIColor {
        get {
            return UIColor.blackColor()
        }
    }
    
    var navigationBarHidden: Bool {
        get {
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        return cell
    }

//    override func scrollViewDidScroll(scrollView: UIScrollView) {
//        print(scrollView.contentOffset)
//        let width = self.view.frame.width
//        
//        let image = createTransparentImage(CGSize(width: width, height: 64))
//        self.navigationController?.navigationBar.setBackgroundImage(image, forBarMetrics: .Default)
//    }

    
}
