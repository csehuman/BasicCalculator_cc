//
//  ViewController.swift
//  BasicCalculatorApp
//
//  Created by Paul Lee on 2022/09/17.
//

import UIKit

enum Operation {
    case divide
    case multiply
    case subtract
    case add
    case unspecified
}

class ViewController: UIViewController {

    @IBOutlet weak var numberLabel: UILabel!
    
    var displayNumber = ""
    var firstOperand = ""
    var secondOperand = ""
    var result = ""
    var currentOperation: Operation = .unspecified
    var currentButton: UIButton?
    
    let operatorColor = UIColor(red: 254/255, green: 160/255, blue: 10/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapClearButton(_ sender: UIButton) {
        displayNumber = ""
        firstOperand = ""
        secondOperand = ""
        result = ""
        currentOperation = .unspecified
        numberLabel.text = "0"
    }
    
    @IBAction func tapNumberButton(_ sender: UIButton) {
        if displayNumber.count < 9 {
            guard let number = sender.title(for: .normal) else { return }
            displayNumber += number
            numberLabel.text = displayNumber
            if let currentButton = currentButton {
                setButtonStyle(for: currentButton, textColor: .white, backgroundColor: operatorColor)
            }
        }
    }
    
    @IBAction func tapDotButton(_ sender: UIButton) {
        if displayNumber.count < 8, !displayNumber.contains(".") {
            displayNumber += displayNumber.isEmpty ? "0." : "."
            numberLabel.text = displayNumber
        }
    }
    
    @IBAction func tapDivideButton(_ sender: UIButton) {
        handleOperation(for: .divide)
        currentButton = sender
        setButtonStyle(for: sender, textColor: operatorColor, backgroundColor: .white)
    }
    
    @IBAction func tapMultiplyButton(_ sender: UIButton) {
        handleOperation(for: .multiply)
        currentButton = sender
        setButtonStyle(for: sender, textColor: operatorColor, backgroundColor: .white)
    }
    
    @IBAction func tapSubtractButton(_ sender: UIButton) {
        handleOperation(for: .subtract)
        currentButton = sender
        setButtonStyle(for: sender, textColor: operatorColor, backgroundColor: .white)
    }
    
    @IBAction func tapAddButton(_ sender: UIButton) {
        handleOperation(for: .add)
        currentButton = sender
        setButtonStyle(for: sender, textColor: operatorColor, backgroundColor: .white)
    }
    
    @IBAction func tapEqualButton(_ sender: UIButton) {
        handleOperation(for: currentOperation)
    }
    
    func handleOperation(for operation: Operation) {
        if currentOperation != .unspecified {
            if !displayNumber.isEmpty {
                guard let firstOp = Double(firstOperand) else { return }
                guard let secondOp = Double(displayNumber) else { return }
                
                switch currentOperation {
                case .divide:
                    result = "\(firstOp / secondOp)"
                case .multiply:
                    result = "\(firstOp * secondOp)"
                case .subtract:
                    result = "\(firstOp - secondOp)"
                case .add:
                    result = "\(firstOp + secondOp)"
                default:
                    break
                }
                
                if let doubleResult = Double(result), doubleResult.truncatingRemainder(dividingBy: 1) == 0 {
                    result = "\(Int(doubleResult))"
                }
            
                displayNumber = ""
                firstOperand = result
                numberLabel.text = result
            }
            currentOperation = operation
        } else {
            currentOperation = operation
            firstOperand = displayNumber
            displayNumber = ""
        }
    }
    
    func setButtonStyle(for button: UIButton, textColor: UIColor, backgroundColor: UIColor) {
        button.setTitleColor(textColor, for: .normal)
        button.backgroundColor = backgroundColor
    }
}

