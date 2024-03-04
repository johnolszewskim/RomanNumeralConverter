//
//  RomanNumeral.swift
//  RomanNumeralConverter
//
//  Created by Johnny O on 2/20/24.
//

import Foundation

/**
 Class used to represent basic Arabic numbers and Roman numerals including conversion between the two.
 Conversion functionality is access through methods called on a singleton class instance.
 
 */
struct RomanNumeral {
    
    let arabicToRoman = [1:"I",
                         5: "V",
                         10: "X",
                         50: "L",
                         100: "C",
                         500: "D",
                         1000: "M"]
    
    let romanToArabic = ["I": 1,
                         "V": 5,
                         "X": 10,
                         "L": 50,
                         "C": 100,
                         "D": 500,
                         "M": 1000]
    
    var romanNumeral: String = ""
    var arabicNumber: String = ""
    
    static let shared = RomanNumeral()
    
    /**
     Empty initializer used to create singleton instance.
     */
    private init() { }
    
    //MARK: - Roman Numeral -> Arabic Number
    
    /**
     Converts a Roman numeral to an Arabic number as a String or nil.
     
     - Parameter roman Roman numeral to convert. Can be lower or uppercase.
     
     - returns nil if parameter is nil, blank or includes an invalid representation of a Roman numeral.
     If not nil then a properly converted Arabic number as a String?
     */
    func convertToArabicNumber(from roman: String?) -> String? {
        
        guard let romanNumeral = roman?.uppercased() else {
            return nil
        }
        
        if romanNumeral == "" {
            return nil
        }
        
        if !isValidRomanNumeral(romanNumeral).0 {
            return nil
        }
        
        // if romanNumeral is single character and not a valid roman numeral
        if romanNumeral.count == 1 {
            return romanToArabic[romanNumeral] != nil ? String(romanToArabic[romanNumeral]!) : nil
        }
        
        if romanToArabic[romanNumeral[0]]! >= romanToArabic[romanNumeral[1]]! {
            let secondIndex = romanNumeral.index(after: romanNumeral.startIndex)
            let remaining = String(romanNumeral[secondIndex..<romanNumeral.endIndex])
            
            let firstValue = romanToArabic[romanNumeral[0]]!
            let remainingValue = Int(convertToArabicNumber(from: remaining)!) ?? 0
            return String(firstValue + remainingValue)
        } else {
            let thirdIndex = romanNumeral.index(romanNumeral.startIndex, offsetBy: 2)
            let remaining = String(romanNumeral[thirdIndex..<romanNumeral.endIndex])
            
            let subtractiveTermValue = romanToArabic[romanNumeral[1]]! - romanToArabic[romanNumeral[0]]!
            
            if romanNumeral.count == 2 {
                return String(subtractiveTermValue)
            }
            
            let remainingValue = Int(convertToArabicNumber(from: remaining)!) ?? 0
            let result = String(subtractiveTermValue + remainingValue)
            return result
        }
    }
    
        /**
         Chekcks the validity of a Roman numeral.
         
         - Parameter roman Roman numeral to be checked for validity
         
         - returns tuple representing if Roman numeral is valid and, if not, a integer representing the reason.
         (true, 0) if Roman numeral meets all requirements for a valid roman numeral.
         (false, -1) if a symbol is repeated that should not be repeated.
         (false, -2) if a symbol is repeated four times in a row
         (false, -3) a smaller symbol is found before larger symbol invalidily
         (false, -4) contains invalid symbols
         */
    func isValidRomanNumeral(_ roman: String) -> (Bool, Int) {
        
        let invalidDuplicates = ["V", "L", "D"]
        
        let invalidSubtractiveTerms = ["I": ["L","C","D","M"],
                                       "V": ["X","L","C","D","M"],
                                       "X": ["D", "M"],
                                       "L": ["C","D","M"],
                                       "C": [],
                                       "D": ["M"],
                                       "M": []
        ]
        
        //if string contains invalid characters
        for l in roman {
            if !romanToArabic.keys.contains("\(l)") {
                return (false, -4)
            }
        }
        
        // if there are no invalid characters then a single character must be valid
        if roman.count == 1 {
            return (true, 0)
        }
        
        var repeatCount = 1
        var preceding: String
        var following: String
        
        for i in (1..<roman.count) {
            preceding = roman[i-1]
            following = roman[i]
            
            if preceding == following {
                // RULE: "V", "D", and "L" are never repeated
                if invalidDuplicates.contains(preceding) {
                    return (false, -1)
                }
                repeatCount += 1
            } else {
                repeatCount = 1
            }
            
            // RULE: Symbol cannot repeated 4 times
            if repeatCount == 4 {
                return (false, -2)
            }
            
            if romanToArabic[preceding]! < romanToArabic[following]! && invalidSubtractiveTerms[preceding]!.contains(following) {
                return (false, -3)
            }
        }
        
        return (true, 0)
    }
    
    // MARK: - Arabic Number -> Roman Numeral
    
    /**
     Converts Arabic number to a Roman numeral. Number must be between
     0 and 3999 inclusive.
     
     - Parameter arabic number to be converted represented as a String?
     
     - returns nil if parameter is nil, cannot be converted to an Int or is blank.
     If valid then returns Roman numeral as String?.
     
     */
    func convertToRomanNumeral(from arabic: String?) -> String? {
        
        guard let arabicStr = arabic else {
            return nil
        }
        
        guard let arabicInt = Int(arabicStr) else {
            return nil
        }
        
        if arabicInt >= 4000 {
            return nil
        }
        
        if arabicInt == 0 { return "" }
        
        // checking for single value roman numeral
        if let singleCharValue = arabicToRoman[arabicInt] {
            return String("\(singleCharValue)")
        }
        
        if let subtractiveTerm = getSubtractiveTerm(arabicInt) {
            return subtractiveTerm.1 + convertToRomanNumeral(from: String(arabicInt - subtractiveTerm.0))!
        }
        
        if let additiveTerm = getAdditiveTerm(arabicInt) {
            return additiveTerm.1 + convertToRomanNumeral(from: String(arabicInt - additiveTerm.0))!
        }
        
        return ""
    }
    
    func getSubtractiveTerm(_ number: Int) -> (Int, String)? {
        
        print("getSubtractiveTerm(\(number))")
        
        let validSubtractiveValues = [5: 1, // V
                                      10: 1, // X
                                      50: 10, // L
                                      100: 10, // C
                                      500: 100, // D
                                      1000: 100] // M
        
        let keys = arabicToRoman.keys.sorted()
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
            let subtractiveString = String(arabicToRoman[subtractiveValue]!) + String(arabicToRoman[keys[index]]!)
            let subtractiveInt = keys[index] - subtractiveValue
            let result = (subtractiveInt, subtractiveString)
            print(result)
            return result
        }
        
        return nil
    }
    
    func getAdditiveTerm(_ number: Int) -> (Int, String)? {
        
        print("getAdditiveTerm(\(number))")
        
        guard let lesserSymbol = getSymbolValueLessThan(number) else {
            return nil
        }
        
        let times = number / lesserSymbol
        let resultString = String(repeating: arabicToRoman[lesserSymbol]!, count: times)
        print(resultString)
        
        return (times * lesserSymbol, resultString)
    }
    
    func getSymbolValueLessThan(_ number: Int) -> Int? {
        
        if number > 1000 {
            return 1000
        }
        
        let keys = arabicToRoman.keys.sorted()
        
        for (i, num) in keys.enumerated() {
            
            if keys[i+1] > number {
                return num
            }
        }
        
        return nil
    }
    
    private func getFirstTwoValues(_ roman: String) -> (Int, Int)? {
        
        if roman.count < 2 { return nil }
        
        let firstIndex = roman.index(roman.startIndex, offsetBy: 0)
        let secondIndex = roman.index(after: firstIndex)
        
        let firstChar = String(roman[firstIndex])
        let secondChar = String(roman[secondIndex])
        
        print(firstChar)
        print(secondChar)
        
        return(romanToArabic[firstChar]!, romanToArabic[secondChar]!)
    }
}

