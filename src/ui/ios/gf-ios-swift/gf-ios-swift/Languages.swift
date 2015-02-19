//  Copyright 2015 Joel Hinz under BSD and LGPL
//
//  This file is part of gf-ios-swift.
//
//  gf-ios-swift is free software: you can redistribute it and/or modify it under the terms of the Lesser GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
//
//  gf-ios-swift is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the Lesser GNU General Public License for more details.
//
//  You should have received a copy of the Lesser GNU General Public License along with gf-ios-swift. If not, see http://www.gnu.org/licenses/.

import Foundation

// A simple class for a language, mostly just containing its name etc.
class Language {
    
    let name: String
    let abbreviation: String
    let bcp: String
    
    init(name: String, abbreviation: String, bcp: String) {
        self.name = name
        self.abbreviation = abbreviation
        self.bcp = bcp
    }
    
}

// If we need to set more languages in the app, this is the place to do it!
// Don't forget to also update the grammars folder :)
let allLanguages: Array<Language> = [
    Language(name: "Bulgarian", abbreviation: "Bul", bcp: "en-GB"), // lacks bcp-47 code in iOS, would be bg-BG
    Language(name: "Chinese",   abbreviation: "Chi", bcp: "zh-CN"),
    Language(name: "Dutch",     abbreviation: "Dut", bcp: "nl-NL"),
    Language(name: "English",   abbreviation: "Eng", bcp: "en-GB"),
    Language(name: "Finnish",   abbreviation: "Fin", bcp: "fi-FI"),
    Language(name: "French",    abbreviation: "Fre", bcp: "fr-FR"),
    Language(name: "German",    abbreviation: "Ger", bcp: "de-DE"),
    Language(name: "Hindi",     abbreviation: "Hin", bcp: "hi-IN"),
    Language(name: "Italian",   abbreviation: "Ita", bcp: "it-IT"),
    Language(name: "Spanish",   abbreviation: "Spa", bcp: "es-ES"),
    Language(name: "Swedish",   abbreviation: "Swe", bcp: "sv-SE")
]

// Callback for morphological analysis - if it turns out this isn't needed, it could be removed
func morphoCallback(callback: UnsafeMutablePointer<PgfMorphoCallback>, lemma: PgfCId, analysis: GuString, prob: prob_t, err: UnsafeMutablePointer<GuExn>) -> Void {
}