//
//  ExpansionViewController.swift
//  SlideshowApp
//
//  Created by 井上真悠子 on 2020/05/08.
//  Copyright © 2020 taro.kirameki. All rights reserved.
//

import UIKit

class ExpansionViewController: UIViewController {
    @IBOutlet weak var image2: UIImageView!
    
    var namee2:String=""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let image = UIImage(named:namee2)
        image2.image = image
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
