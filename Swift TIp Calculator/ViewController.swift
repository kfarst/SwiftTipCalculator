//
//  ViewController.swift
//  Swift TIp Calculator
//
//  Created by Kevin Farst on 8/23/14.
//  Copyright (c) 2014 Kevin Farst. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    struct Defaults {
        var userDefaults: NSUserDefaults
        var firstTip: Double
        var secondTip: Double
        var thirdTip: Double
        var lastBillInput: Double
        //var timeAtAppClose: AnyObject
        
        init () {
            userDefaults = NSUserDefaults.standardUserDefaults()
            firstTip = userDefaults.doubleForKey("First Tip Percentage")
            secondTip = userDefaults.doubleForKey("Second Tip Percentage")
            thirdTip = userDefaults.doubleForKey("Third Tip Percentage")
            lastBillInput = userDefaults.doubleForKey("Last Bill Input")
            //timeAtAppClose = userDefaults.objectForKey("Time At App Close")
        }
    }
    
    struct TextFields {
        let billFieldText: Double
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        billField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func didMoveToParentViewController(parent: UIViewController!) {
        var defaults = Defaults()

        if !defaults.firstTip.isZero {
            tipControl.setTitle(String(format: "%d%%", Int(defaults.firstTip * 100)), forSegmentAtIndex: 0)
            tipControl.setTitle(String(format: "%d%%", Int(defaults.secondTip * 100)), forSegmentAtIndex: 1)
            tipControl.setTitle(String(format: "%d%%", Int(defaults.thirdTip * 100)), forSegmentAtIndex: 2)
        }
        calculateBill()
    }

    func calculateBill() {
        var defaults = Defaults()
        
        var tipPercentages = defaults.firstTip.isZero ? [0.2, 0.22, 0.25] : [defaults.firstTip, defaults.secondTip, defaults.thirdTip]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = (billField.text as NSString).doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip

        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        calculateBill()
    }

    @IBAction func onTap(sender: AnyObject) {
        TextFields(billFieldText: (billField.text as NSString).doubleValue)
        view.endEditing(true)
    }
}

