//
//  ViewController.swift
//  WebViewPoc
//
//  Created by Annas on 12/05/2022.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    @IBOutlet var myWebView: MyWebView!
    @IBOutlet var jsTextField: UITextView!
    @IBOutlet var websiteTextField: UITextField!
    @IBOutlet var responseTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myWebView.load(URLRequest(url: URL(string: "https://apple.com")!))
        
        self.myWebView.layer.borderWidth = 1
        self.myWebView.layer.borderColor = UIColor.gray.cgColor
        self.jsTextField.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        self.websiteTextField.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
    }
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }

    @IBAction func scrollUpAction(_ sender: UIButton) {
        self.myWebView.evaluateJavaScript("window.scrollBy(0,-100)")
    }
    
    @IBAction func scrollDownAction(_ sender: UIButton) {
        self.myWebView.evaluateJavaScript("window.scrollBy(0,100)")
    }
    
    @IBAction func evaluateJSAction(_ sender: UIButton) {
        self.responseTextField.text = ""
        self.myWebView.evaluateJavaScript(self.jsTextField.text ?? "") { response, error in
            if let error = error {
                self.responseTextField.text = "error:" + error.localizedDescription
            } else {
                if let response = response {
                    if let str = response as? String {
                        self.responseTextField.text = str
                    } else {
                        self.responseTextField.text = "\(type(of: response))"
                    }
                }
            }
        }
    }
    
    @IBAction func goToWebsiteAction(_ sender: Any) {
        if let link = URL(string: self.websiteTextField.text ?? "") {
            let request = URLRequest(url: link)
            self.myWebView.load(request)
        } else {
            let alert = UIAlertController(title: "Bad URL", message: "Please type a correct URL", preferredStyle: .alert)
            self.present(alert, animated: true)
        }
    }
}

class MyWebView: WKWebView {
    
}

extension UITextView {
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }
}

extension UITextField {
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }
}
