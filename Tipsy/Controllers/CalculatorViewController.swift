//
//  CalculatorViewController.swift
//  Tipsy
//
//  Created by Deepanshu Bajaj on 20/12/24.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    var tipsCalculatorBrain = TipsCalculatorBrain()
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tipPercentage = 0.10
    var numberOfPeople = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showWelcomeAlert()
        
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        billTextField.endEditing(true)
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        
        let buttonTitle = sender.currentTitle!
        let buttonTitleMinusPercentSign = String(buttonTitle.dropLast())
        let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
        tipPercentage = buttonTitleAsANumber / 100
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        if let bill = billTextField.text, let billTotal = Double(bill) {
            tipsCalculatorBrain.calculateTips(bill: billTotal, tip: tipPercentage, split: numberOfPeople)
            self.performSegue(withIdentifier: "goToResult", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.result = tipsCalculatorBrain.getFinalResult()
            destinationVC.tip = tipsCalculatorBrain.getTipPercentage()
            destinationVC.split = tipsCalculatorBrain.getNumberOfPeople()
        }
    }
    
    func showWelcomeAlert() {
        let welcomeAlert = UIAlertController(title: "Welcome to Tipsy", message: "You can now split your any Bill conveniently!", preferredStyle: .alert)
        
        let enterAction = UIAlertAction(title: "Enter", style: .default) { _ in
            // Welcome Alert Dismiss
        }
        
        welcomeAlert.addAction(enterAction)
        present(welcomeAlert, animated: true, completion: nil)
    }
}

