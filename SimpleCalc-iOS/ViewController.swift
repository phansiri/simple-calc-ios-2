//
//  ViewController.swift
//  SimpleCalc-iOS
//
//  Created by Litthideth Phansiri on 10/20/16.
//  Copyright © 2016 Lit Phansiri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // output label for result
    @IBOutlet weak var outputLabel: UILabel!
    
    // internal variables
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Mod = "%"
        case Empty = ""
        case Clear = "Clear"
        case Count = "Count"
        case Average = "Avg"
        case Fact = "Fact"
    }
    
    var valOne = ""
    var valTwo = ""
    var tempStoredNumber = ""
    var result = ""
    var currentOperation = Operation.Empty
    var countFunction: Int = 1
    var averageFunction: Int = 1
    var numberArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outputLabel.text = "0"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func numberButton(sender: UIButton) {
        tempStoredNumber += "\(sender.tag)"
        outputLabel.text = tempStoredNumber
    }
    
    @IBAction func modButton(sender: AnyObject) {
        performOperation(operation: Operation.Mod)
    }
    
    @IBAction func divideButton(sender: AnyObject) {
        performOperation(operation: Operation.Divide)
    }
    
    @IBAction func multipyButton(sender: AnyObject) {
        performOperation(operation: Operation.Multiply)
    }
    
    @IBAction func subtractButton(sender: AnyObject) {
        performOperation(operation: Operation.Subtract)
    }
    
    @IBAction func addButton(sender: AnyObject) {
        performOperation(operation: Operation.Add)
    }

    
    @IBAction func equalsButton(sender: AnyObject) {
        performOperation(operation: currentOperation)
    }
    
    @IBAction func countButton(sender: AnyObject) {
        performOperation(operation: Operation.Count)
    }
    
    @IBAction func factButton(sender: AnyObject) {
        let factorialNumber = Int(tempStoredNumber)!
        if factorialNumber == 0 {
            result = "1"
            
        } else {
            for index in 1...factorialNumber {
                averageFunction *= index
            }
            result = "\(averageFunction)"
        }
        outputLabel.text = result

    }
    
    @IBAction func averageButton(sender: AnyObject) {
        numberArray.append(tempStoredNumber)
        valOne = tempStoredNumber
        valTwo = tempStoredNumber
        tempStoredNumber = ""
        currentOperation = Operation.Average

    }
    
    @IBAction func clearButton(sender: AnyObject) {
        valOne = ""
        valTwo = ""
        tempStoredNumber = ""
        result = ""
        currentOperation = Operation.Empty
        outputLabel.text = "0"
        countFunction = 1
        averageFunction = 1
        numberArray = [String]()
        
    }

    func performOperation(operation: Operation) {
        if currentOperation != Operation.Empty { // test if current operation is not empty, that means there is a value in valOne
            if tempStoredNumber != "" { // test if tempStoreNumber is not empty, that means there is a value in tempStoreNmber so add it to valTwo
                valTwo = tempStoredNumber // adding to valTwo
                tempStoredNumber = "" // clearing out tempStoredNumber
                
                // only happen if valOne and valTwo have values in them.
                if currentOperation == .Multiply { // test if operation passed is Multiply
                    result = "\(Double(valOne)! * Double(valTwo)!)"
                } else if currentOperation == .Divide {
                    result = "\(Double(valOne)! / Double(valTwo)!)"
                } else if currentOperation == .Subtract {
                    result = "\(Double(valOne)! - Double(valTwo)!)"
                } else if currentOperation == .Add {
                    result = "\(Double(valOne)! + Double(valTwo)!)"
                } else if currentOperation == .Mod {
                    result = "\(Int(valOne)! % Int(valTwo)!)"
                } else if currentOperation == .Count {
                    countFunction += 1
                    result = String(countFunction)
                } else if currentOperation == .Average {
                    numberArray.append(valTwo)
//                    print(numberArray)
                    var sum = 0
                    for index in numberArray {
                        sum += Int(index)!
                    }
                    result = "\(sum / numberArray.count)"
                }
                // results is added to valOne for current running number
                valOne = result
                outputLabel.text = result
                
            }
        } else { // there is no number in valOne
            valOne = tempStoredNumber
            tempStoredNumber = ""
            currentOperation = operation
        }
    }


}

