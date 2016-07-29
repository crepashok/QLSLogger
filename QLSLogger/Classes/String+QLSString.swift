//
//  String+QLSString.swift
//  Pods
//
//  Created by Pasha Cretsu on 7/29/16.
//
//

import Foundation



public extension String {
    
    public func truncate(length: Int, trailing: String? = "...") -> String {
        var result = self
        if self.characters.count > length {
            result = result.substringToIndex(self.startIndex.advancedBy(length - (trailing?.characters.count)!)) + (trailing ?? "")
        } else {
            while result.characters.count < length {
                result.append(Character(" "))
            }
        }
        return result
    }
}