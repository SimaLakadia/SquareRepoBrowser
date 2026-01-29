
//
//  String+Extension.swift
//  SquareRepoBrowser
//

import Foundation

/// Utility extension to capitalize only the first character
/// without affecting the rest of the string.
extension String {

    func capitalizedFirstLetter() -> String {
        guard let first = first else { return self }
        return first.uppercased() + dropFirst()
    }
}
