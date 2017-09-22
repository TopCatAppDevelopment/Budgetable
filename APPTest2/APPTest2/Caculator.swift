//
//  Caculator.swift
//  Budgetable
//
//  Created by Tengzhe Li on 22/09/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class Caculator:  UIViewController{
    
    @IBOutlet weak var IncomeExpense: UISegmentedControl!
    @IBOutlet weak var CountShow: UIButton!
    
    @IBOutlet weak var TimePick: UITextField!
    
    
    
    let datePicker = UIDatePicker()
    
    
    var numShowOnScreen:Double = 0.0
    var previousNum: Double = 0.0
    var performingMath = false
    
    var operation: Int = 0
    
    var x: String = ""
    var count: Int = 0
    var firstNum: Double = 0.0
    var secondNum: Double = 0.0
    
    
    
    //Still Need to Add Decimal ponint and Delete Function
    @IBAction func Number(_ sender: Any) {
        if performingMath == true {
            
            let  j =  String((sender as AnyObject).tag)
            CountShow.setTitle(j, for: .normal)
            
            print(j)
            numShowOnScreen = Double(j)!
            performingMath = false
            
        }else{
            
            if CountShow.currentTitle == nil {
                
                x = String((sender as AnyObject).tag)
                
                CountShow.setTitle(x, for: .normal)
            }
            else{
                //If input is "."
                if (sender as AnyObject).tag == 10 {
                    x = CountShow.currentTitle! + "."
                    print("....")
                }else{
                    //Find last char of Screen
                    let z = x.characters.count-1
                    let y = x.index(x.startIndex, offsetBy: z)
                    print(x[y])
                    
                    
                    
                    x =  CountShow.currentTitle! + String((sender as AnyObject).tag)
                    CountShow.setTitle(x, for: .normal)
                }
                print(x)
                numShowOnScreen = Double(x)!
            }
        }
    }
    
    @IBAction func Count(_ sender: Any) {
        
        let numTest = Double(CountShow.currentTitle!)
        
        if CountShow.currentTitle != nil && numTest != nil && (sender as AnyObject).tag != 15 && (sender as AnyObject).tag != 17
        {
            previousNum = Double(CountShow.currentTitle!)!
            if (sender as AnyObject).tag == 11{
                CountShow.setTitle("+", for: .normal)
            }
            else if (sender as AnyObject).tag == 12
            {
                CountShow.setTitle("-", for: .normal)
            }else if (sender as AnyObject).tag == 13
            {
                CountShow.setTitle("x", for: .normal)
            }else if (sender as AnyObject).tag == 14
            {
                CountShow.setTitle("/", for: .normal)
            }
            
            operation = (sender as AnyObject).tag
            performingMath = true
            print(operation)
            
        }else if (sender as AnyObject).tag == 15{
            
            if operation == 11
            {
                print("+++++")
                let a =  String(previousNum + numShowOnScreen)
                print(a)
                CountShow.setTitle(a, for: .normal)
            }else if operation == 12
            {
                print("----")
                let a =  String(previousNum-numShowOnScreen)
                print(a)
                CountShow.setTitle(a, for: .normal)
            }else if operation == 13
            {
                print("xxxxx")
                let a =  String(previousNum*numShowOnScreen)
                print(a)
                CountShow.setTitle(a, for: .normal)
            }else if operation == 14
            {
                print("///////")
                let a =  String(previousNum/numShowOnScreen)
                print(a)
                CountShow.setTitle(a, for: .normal)
            }
        } else if (sender as AnyObject).tag == 17{
            
            print("Clear All")
            CountShow.setTitle("", for: .normal)
            previousNum = 0;
            numShowOnScreen = 0;
            operation = 0;
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UpdateTime()
        createTimePicker()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Done buttom for TimePicker
    func donePressed(sender:UIBarButtonItem){
        //format
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .short
        dateFormat.timeStyle = .short
        
        
        TimePick.text = dateFormat.string(from: datePicker.date)
        self.view.endEditing(true)
        
        
    }
    
    func createTimePicker(){
        //format for picker
        datePicker.datePickerMode = .dateAndTime
        // TimePick.text = ""
        //toolbar
        let toolbar = UIToolbar()
        
        toolbar.sizeToFit()
        
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem:.done, target: nil, action: #selector(donePressed))
        
        
        toolbar.setItems([doneButton], animated: false)
        
        TimePick.inputAccessoryView = toolbar
        
        // assigning time pick to text field
        TimePick.inputView = datePicker
        
    }
    
    
    @IBAction func AddType(_ sender: Any) {
        performSegue(withIdentifier: "segue1", sender: self)
    }
    
    
    
    
    
    
    
}
