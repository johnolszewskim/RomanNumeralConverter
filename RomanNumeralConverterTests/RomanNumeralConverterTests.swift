//
//  RomanNumeralConverterTests.swift
//  RomanNumeralConverterTests
//
//  Created by Johnny O on 2/18/24.
//

import XCTest
@testable import RomanNumeralConverter

final class RomanNumeralConverterTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //MARK: Test Roman to Arabic
    
    func testContainsInvalidDuplicates() throws {
        assert(RomanNumeral.shared.isValidRomanNumeral("I") == (true,0))
        assert(RomanNumeral.shared.isValidRomanNumeral("VV") == (false,-1))
        assert(RomanNumeral.shared.isValidRomanNumeral("LL") == (false,-1))
        assert(RomanNumeral.shared.isValidRomanNumeral("DDI") == (false,-1))
        assert(RomanNumeral.shared.isValidRomanNumeral("XIII") == (true,0))
        assert(RomanNumeral.shared.isValidRomanNumeral("DXX") == (true,0))
    }
    
    func testContainsRepeatOfFour() throws {
        assert(RomanNumeral.shared.isValidRomanNumeral("III") == (true,0))
        assert(RomanNumeral.shared.isValidRomanNumeral("XIIII") == (false,-2))
        assert(RomanNumeral.shared.isValidRomanNumeral("XXXXIV") == (false,-2))
    }
    
    func testContainsInvalidSubtractiveTerms() throws {
        assert(RomanNumeral.shared.isValidRomanNumeral("IL") == (false,-3))
        assert(RomanNumeral.shared.isValidRomanNumeral("IC") == (false,-3))
        assert(RomanNumeral.shared.isValidRomanNumeral("ID") == (false,-3))
        assert(RomanNumeral.shared.isValidRomanNumeral("IM") == (false,-3))
    }
    
    func testConvertToArabicNumberErrors() throws {
        assert(RomanNumeral.shared.convertToArabicNumber(from: nil) == nil)
        assert(RomanNumeral.shared.convertToArabicNumber(from: "") == nil)
        assert(RomanNumeral.shared.convertToArabicNumber(from: "A") == nil)
        assert(RomanNumeral.shared.convertToArabicNumber(from: "I") == "1")
        assert(RomanNumeral.shared.convertToArabicNumber(from: "V") == "5")
        assert(RomanNumeral.shared.convertToArabicNumber(from: "X") == "10")
        assert(RomanNumeral.shared.convertToArabicNumber(from: "L") == "50")
        assert(RomanNumeral.shared.convertToArabicNumber(from: "C") == "100")
        assert(RomanNumeral.shared.convertToArabicNumber(from: "D") == "500")
        assert(RomanNumeral.shared.convertToArabicNumber(from: "M") == "1000")
        assert(RomanNumeral.shared.convertToArabicNumber(from: "IK") == nil)
        
    }
    
    func testAdditiveRomanNumerals() throws {
        assert(RomanNumeral.shared.convertToArabicNumber(from: "III") == "3")
        assert(RomanNumeral.shared.convertToArabicNumber(from: "XX") == "20")
        assert(RomanNumeral.shared.convertToArabicNumber(from: "XVI") == "16")
    }

    func testSubtractiveRomanNumerals() throws {
        assert(RomanNumeral.shared.convertToArabicNumber(from: "IV") == "4")
        assert(RomanNumeral.shared.convertToArabicNumber(from: "IX") == "9")
        assert(RomanNumeral.shared.convertToArabicNumber(from: "XL") == "40")
    }
    
    func testConverToArabicNumber() throws {
        assert(RomanNumeral.shared.convertToArabicNumber(from: "CCLXXXIII") == "283")
        assert(RomanNumeral.shared.convertToArabicNumber(from: "MMMCMXCIX") == "3999")
        assert(RomanNumeral.shared.convertToArabicNumber(from: "DXLVIII") == "548")
        assert(RomanNumeral.shared.convertToArabicNumber(from: "MMMDCCCXXXVII") == "3837")
        assert(RomanNumeral.shared.convertToArabicNumber(from: "MMMDCCLVI") == "3756")
        assert(RomanNumeral.shared.convertToArabicNumber(from: "MCCCLXXVIII") == "1378")
        assert(RomanNumeral.shared.convertToArabicNumber(from: "MDXLII") == "1542")
        assert(RomanNumeral.shared.convertToArabicNumber(from: "MMMDCLI") == "3651")
        assert(RomanNumeral.shared.convertToArabicNumber(from: "MMMCCII") == "3202")
        assert(RomanNumeral.shared.convertToArabicNumber(from: "XLIX") == "49")
    }
    
    //MARK: Test Arabic to Roman
    
    func testExactSymbolValues() throws {
        assert(RomanNumeral.shared.convertToRomanNumeral(from: "1") == "I")
        assert(RomanNumeral.shared.convertToRomanNumeral(from: "5") == "V")
        assert(RomanNumeral.shared.convertToRomanNumeral(from: "10") == "X")
        assert(RomanNumeral.shared.convertToRomanNumeral(from: "50") == "L")
        assert(RomanNumeral.shared.convertToRomanNumeral(from: "100") == "C")
        assert(RomanNumeral.shared.convertToRomanNumeral(from: "500") == "D")
        assert(RomanNumeral.shared.convertToRomanNumeral(from: "1000") == "M")
    }
    
    func testSubtrativeTerms() throws {
        assert(RomanNumeral.shared.getSubtractiveTerm(400)! == (400, "CD"))
        assert(RomanNumeral.shared.getSubtractiveTerm(4)! == (4, "IV"))
        assert(RomanNumeral.shared.getSubtractiveTerm(9)! == (9, "IX"))
        assert(RomanNumeral.shared.getSubtractiveTerm(40)! == (40, "XL"))
        assert(RomanNumeral.shared.getSubtractiveTerm(12) == nil)
    }
    
    func testGetSymbolValueLessThan() throws {
        
        assert(RomanNumeral.shared.getSymbolValueLessThan(16)! == 10)
        assert(RomanNumeral.shared.getSymbolValueLessThan(44)! == 10)
        assert(RomanNumeral.shared.getSymbolValueLessThan(49)! == 10)
        assert(RomanNumeral.shared.getSymbolValueLessThan(543)! == 500)
    }
    
    func testAdditiveTerm() throws {
        assert(RomanNumeral.shared.getAdditiveTerm(3)! == (3, "III"))
        assert(RomanNumeral.shared.getAdditiveTerm(18)! == (10, "X"))
    }
    
    func testConvertToRomanNumeral() throws {
        assert(RomanNumeral.shared.convertToRomanNumeral(from: "49") == "XLIX")
        assert(RomanNumeral.shared.convertToRomanNumeral(from: "145") == "CXLV")
        assert(RomanNumeral.shared.convertToRomanNumeral(from: "18") == "XVIII")
        assert(RomanNumeral.shared.convertToRomanNumeral(from: "69") == "LXIX")
        assert(RomanNumeral.shared.convertToRomanNumeral(from: "420") == "CDXX")
        assert(RomanNumeral.shared.convertToRomanNumeral(from: "999") == "CMXCIX")
    }

}
