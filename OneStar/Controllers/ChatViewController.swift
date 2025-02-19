//
//  ChatView.swift
//  OneStar
//
//  Created by Nina Leonardo Pereira Brandão on 10/02/25.
//

import Foundation
import UIKit
import AVFoundation
import SafariServices // Import necessário
import AVKit

class ChatViewController: UIViewController {
    @IBOutlet var chatControllerView: UITableView!
    @IBOutlet var addPersonButton: [UIBarButtonItem]!
    var friends = currentUser.friends 

    override func viewDidLoad() {
        super.viewDidLoad()
        chatControllerView.delegate = self
        chatControllerView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(updateFriends), name: NSNotification.Name("FriendsUpdated"), object: nil)
        
        
    }

    @objc func updateFriends() {
        friends = currentUser.friends
        chatControllerView.reloadData()
    }

  

    func playVideo() {
        let customVideoVC = CustomVideoViewController()
        present(customVideoVC, animated: true, completion: nil)
    }

    
    @objc func showPopUp() {
        let popUpVC = PopUpViewController()
        popUpVC.modalPresentationStyle = .overCurrentContext
        popUpVC.modalTransitionStyle = .crossDissolve
        
        present(popUpVC, animated: true, completion: nil)
    }
}

extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let friend = friends[indexPath.row]
            
            if friend.receivedPhoto {
                playVideo()
            }
        }
}


extension ChatViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return friends.count
   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath)
        let friend = friends[indexPath.row]
        
        cell.imageView?.image = friend.profilePicture
        cell.imageView?.layer.cornerRadius = (cell.imageView?.frame.width ?? 50) / 2
        cell.imageView?.layer.masksToBounds = true
        
        cell.textLabel?.text = friend.profileName
        cell.textLabel?.font = UIFont(name: "Avenir-Heavy", size: 18)
        cell.textLabel?.textColor = .black
        
        let indicatorSize: CGFloat = 12
        let newMessageIndicator = UIView(frame: CGRect(x: 0, y: 0, width: indicatorSize, height: indicatorSize))
        newMessageIndicator.backgroundColor = .green
        newMessageIndicator.layer.cornerRadius = indicatorSize / 2
        newMessageIndicator.isHidden = !friend.receivedPhoto
        
        cell.accessoryView = newMessageIndicator

        cell.backgroundColor = .white
        cell.selectionStyle = .none
        
        return cell
    }

}





