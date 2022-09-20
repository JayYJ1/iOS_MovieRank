//
//  BookTicketController.swift
//  MovieJYJ
//
//  Created by 소프트웨어컴퓨터 on 2022/06/08.
//

import UIKit
import SafariServices
class BookTicketController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func gotoCGV(_ sender: UIButton) {
          
        let cgvUrl = NSURL(string: "https://www.cgv.co.kr/")
        let cgvSafariView: SFSafariViewController = SFSafariViewController(url: cgvUrl as! URL)
             self.present(cgvSafariView, animated: true, completion: nil)
    }
    @IBAction func gotoMega(_ sender: UIButton) {
        let megaUrl = NSURL(string: "https://www.megabox.co.kr/")
        let megaSafariView: SFSafariViewController = SFSafariViewController(url: megaUrl as! URL)
             self.present(megaSafariView, animated: true, completion: nil)
    }
    
    @IBAction func gotoLotte(_ sender: UIButton) {
        let lotteUrl = NSURL(string: "https://www.lottecinema.co.kr/NLCHS")
        let lotteSafariView: SFSafariViewController = SFSafariViewController(url: lotteUrl as! URL)
             self.present(lotteSafariView, animated: true, completion: nil)
    }

}
