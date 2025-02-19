//
//  SendingPicViewController.swift
//  OneStar
//
//  Created by Nina Leonardo Pereira Brandão on 12/02/25.
//

import Foundation
import UIKit
import AVFoundation
import SafariServices
import AVKit


class SendingPicViewController: UIViewController {
    
    
    @IBAction func dismissSheet(_ sender: Any){
        let messageLabel = UILabel()
        messageLabel.text = "Video sent with sucess!"
        messageLabel.textColor = .white
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.boldSystemFont(ofSize: 16)
        messageLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        messageLabel.layer.cornerRadius = 10
        messageLabel.clipsToBounds = true

        let labelWidth: CGFloat = 200
        let labelHeight: CGFloat = 50
        let screenWidth = self.view.frame.width
        let screenHeight = self.view.frame.height
        
        messageLabel.frame = CGRect(
            x: (screenWidth - labelWidth) / 2,
            y: screenHeight - 150,
            width: labelWidth,
            height: labelHeight
        )

        self.view.addSubview(messageLabel)

        UIView.animate(withDuration: 0.4, delay: 0.4, options: .curveEaseOut, animations: {
            messageLabel.alpha = 0
        }) { _ in
            messageLabel.removeFromSuperview()
            self.dismiss(animated: true, completion: nil)
        }
    }

    
    @IBOutlet weak var sendToFriend: UITableView!
    var friends = currentUser.friends
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendToFriend.delegate = self
        sendToFriend.dataSource = self
    }
    
}


extension SendingPicViewController: UITableViewDelegate {
   
}


extension SendingPicViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return friends.count
   }
    
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let friend = friends[indexPath.row]
        
        cell.imageView?.image = friend.profilePicture
        cell.imageView?.layer.cornerRadius = (cell.imageView?.frame.width ?? 50) / 2
        cell.imageView?.layer.masksToBounds = true
        
        cell.textLabel?.text = friend.profileName
        cell.textLabel?.font = UIFont(name: "Avenir-Heavy", size: 18)
        cell.textLabel?.textColor = .black

        
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        
        return cell
    }

}





