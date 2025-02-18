//
//  SendingPicViewController.swift
//  OneStar
//
//  Created by Nina Leonardo Pereira Brandão on 12/02/25.
//

import Foundation
import UIKit
import AVFoundation
import SafariServices // Import necessário
import AVKit


class SendingPicViewController: UIViewController {

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
        
        // Estilizando a imagem do perfil para ser redonda
        cell.imageView?.image = friend.profilePicture
        cell.imageView?.layer.cornerRadius = (cell.imageView?.frame.width ?? 50) / 2
        cell.imageView?.layer.masksToBounds = true
        
        // Personalizando o nome do amigo
        cell.textLabel?.text = friend.profileName
        cell.textLabel?.font = UIFont(name: "Avenir-Heavy", size: 18)
        cell.textLabel?.textColor = .black

        
        // Fundo branco e sem seleção destacada
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        
        return cell
    }

}





