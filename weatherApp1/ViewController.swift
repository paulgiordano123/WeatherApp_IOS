//
//  ViewController.swift
//  weatherApp1
//
//  Created by paulgiordano on 12/20/19.
//  Copyright © 2019 paulgiordano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //UI element outlets
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var dataTextField: UILabel!
    
    @IBAction func searchButton(_ sender: UIButton) {
        if let url = URL(string: "https://www.weather-forecast.com/locations/" + (cityTextField.text?.replacingOccurrences(of: " ", with: "-") ?? "") + "/forecasts/latest") {
        
        let request = NSMutableURLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            var message = ""
            
            if let error = error  {
                
                print(error)
                
            } else {
                
                if let unwrappedData = data {
                    
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                    
                    var stringSeparator = "(1&ndash;3 days)</span><p class=\"b-forecast__table-description-content\"><span class=\"phrase\">"
                    
                    if let contentArray = dataString?.components(separatedBy: stringSeparator){
                       
                        if contentArray.count > 1{
                            
                            stringSeparator = "</span>"
                            
                            let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                                
                                
                                if newContentArray.count > 1{
                                    
                                    message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                    print(message)
                                    
                                }
                            
                        }

                    }
                    
                }
            }
            if message == ""{
                
                message = "The weather for that location could not be found. Please try a different location."
                
            }
            DispatchQueue.main.sync {
                self.dataTextField.text = message
            }
            
        }
       
            task.resume()
            
        } else {
            
            dataTextField.text = "The weather could not be found. Please try again."
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
}

