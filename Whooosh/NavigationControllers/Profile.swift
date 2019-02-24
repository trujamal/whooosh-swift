//
//  Profile.swift
//  Whooosh
//
//  Created by Jamal Rasool on 2/22/19.
//  Copyright © 2019 Jamal Rasool. All rights reserved.
//

import UIKit

class profileController: UIViewController {

    @IBOutlet weak var navigationItemCC: UINavigationItem!
    @IBOutlet weak var containerViewStatic: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        title = "Profile"
        
        //To change Navigation Bar Background Color
        UINavigationBar.appearance().barTintColor = healthyColor
        //To change Back button title & icon color
        UINavigationBar.appearance().tintColor = UIColor.white
        //To change Navigation Bar Title Color
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: healthyColor]
        UINavigationBar.appearance().barTintColor = healthyColor

    }
    
    @IBAction func EditProfilePage(_ sender: Any) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {

        
    }
}

class ProfileManagemntController: UITableViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userJoinDate: UILabel!
    
    
    override func viewDidLoad() {
        handleCirlceImage()
    }
    
    private func handleCirlceImage() {
        profileImage.layer.masksToBounds = false

        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
}

class ProfileHeader: UITableViewCell {
    
    
}

class AccountHeader: UITableViewCell {
    
    
}

