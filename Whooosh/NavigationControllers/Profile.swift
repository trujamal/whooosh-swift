//
//  Profile.swift
//  Whooosh
//
//  Created by Jamal Rasool on 2/22/19.
//  Copyright © 2019 Jamal Rasool. All rights reserved.
//

import UIKit

class profileController: UIViewController {

    @IBOutlet weak var containerViewStatic: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true


    }
    
    @IBAction func EditProfilePage(_ sender: Any) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        title = "Profile"
        //To change Navigation Bar Background Color
        UINavigationBar.appearance().barTintColor = healthyColor
        //To change Back button title & icon color
        UINavigationBar.appearance().tintColor = UIColor.white
        //To change Navigation Bar Title Color
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().barTintColor = healthyColor
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
    
    
}

class ProfileHeader: UITableViewCell {
    
    
}

class AccountHeader: UITableViewCell {
    
    
}

