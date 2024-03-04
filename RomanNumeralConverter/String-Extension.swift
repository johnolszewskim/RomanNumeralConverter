//
//  String-Extension.swift
//  RomanNumeralConverter
//
//  Created by Johnny O on 2/20/24.
//

import Foundation

extension String {
    
    subscript(_ i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}
