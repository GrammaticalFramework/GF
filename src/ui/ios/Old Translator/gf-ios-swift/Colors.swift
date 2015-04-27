import UIKit
import Foundation

// An extension to UIColor which allows the use of hex initialisation
extension UIColor {
    
    convenience init(hex: Int) {
        
        let components = (
            red:    CGFloat((hex >> 16) & 0xff) / 255,
            green:  CGFloat((hex >> 08) & 0xff) / 255,
            blue:   CGFloat((hex >> 00) & 0xff) / 255
        )
        
        self.init(red: components.red, green: components.green, blue: components.blue, alpha: 1.0)
        
    }
    
}

class Colors {
 
    // Set the background colours to use by the view controller
    let backgroundColors = [
        "worst":    UIColor(hex: 0xff303e),
        "best":     UIColor(hex: 0x75cd75),
        "chunks":   UIColor(hex: 0xffb2a5),
        "default":  UIColor(hex: 0xffff99),
        "source":   UIColor(hex: 0xcdcded)
    ]
    
    // Checks a given translated string to see how good it is and hence which background colour it should have
    func translationToUIColor(translation: String) -> UIColor {
        
        if (translation.isEmpty) {
            return self.backgroundColors["default"]!
        }
        
        var firstChar = String(Array(translation)[0])
        
        // Parse by words, marked by %, darkest red color
        if (firstChar == "%") {
            return self.backgroundColors["worst"]!
        }
        
        // Parse by chunks, marked by *, red color
        if (firstChar == "*") {
            return self.backgroundColors["chunks"]!
        }
        
        // Parse error: darkest red color
        if (translation.rangeOfString("parse error:") != nil) {
            return self.backgroundColors["worst"]!
        }
        
        // Unknown linearizations in output
        if (translation.rangeOfString("[") != nil) {
            return self.backgroundColors["worst"]!
        }
        
        // Parse by domain grammar, marked by +, green color
        if (firstChar == "+") {
            return self.backgroundColors["best"]!
        }
        
        // Otherwise, use the default colour
        return self.backgroundColors["default"]!
        
    }

    
}