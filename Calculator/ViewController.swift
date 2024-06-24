//
//  ViewController.swift
//  Calculator
//
//  Created by Mahyar on 5/6/24.
//

import UIKit

enum Operators {
    case remaining
    case plus
    case minus
    case multiply
    case divide
}

class ViewController: UIViewController {
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var acButton: UIButton!
    @IBOutlet weak var plusMinusButton: UIButton!
    @IBOutlet weak var remainingButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!
    @IBOutlet weak var dotButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var zeroButton: UIButton!
    
    var amount: Double = 0 {
        didSet {
            amountLabel.text = formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
        }
    }
    
    let formatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.groupingSeparator = ","
        nf.groupingSize = 3
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 6
        return nf
    }()
    
    var currentInput: String = ""
    var amountArray = [Double]()
    var calculateOperator: Operators?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttons = [acButton, plusMinusButton, remainingButton, divideButton, multiplyButton, minusButton, plusButton, equalButton, dotButton, nineButton, eightButton, sevenButton, sixButton, fiveButton, fourButton, threeButton, twoButton, oneButton, zeroButton]
        
        for button in buttons {
            if let button = button {
                makeButtonCircular(button)
            }
        }
        
        amountLabel.adjustsFontSizeToFitWidth = true
        amountLabel.minimumScaleFactor = 0.5
    }
    
    func makeButtonCircular(_ button: UIButton) {
        button.layer.cornerRadius = button.bounds.height / 2
    }
    
    @IBAction func acButtonTouchUpInside(_ sender: UIButton) {
        calculateOperator = nil
        amountArray.removeAll()
        amount = 0
        currentInput = ""
    }
    
    @IBAction func plusMinusButtonTouchUpInside(_ sender: UIButton) {
        amount = (amount == 0) ? 0 : -amount
        updateDisplay()
    }
    
    @IBAction func plusButtonTouchUpInside(_ sender: UIButton) {
        amountArray.append(amount)
        calculateOperator = .plus
        amount = 0
        currentInput = ""
    }
    
    @IBAction func minusButtonTouchUpInside(_ sender: UIButton) {
        amountArray.append(amount)
        calculateOperator = .minus
        amount = 0
        currentInput = ""
    }
    
    @IBAction func multiplyButtonTouchUpInside(_ sender: UIButton) {
        amountArray.append(amount)
        calculateOperator = .multiply
        amount = 0
        currentInput = ""
    }
    
    @IBAction func divideButtonTouchUpInside(_ sender: UIButton) {
        amountArray.append(amount)
        calculateOperator = .divide
        amount = 0
        currentInput = ""
    }
    
    @IBAction func remainingButtonTouchUpInside(_ sender: UIButton) {
        amountArray.append(amount)
        calculateOperator = .remaining
        amount = 0
        currentInput = ""
    }
    
    @IBAction func equalButtonTouchUpInside(_ sender: UIButton) {
        amountArray.append(amount)
        guard let calculateOperator else {return}
        
        var result: Double = amountArray[0]
        
        for index in 1..<amountArray.count {
            switch calculateOperator {
            case .plus:
                result += amountArray[index]
            case .minus:
                result -= amountArray[index]
            case .multiply:
                result *= amountArray[index]
            case .divide:
                result /= amountArray[index]
            case .remaining:
                result = result.truncatingRemainder(dividingBy: amountArray[index])
            }
        }
        
        amount = result
        amountArray.removeAll()
        currentInput = ""
        updateDisplay()
    }
    
    func updateAmount() {
        amount = Double(currentInput) ?? 0
        updateDisplay()
    }
    
    func updateDisplay() {
        if let formattedAmount = formatter.string(from: NSNumber(value: amount)) {
            amountLabel.text = formattedAmount
        } else {
            amountLabel.text = "\(amount)"
        }
    }
    
    @IBAction func numberButtonTouchUpInside(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        currentInput += title
        updateAmount()
    }
}
