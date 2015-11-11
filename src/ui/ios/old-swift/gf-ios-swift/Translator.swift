import UIKit
import Foundation

class Translator {
    
    // Create allocation pool, exception frame, and pgf grammar
    var pool: COpaquePointer
    var err: UnsafeMutablePointer<GuExn>
    var out: UnsafeMutablePointer<GuOut>
    let pgf: UnsafeMutablePointer<PgfPGF>
    
    init() {
        self.pool = gu_new_pool()
        self.err = gu_new_exn(self.pool)
        self.out = gu_file_out(stdout, self.pool)
        
        // Read the PGF grammar.
        var pgfBundle = NSBundle .mainBundle()
        var pgfStr = pgfBundle .pathForResource("App", ofType: "pgf", inDirectory: "grammars")
        self.pgf = pgf_read(pgfStr!, self.pool, self.err)
    }
    
    // Variable to hold concrete grammars
    var grammars: [String: (name: String, concr: UnsafeMutablePointer<PgfConcr>)] = [
        "to": ("", UnsafeMutablePointer<PgfConcr>()),
        "from": ("", UnsafeMutablePointer<PgfConcr>()),
        "previous": ("", UnsafeMutablePointer<PgfConcr>())
    ]
    
    // Loads a grammar (but returns it, doesn't save it)
    func loadGrammar(language: String, destination: String) -> Void {
        
        // Switch with the previously used language if applicable
        if (language == self.grammars["previous"]!.name) {
            return self.switchLanguages(destination, to: "third")
        }
        
        // Load the file
        var pgfBundle = NSBundle .mainBundle()
        var concr = pgf_get_language(self.pgf, "App\(language)")
        var fileStr = pgfBundle.pathForResource("App\(language)", ofType: "pgf_c", inDirectory: "grammars")
        var file = fopen(fileStr!, "r")
        
        // Load the grammar
        pgf_concrete_load(concr, gu_file_in(file, self.pool), self.err)
        if (self.grammars[destination]!.concr != UnsafeMutablePointer<PgfConcr>()) {
            pgf_concrete_unload(self.grammars[destination]!.concr)
        }
        self.grammars[destination]!.concr = nil
        self.grammars[destination]!.concr = concr
        
    }
    
    // Switches place of from and to concrete grammars
    func switchLanguages(from: String, to: String) -> Void {
        let tmp = self.grammars[from]!
        self.grammars[from] = self.grammars[to]!
        self.grammars[to] = tmp
    }
    
    // Translate a string
    func translate(phrase: String) -> String {
        
        // Intialise temporary pools
        var tmpPool = gu_new_pool()
        var tmpErr = gu_new_exn(tmpPool)
        
        // Try to parse it fully
        var parse = self.parse(phrase, startCat: "Phr", tmpPool: tmpPool, tmpErr: tmpErr)
        var translation = ""
        if (parse != nil) {
            translation = self.linearize(parse, tmpPool: tmpPool, tmpErr: tmpErr)
        } else {
            translation = self.translateByLookup(phrase)
        }
        
        // Clear up resources
        gu_exn_clear(tmpErr)
        gu_pool_free(tmpPool)
        tmpPool = nil
        tmpErr = nil

        return translation
    }
    
    // Translates by lookup - that is, each word by itself
    func translateByLookup(phrase: String) -> String {
        var translation = "%"
        var words = phrase.componentsSeparatedByString(" ")
        for word in words {
            translation += self.translateWord(word) + " "
        }
        return translation
    }
    
    // Translates a single word - differs from phrase translation as it does morphological analysis
    func translateWord(word: String) -> String {
        
        // Intialise temporary pools
        var tmpPool = gu_new_pool()
        var tmpErr = gu_new_exn(tmpPool)
        
        // Try to parse it fully
        var parse = self.parse(word, startCat: "Chunk", tmpPool: tmpPool, tmpErr: tmpErr)
        var translation = ""
        if (parse != nil) {
            translation = self.linearize(parse, tmpPool: tmpPool, tmpErr: tmpErr)
        } else {

            // Full parse didn't work; try to make a morphological analysis
            
            // This functionality is currently missing due to pointer hell in Swift.
            // The full temporary code is commented out below. For now, we just return the uppercased translation instead.
            translation = word.uppercaseString
            
//            var lcWord = word.lowercaseString
//            var p = UnsafeMutablePointer<(UnsafeMutablePointer<PgfMorphoCallback>, PgfCId, GuString, prob_t, UnsafeMutablePointer<GuExn>) -> ()>.alloc(1)
//            p.initialize(morphoCallback)
//            var cp = COpaquePointer(p)
//            var fp = CFunctionPointer<(UnsafeMutablePointer<PgfMorphoCallback>, PgfCId, GuString, prob_t, UnsafeMutablePointer<GuExn>) -> ()>(cp)
//            var callback = PgfMorphoCallback(callback: fp)
//            pgf_lookup_morpho(self.grammars["from"]!.concr, word, &callback, tmpErr)
//            if (gu_ok(tmpErr)) {
//                var analyses = []
//                for analysis in analyses {
//                    var lemma = ???
//                    if (self.hasLinearization(lemma)) {
//                        var sbuf = gu_string_buf(tmpPool)
//                        var sbufstr = gu_string_buf_freeze(sbuf, tmpPool)
//                        var tmpIn = gu_data_in(String(UTF8String: sbufstr)!, strlen(sbufstr), tmpPool)
//                        var expr = pgf_read_expr(tmpIn, tmpPool, tmpErr)
//                        var ep = PgfExprProb(prob: 0, expr: expr)
//                        translation = self.linearize(ep, tmpPool: tmpPool, tmpErr: tmpErr)
//                        break
//                    }
//                }
//            } else {
                // Morphological analysis failed as well - just use the uppercased version of the word
//                translation = word.uppercaseString
//            }
            
        }
        
        // Clear up resources
        gu_exn_clear(tmpErr)
        gu_pool_free(tmpPool)
        tmpPool = nil
        tmpErr = nil
        
        return translation
        
    }
    
    // Checks whether a linearization exists for a given analysis
    func hasLinearization(analysis: PgfCId) -> Bool {
        var tmpPool = gu_new_pool()
        var result = pgf_has_linearization(self.grammars["to"]!.concr, analysis)
        gu_pool_free(tmpPool)
        tmpPool = nil
        return result
    }
    
    // Wrapper to perform a parse and return either the parse or
    func parse(phrase: String, startCat: String, tmpPool: COpaquePointer, tmpErr: UnsafeMutablePointer<GuExn>) -> UnsafeMutablePointer<PgfExprEnum> {
        var result = pgf_parse(self.grammars["from"]!.concr, startCat, phrase, tmpErr, tmpPool, tmpPool)
        if (!gu_ok(tmpErr)) {
            return nil
        }
        return result
    }
    
    // Takes a parse result and linearizes its first result
    func linearize(result: UnsafeMutablePointer<PgfExprEnum>, tmpPool: COpaquePointer, tmpErr: UnsafeMutablePointer<GuExn>) -> String {
        
        // Get the first result
        var ep = UnsafeMutablePointer<PgfExprProb>()
        gu_enum_next(result, &ep, tmpPool)
        var parse = ep[0]
        
        // Linearise it and convert it to a String literal
        var sbuf = gu_string_buf(tmpPool)
        var tmpOut = gu_string_buf_out(sbuf)
        pgf_linearize(self.grammars["to"]!.concr, parse.expr, tmpOut, tmpErr)
        var translation = String(UTF8String: gu_string_buf_freeze(sbuf, tmpPool))!
        
        // Clear up and return
        gu_out_flush(tmpOut, tmpErr)
        tmpOut = nil
        return translation
        
    }
    
    // Removes characters that shouldn't be in the translated string
    func formatTranslation(translation: String) -> String {
        
        if (translation.isEmpty) {
            return translation
        }
        var copy = translation
        var firstChar = String(Array(translation)[0])
        if (firstChar == "%" || firstChar == "*" || firstChar == "+") {
            copy = copy.substringFromIndex(advance(copy.startIndex, 1))
        }
        for char in ["[", "]", "_"] {
            copy = copy.stringByReplacingOccurrencesOfString(char, withString: " ")
        }
        return copy
        
    }
}