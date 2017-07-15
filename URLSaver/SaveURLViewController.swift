//
//  SaveURLViewController.swift
//  URLSaver
//
//  Created by radhakrishnan S on 15/07/17.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit
import SwiftSoup

class SaveURLViewController: UIViewController {
    var delegate : BookmarkUpdate? = nil
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!

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
    func  convert(urlString : String, callback: @escaping ((Bookmark?) -> Void)) {
        if let url = URL(string: urlString){
            let queue =  DispatchQueue.global()
            queue.async {
                do {
                    let contents = try String(contentsOf: url)
                    

                    let doc: Document = try SwiftSoup.parse(contents)
                    let link: Element = try! doc.select("link").first()!
                    let linkHref: String = try! link.attr("href"); // "http://example.com/"
                    //let imageURL = doc.
                    let bookMark = Bookmark(url: urlString, title: try doc.title(), iconURL: linkHref)
                    DispatchQueue.main.async {
                         callback(bookMark)
                    }
                   
                    print("Title")
                    
                } catch  {
                    DispatchQueue.main.async {
                       callback(nil)
                    }
                    
                    print("Data fetch faied")
                }
            }
            
            
        }else{
            DispatchQueue.main.async {
                callback(nil)
            }
        }
    }
    func showAlertController(message : String,title : String ){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
            
        }
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension SaveURLViewController : UITextFieldDelegate{
  
    func textFieldShouldReturn(inputText: UITextField) -> Bool {
        
            if let urlString = textField.text {
                convert(urlString: urlString) { (bookmark) in
                    if let data = bookmark {
                        self.delegate?.save(bookmark: data)
                    }else{
                        self.showAlertController(message: "Invalid data", title: "URL")
                    }
                }
            }else{
                self.showAlertController(message: "Provide valid url", title: "URL")
            }
        return trueso
        
        
    }
   
    
}
