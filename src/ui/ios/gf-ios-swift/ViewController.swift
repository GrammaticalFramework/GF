import UIKit
import AVFoundation

class ViewController: UIViewController {

    // Set sizes used within the controller
    let maxBoxWidth: CGFloat = 150
    let boxOffset: CGFloat = 10
    var scrollViewHeight: CGFloat = 0
    var scrollViewWidth: CGFloat = 0
    
    // Translation properties
    let translator = Translator()
    let colors = Colors()
    let synthesizer = AVSpeechSynthesizer()
    let languages = allLanguages
    var inLanguage: Language!
    var outLanguage: Language!

    // Initiate picker views
    let inPicker: UIPickerView = UIPickerView()
    let outPicker: UIPickerView = UIPickerView()
    
    // UI connections
    @IBOutlet weak var translationsView: UIScrollView!
    @IBOutlet weak var inLanguageField: UITextField!
    @IBOutlet weak var outLanguageField: UITextField!
    
    // Reverses to and from languages
    @IBAction func switchLanguages(sender: UIButton) {
        self.inLanguageField.text = self.outLanguage.name
        self.outLanguageField.text = self.inLanguage.name
        let tmpLanguage = self.inLanguage
        self.inLanguage = self.outLanguage
        self.outLanguage = tmpLanguage
        self.translator.switchLanguages("from", to: "to") // to also switch concrete grammars
    }
    
    // Creates a new translation field when the user clicks the keyboard icon
    @IBAction func openKeyboard(sender: UIButton) {
        let field = createFromView()
        field.becomeFirstResponder()
    }

    // Starts the speech recognition process when the user clicks the microphone icon
    @IBAction func openMicrophone(sender: UIButton) {
        self.createToView("microphone support is on its way")
    }
    
    // Sums the heights of all translation boxes + margins
    func calculateTranslationHeights() -> CGFloat {
        var height = CGFloat(-29.5) // compensate for invisible scrollbars
        for view in self.translationsView.subviews {
            height += view.frame.height + self.boxOffset
        }
        height += self.boxOffset
        return height
    }
    
    // Creates a new "to translate" view and returns it for placement
    func createFromView() -> UITextView {
        let view = UITextView(frame: CGRect(
            x: self.boxOffset,
            y: self.calculateTranslationHeights(),
            width: 20,
            height: 30
        ))
        view.backgroundColor = self.colors.backgroundColors["source"]
        view.layer.cornerRadius = 5
        view.returnKeyType = UIReturnKeyType.Done
        
        view.delegate = self
        self.translationsView.addSubview(view)
        self.resizeTranslationsView()
        return view
    }
    
    // A UIScrollView doesn't know its own height; use this method to resize it
    func resizeTranslationsView() -> Void {
        var subviewHeights = self.calculateTranslationHeights()
        if (subviewHeights > self.scrollViewHeight) {
            self.translationsView.contentSize = CGSizeMake(
                self.translationsView.frame.width, subviewHeights)

            // Also scroll to bottom
            let offset = self.translationsView.contentSize.height - self.translationsView.bounds.size.height
            let point = CGPointMake(0, offset)
            self.translationsView.setContentOffset(point, animated: true)

        }
    }
    
    // Creates and places a new "translated" view given the translated text
    func createToView(translation: String) -> Void {
        let view = UITextView(frame: CGRect(
            x: 0, // we set the real value later a few lines down below
            y: self.calculateTranslationHeights(),
            width: self.maxBoxWidth,
            height: 30
        ))
        view.backgroundColor = self.colors.translationToUIColor(translation)
        view.text = self.translator.formatTranslation(translation)
        view.layer.cornerRadius = 5
        view.sizeToFit()
        
        // The view has been set, so we can now move it further to the right
        view.frame.origin.x = self.scrollViewWidth - 10 - view.frame.width
        self.translationsView.addSubview(view)
        self.resizeTranslationsView()
    }
    
    // Perform translation
    func translate(phrase: String) -> Void {
        var translation = self.translator.translate(phrase)
        self.createToView(translation)
        
        // Run TTS except in simulator (because the simulator doesn't support it)
        #if !arch(i386) && !arch(x86_64)
            var utterance = AVSpeechUtterance(string: translation)
            utterance.voice = AVSpeechSynthesisVoice(language: self.outLanguage.bcp)
            self.synthesizer.speakUtterance(utterance)
        #endif

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set size variables (-162 for the height to compensate for the views above the scrollview)
        self.scrollViewHeight = UIScreen.mainScreen().bounds.height - 162
        self.scrollViewWidth = UIScreen.mainScreen().bounds.width
        
        // Load view pickers
        self.inPicker.delegate = self
        self.inPicker.dataSource = self
        
        self.outPicker.delegate = self
        self.outPicker.dataSource = self
        
        self.inLanguageField.inputView = inPicker
        self.outLanguageField.inputView = outPicker
        
        // Load initial languages
        self.inLanguage = self.languages[3]   // English
        self.outLanguage = self.languages[10] // Swedish
        self.translator.loadGrammar("Eng", destination: "from")
        self.translator.loadGrammar("Swe", destination: "to")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// On selection functionality for the view pickers
extension ViewController: UIPickerViewDelegate {
    
    // Makes the picker views return a language rather than text
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String
    {
        return self.languages[row].name
    }
    
    // Row was selected: update buttons, load new grammar
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var language = self.languages[row]
        
        var fromTo: String
        var textField = UITextField()
        if (pickerView == self.inPicker) {
            self.inLanguage = language
            fromTo = "from"
            textField = self.inLanguageField
        } else {
            self.outLanguage = language
            fromTo = "to"
            textField = self.outLanguageField
        }

        self.translator.loadGrammar(language.abbreviation, destination: fromTo)
        textField.text = language.name
        textField.resignFirstResponder()
    }
    
}

// View picker layout functionality
extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.languages.count
    }
    
}

// Keyboard input functionality
extension ViewController: UITextViewDelegate {
    
    // Method is called on keypress
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {

        // UITextViews lack a method to close keyboard on enter, so we use this slight hack
        if (text == "\n") {
            textView.resignFirstResponder()
            self.translate(textView.text)
            return false
        }
        
        // But if it wasn't the enter key, we resize the UITextView dynamically
        textView.sizeToFit()
        if (textView.frame.size.width < self.maxBoxWidth) {
            textView.frame.size.width += 10
        }
        return true
    }
    
}