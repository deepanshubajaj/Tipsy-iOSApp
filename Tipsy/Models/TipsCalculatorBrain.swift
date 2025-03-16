//
//  TipsCalculatorBrain.swift
//  Tipsy
//
//  Created by Deepanshu Bajaj on 20/12/24.
//

import Foundation

struct TipsCalculatorBrain {
    
    var tips: Tips?
    
    func getFinalResult() -> String {
        return tips?.result ?? "0.0"
    }
    
    func getTipPercentage() -> Int {
        return tips?.tip ?? 10
    }
    
    func getNumberOfPeople() -> Int {
        return tips?.split ?? 2
    }
    
    mutating func calculateTips(bill: Double, tip: Double, split: Int) {
        let totalPerPerson = (bill * (1 + tip)) / Double(split)
        let resultString = String(format: "%.2f", totalPerPerson)
        tips = Tips(result: resultString, tip: Int(tip * 100), split: split)
    }
}

