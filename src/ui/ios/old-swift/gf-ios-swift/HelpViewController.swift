import UIKit

// The HelpViewController only contains static text and a back button
class HelpViewController: UIViewController {

    @IBOutlet weak var helpView: UIWebView!
    
    // Closes the view when the back button is blicked
    @IBAction func backToMain(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets the HTML for the UIWebView
        self.helpView.loadHTMLString("<html><body><h1>HTML goes here</h1></body></html>", baseURL: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
