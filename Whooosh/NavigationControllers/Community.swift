//
//  SecondViewController.swift
//  Whooosh
//
//  Created by Jamal Rasool on 2/20/19.
//  Copyright © 2019 Jamal Rasool. All rights reserved.
//

import UIKit

protocol SegmentedControlImageFactory {
    func background(color: UIColor) -> UIImage?
    func divider(leftColor: UIColor, rightColor: UIColor) -> UIImage?
}

extension SegmentedControlImageFactory {
    func background(color: UIColor) -> UIImage? { return nil }
    func divider(leftColor: UIColor, rightColor: UIColor) -> UIImage? { return nil }
}

struct DefaultSegmentedControlImageFactory: SegmentedControlImageFactory { }

struct UnderlinedSegmentedControlImageFactory: SegmentedControlImageFactory {
    var size = CGSize(width: 2, height: 29)
    var lineWidth: CGFloat = 2
    
    func background(color: UIColor) -> UIImage? {
        return UIImage.render(size: size) {
            color.setFill()
            UIRectFill(CGRect(x: 0, y: size.height-lineWidth, width: size.width, height: lineWidth))
        }
    }
    
    func divider(leftColor: UIColor, rightColor: UIColor) -> UIImage? {
        return UIImage.render(size: size) {
            UIColor.clear.setFill()
        }
    }
}

class communityController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        title = "Community"
        
    }
}

class communityTableView: UITableViewController {
    override func viewDidLoad() {

    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}


