//
//  SearchQuery.swift
//  Whooosh
//
//  Created by Jamal Rasool on 2/23/19.
//  Copyright © 2019 Jamal Rasool. All rights reserved.
//

import UIKit

// Try it now controller
class inititalLoadController: UIViewController {
    
    @IBOutlet weak var WhereField: UITextField!
    
    
    override func viewDidLoad() {
        designFormatting()
    }
    
    private func designFormatting() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        title = "Try it now"
        self.navigationController?.navigationBar.barTintColor = healthyColor
        hideKeyboard()
        self.WhereField.backgroundColor = UIColor.white
        //or self.tv_comments.backgroundColor = UIColor.clear
        //self.tv_comments.layer.backgroundColor = UIColor.white
        
        self.WhereField.layer.shadowRadius = 5.0
        self.WhereField.layer.borderColor = UIColor.gray.cgColor
        self.WhereField.layer.borderWidth = 0.5
        
        self.WhereField.layer.shadowColor = UIColor.gray.cgColor
        self.WhereField.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.WhereField.layer.shadowOpacity = 1.0
        self.WhereField.textColor = UIColor.black

    }
}

// Where (asking for the users location)
class secondaryLoadController: UIViewController {
    override func viewDidLoad() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        title = "Where"
    }
    
}

class loadingViewController: UIViewController {
    override func viewDidLoad() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
    }
    
    private func handleAPIPush(Location:String, Keyword:String) {
        
        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
        
        let parameters: [String: String] = ["name": Location, "keyword": Keyword]
        
        //create the url with URL
        let url = URL(string: "http://myServerName.com/api")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
}
