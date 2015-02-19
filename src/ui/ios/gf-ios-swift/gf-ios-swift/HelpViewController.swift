//  Copyright 2015 Joel Hinz under BSD and LGPL
//
//  This file is part of gf-ios-swift.
//
//  gf-ios-swift is free software: you can redistribute it and/or modify it under the terms of the Lesser GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
//
//  gf-ios-swift is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the Lesser GNU General Public License for more details.
//
//  You should have received a copy of the Lesser GNU General Public License along with gf-ios-swift. If not, see http://www.gnu.org/licenses/.

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
