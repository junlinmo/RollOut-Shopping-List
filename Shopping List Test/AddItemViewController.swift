//
//  AddItemViewController.swift
//  Shopping List Test
//
//  Created by Junlin Mo on 8/25/18.
//  Copyright © 2018 Junlin Mo. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate {
    func controller(controller: AddItemViewController, didSaveItemWithName name: String, andPrice price: Float)
}

class AddItemViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    
    var delegate: AddItemViewControllerDelegate?
    
    // MARK: -
    // MARK: Actions
    @IBAction func cancel(sender: UIBarButtonItem) {

        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func save(sender: UIBarButtonItem) {
        
        if let name = nameTextField.text, let priceAsString = priceTextField.text, let price = Float(priceAsString) {
            // Notify Delegate
            delegate?.controller(controller: self, didSaveItemWithName: name, andPrice: price)
            
            // Dismiss View Controller
            dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
