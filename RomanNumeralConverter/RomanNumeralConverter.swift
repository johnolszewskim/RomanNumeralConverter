//
//  RomanNumeralConverter.swift
//  RomanNumerals
//
//  Created by Johnny O on 2/18/24.
//

import Foundation

class RomanNumeralConverter {
    
    static let symbols = [1:"I",
                          5: "V",
                          10: "X",
                          50: "L",
                          100: "C",
                          500: "D",
                          1000: "M"]
    
    //MARK: - Roman Numeral to Arabic
    
    static func convert(_ number: Int) -> String {
        
        print("convert(\(number))")
        
        if number == 0 { return "" }
        
        for num in RomanNumeralConverter.symbols.keys {
            if number == num {
                return symbols[num]!
            }
        }
        
        if number > 1000 {
            return "M" + convert(number - 1000)
        }
        
        if let result = RomanNumeralConverter.getSubtractiveTerm(number) {
            print(result)
            print(number - result.0)
            return result.1 + convert(number - result.0)
        }
        
        if let result = RomanNumeralConverter.getAdditiveTerm(number) {
            return result.1 + convert(number - result.0)
        }
        
        return ""
    }
    
    private static func getSubtractiveTerm(_ number: Int) -> (Int, String)? {
        
        print("getSubtractiveTerm(\(number))")
        
        let validSubtractiveValues = [5: 1, // V
                                     10: 1, // X
                                     50: 10, // L
                                     100: 10, // C
                                     500: 100, // D
                                     1000: 100] // M
        
        let keys = RomanNumeralConverter.symbols.keys.sorted()
        var chosenIndex: Int!
        
        // find symbol greater than number
        for (i, n) in keys.enumerated() {

            if n > number {
                chosenIndex = i
                break
            }
        }
        
        guard let index = chosenIndex else {
            return nil
        }
        
        let subtractiveValue = validSubtractiveValues[keys[index]]!
        
        if (keys[index] - subtractiveValue) <= number {
            let subtractiveString = String(RomanNumeralConverter.symbols[subtractiveValue]!) + String(RomanNumeralConverter.symbols[keys[index]]!)
            let subtractiveInt = keys[index] - subtractiveValue
            let result = (subtractiveInt, subtractiveString)
            print(result)
            return result
        }
        
        return nil
    }
    
    private static func getAdditiveTerm(_ number: Int) -> (Int, String)? {
        
        print("getAdditiveTerm(\(number))")
        
        guard let lesserSymbol = getSymbolValueLessThan(number) else {
            return nil
        }
        
        let times = number / lesserSymbol
        let resultString = String(repeating: symbols[lesserSymbol]!, count: times)
        print(resultString)
        
        return (times * lesserSymbol, resultString)
    }
    
    private static func getSymbolValueLessThan(_ number: Int) -> Int? {
        
        let keys = RomanNumeralConverter.symbols.keys.sorted()
        
        for (i, num) in keys.enumerated() {
            
            
            
            if keys[i+1] > number {
                return num
            }
        }
        
        return nil
    }
    
    //MARK: - Roman Numeral to Arabic
    static func convert(_ romanNumeral: String) -> Int {
        
        return Int(romanNumeral) ?? 0
    }
}


