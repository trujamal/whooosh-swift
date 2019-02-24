//
//  jobsTableView.swift
//  Whooosh
//
//  Created by Jamal Rasool on 2/22/19.
//  Copyright © 2019 Jamal Rasool. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation


struct jobsObject: Decodable {
    let company: String!
    let location: [Double]!
    let title: String!
    let keywords: [String]!
    let description: String!
    let pay: Double!
    let applyLink: String!
    
    public enum CodingKeys: String, CodingKey {
        case company = "company"
        case location = "location"
        case title = "title"
        case keywords = "keywords"
        case description = "description"
        case pay = "pay"
        case applyLink = "applyLink"
    }
}

class jobsTableView: UITableViewController, CLLocationManagerDelegate    {
   
    // Initialization Manager
    var jobsArray = [jobsObject]() //Array of dictionary
    var locationManager = CLLocationManager()

    @IBOutlet var jobsTableView: UITableView!
    @IBOutlet weak var editFilter: UIBarButtonItem!
    @IBOutlet weak var mapViewSwitcher: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserLocationPOST()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        title = "Jobs"
        let searchbarComponent = UISearchController(searchResultsController: nil)
        searchbarComponent.searchResultsUpdater = self as? UISearchResultsUpdating
        
        self.navigationItem.searchController = searchbarComponent

        
        
        
        tableView.estimatedRowHeight = 150
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    fileprivate func getUserLocationPOST() {
        let locManager = CLLocationManager()
        var currentLocation: CLLocation!
        
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            
            currentLocation = locManager.location
            let locationString =  ["\(currentLocation.coordinate.latitude)","\(currentLocation.coordinate.longitude)"]
            
            let fakeValues = ["Fullstack","Developer"]
            let defaultRadius = 30
            handleAPIPush(Location: locationString, Keyword: fakeValues, Radius:defaultRadius)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to access your current location")
    }

    @IBAction func editFilterHandler(_ sender: Any) {
        if let presentedViewController = self.storyboard?.instantiateViewController(withIdentifier: "filterMenu") {
            presentedViewController.providesPresentationContextTransitionStyle = true
            presentedViewController.definesPresentationContext = true
            presentedViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext;
            presentedViewController.view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.8)
            self.present(presentedViewController, animated: true, completion: nil)
        }

    }
    
    @IBAction func openMapHandler(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    @objc func handleALERT() {
        
        let alert = UIAlertController(title: "Uh oh", message: "Looks like something went wrong please try again later.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        
        self.present(alert, animated: true)
    }
    
    fileprivate func handleAPIPush(Location:[String], Keyword:[String], Radius:Int) {
        //create the url with URL
        let url = URL(string: jobsListAPI)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "location": Location,
            "radius": Radius,
            "keywords": Keyword
        ]
        
        request.httpBody = parameters.percentEscaped().data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                    print("error", error ?? "Unknown error")
                    return
            }

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }

//            let responseString = String(data: data, encoding: .utf8)
//            print("responseString = \(responseString!)")
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
                {
                    print(jsonArray) // use the json here
                    // link in description for video on JSONDecoder
                    let decoder = JSONDecoder()
                    
                    var converterHandler = try decoder.decode(jobsObject.self, from: data)
                    self.jobsArray = [converterHandler]
                    
                    
                    self.jobsTableView.reloadData()
                    
                } else {
                    print("bad json")
                }
            } catch let error as NSError {
                print(error)
            }
        }
        
        task.resume()
    }

    
}

class jobsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellViewContainer: UIView!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var notificationCircle: UIImageView!
    
    override func prepareForReuse() {
        cellViewContainer.layer.cornerRadius = 8.0
        cellViewContainer.clipsToBounds = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

extension jobsTableView {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobsArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let jobs = jobsArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobsCell", for: indexPath) as! jobsTableViewCell
        
        // Text Information
        cell.companyLabel.text = "$\(String(describing: jobs.company!))"
        cell.positionLabel.text = "$\(String(describing: jobs.title!))"
        cell.locationLabel.text = "Dallas, Tx"
        cell.salaryLabel.text = "$\(String(describing: jobs.pay!)) a year"
        
        cell.clipsToBounds = true
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
