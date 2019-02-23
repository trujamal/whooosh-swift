//
//  Inbox.swift
//  Whooosh
//
//  Created by Jamal Rasool on 2/22/19.
//  Copyright © 2019 Jamal Rasool. All rights reserved.
//

import UIKit

class inboxController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        title = "Inbox"
        
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
