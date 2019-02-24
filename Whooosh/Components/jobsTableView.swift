//
//  jobsTableView.swift
//  Whooosh
//
//  Created by Jamal Rasool on 2/22/19.
//  Copyright © 2019 Jamal Rasool. All rights reserved.
//

import UIKit

class jobsTableView: UITableViewController {
    var arrRes = [ListObject]() //Array of dictionary

    @IBOutlet var jobsTableView: UITableView!
    @IBOutlet weak var editFilter: UIBarButtonItem!
    @IBOutlet weak var mapViewSwitcher: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    @objc func handleALERT() {
        
        let alert = UIAlertController(title: "Uh oh", message: "Looks like something went wrong please try again later.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        
        self.present(alert, animated: true)
    }

    fileprivate func fetchJSON() {
        let urlString = jobsListAPI
        print(urlString)
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to get data from url:", err)
                }
                
                guard let data = data else { return }
                
                do {
                    // link in description for video on JSONDecoder
                    let decoder = JSONDecoder()
                    
                    var converterHandler = try decoder.decode(ListObject.self, from: data)
                    self.arrRes = [converterHandler]
                    
                    self.jobsTableView.reloadData()
                    
                } catch let jsonErr {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
                        self.handleALERT()
                    })
                    print("Failed to decode:", jsonErr)
                    
                    return
                }
            }
            }.resume()
        
        
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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


