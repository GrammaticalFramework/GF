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
    Language(name: "Japanese",  abbreviation: "Jpn", bcp: "ja-JP"),
    Language(name: "Spanish",   abbreviation: "Spa", bcp: "es-ES"),
    Language(name: "Swedish",   abbreviation: "Swe", bcp: "sv-SE"),
    Language(name: "Thai",      abbreviation: "Tha", bcp: "th-TH")

]

// Callback for morphological analysis - if it turns out this isn't needed, it could be removed
func morphoCallback(callback: UnsafeMutablePointer<PgfMorphoCallback>, lemma: PgfCId, analysis: GuString, prob: prob_t, err: UnsafeMutablePointer<GuExn>) -> Void {
}