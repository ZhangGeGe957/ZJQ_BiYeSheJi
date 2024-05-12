//
//  ScanViewControllerTwo.swift
//  Age Mark
//
//  Created by 王璐 on 2023/6/23.
//

import UIKit

class ScanViewControllerTwo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //添加view
        let view = ScanView()
        view .initView()
        self.view.addSubview(view)
        // Do any additional setup after loading the view.
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
