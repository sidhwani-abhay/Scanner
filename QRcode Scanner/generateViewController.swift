//
//  generateViewController.swift
//  QRcode Scanner
//
//  Created by Abhay Sidhwani on 28/12/17.
//  Copyright © 2017 Abhay Sidhwani. All rights reserved.
//

import UIKit

class generateViewController: UIViewController {

   
    @IBOutlet weak var generateText: UITextField!
    
    @IBOutlet weak var qrCodeImage: UIImageView!
    
    @IBAction func generateQRCode(_ sender: UIButton) {
        if (generateText.text?.isEmpty)!
        {
            displayMessage(userMessage: "Please fill all the fields")
            return
        }
        
        if let mystring = generateText.text
        {
            let data = mystring.data(using: String.Encoding.ascii)
            if let filter = CIFilter(name: "CIQRCodeGenerator")
            {
                filter.setValue(data, forKey: "inputMessage")
                filter.setValue("M", forKey: "inputCorrectionLevel")
                guard let qrcodeimage = filter.outputImage else { return }
                let scaleX = qrCodeImage.frame.size.width / qrcodeimage.extent.size.width
                let scaleY = qrCodeImage.frame.size.height / qrcodeimage.extent.size.height
                
                let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
                if let output = filter.outputImage?.transformed(by: transform)
                {
                    let img = UIImage(ciImage: output)
                    qrCodeImage.image = img
                    
                    let button:UIButton = UIButton(frame: CGRect(x: 90, y: 500, width: 200, height: 50))
                    button.backgroundColor = .lightGray
                    button.setTitleColor(UIColor.black, for: .normal)
                    button.titleLabel!.font = UIFont.boldSystemFont(ofSize: 20)
                    button.setTitle("Save to gallery", for: .normal)
                    button.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
                    self.view.addSubview(button)
                    
                    
                }
            }
        }
        
    }
    @objc func buttonClicked() {
        print("hello")
        if let imagecode = qrCodeImage.image{
        UIImageWriteToSavedPhotosAlbum(imagecode, self , #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your  code has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func displayMessage(userMessage : String) -> Void {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Important",
                message: userMessage,
                preferredStyle: UIAlertControllerStyle.alert
            )
            alert.addAction(UIAlertAction(title: "dismiss", style: .default,handler : nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
