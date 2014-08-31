//
//  SettingsViewController.swift
//  Swift TIp Calculator
//
//  Created by Kevin Farst on 8/23/14.
//  Copyright (c) 2014 Kevin Farst. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var firstTipPercentageField: UITextField!
    @IBOutlet weak var secondTipPercentageField: UITextField!
    @IBOutlet weak var thirdTipPercentageField: UITextField!
    
    struct Defaults {
        var userDefaults: NSUserDefaults
        var firstTip: Double
        var secondTip: Double
        var thirdTip: Double
        
        init () {
            userDefaults = NSUserDefaults.standardUserDefaults()
            firstTip = userDefaults.doubleForKey("First Tip Percentage")
            secondTip = userDefaults.doubleForKey("Second Tip Percentage")
            thirdTip = userDefaults.doubleForKey("Third Tip Percentage")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var defaults = Defaults()

        if defaults.firstTip.isZero {
            firstTipPercentageField.text = "20"
            defaults.userDefaults.setDouble(0.2, forKey: "First Tip Percentage")
        } else {
            firstTipPercentageField.text = String(format: "%d", (defaults.firstTip * 100).bridgeToObjectiveC().integerValue)
            defaults.userDefaults.setDouble(defaults.firstTip, forKey: "First Tip Percentage")
        }
        
        if defaults.secondTip.isZero {
            secondTipPercentageField.text = "22"
            defaults.userDefaults.setDouble(0.22, forKey: "Second Tip Percentage")
        } else {
            secondTipPercentageField.text = String(format: "%d", (defaults.secondTip * 100).bridgeToObjectiveC().integerValue)
            defaults.userDefaults.setDouble(defaults.secondTip, forKey: "Second Tip Percentage")
        }
        
        if defaults.thirdTip.isZero {
            thirdTipPercentageField.text = "25"
            defaults.userDefaults.setDouble(0.25, forKey: "Third Tip Percentage")
        } else {
            thirdTipPercentageField.text = String(format: "%d", (defaults.thirdTip * 100).bridgeToObjectiveC().integerValue)
            defaults.userDefaults.setDouble(defaults.thirdTip, forKey: "Third Tip Percentage")
        }
        
        defaults.userDefaults.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onTap(sender: AnyObject) {
        var decimalTip = firstTipPercentageField.text.bridgeToObjectiveC().doubleValue
        var defaults = Defaults()

        if firstTipPercentageField.text.isEmpty || decimalTip.isZero || decimalTip > 99 {
            firstTipPercentageField.text = String(format: "%d", (defaults.firstTip * 100).bridgeToObjectiveC().integerValue)
        } else {
            defaults.userDefaults.setDouble((firstTipPercentageField.text.bridgeToObjectiveC().doubleValue * 0.01), forKey: "First Tip Percentage")
        }
        
        decimalTip = secondTipPercentageField.text.bridgeToObjectiveC().doubleValue
        
        if secondTipPercentageField.text.isEmpty || decimalTip.isZero || decimalTip > 99 {
            secondTipPercentageField.text = String(format: "%d", (defaults.secondTip * 100).bridgeToObjectiveC().integerValue)
        } else {
            defaults.userDefaults.setDouble((secondTipPercentageField.text.bridgeToObjectiveC().doubleValue * 0.01), forKey: "Second Tip Percentage")
        }
        
        decimalTip = thirdTipPercentageField.text.bridgeToObjectiveC().doubleValue
        
        if thirdTipPercentageField.text.isEmpty || decimalTip.isZero || decimalTip > 99 {
            thirdTipPercentageField.text = String(format: "%@", (defaults.thirdTip * 100).bridgeToObjectiveC().integerValue)
        } else {
            defaults.userDefaults.setDouble((thirdTipPercentageField.text.bridgeToObjectiveC().doubleValue * 0.01), forKey: "Third Tip Percentage")
        }
        
        defaults.userDefaults.synchronize()
        view.endEditing(true)
    }
}
