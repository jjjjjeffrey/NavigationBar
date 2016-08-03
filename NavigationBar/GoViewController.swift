//
//  GoViewController.swift
//  NavigationBar
//
//  Created by zengdaqian on 16/8/2.
//  Copyright © 2016年 zengdaqian. All rights reserved.
//

import UIKit

class GoViewController: UIViewController, NavigationStackController {
    
    var navigationBarColor: UIColor {
        get {
            return UIColor(colorLiteralRed: 0/255, green: 118/255, blue: 173/255, alpha: 1)
        }
    }
    
    var navigationBarTitleColor: UIColor {
        get {
            return UIColor(colorLiteralRed: 49/255, green: 19/255, blue: 124/255, alpha: 1)
        }
    }
    
    var tintColor: UIColor {
        get {
            return navigationBarTitleColor
        }
    }
    
    var navigationBarHidden: Bool {
        get {
            return false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
