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
//        addPersonButton.first!.action = #selector(showPopUp)
//        addPersonButton.first!.target = self
        NotificationCenter.default.addObserver(self, selector: #selector(updateFriends), name: NSNotification.Name("FriendsUpdated"), object: nil)
        
        
    }

    @objc func updateFriends() {
        friends = currentUser.friends // Atualiza a lista de amigos
        chatControllerView.reloadData() // Atualiza a interface
    }

  

    func playVideo() {
        let customVideoVC = CustomVideoViewController()
        present(customVideoVC, animated: true, completion: nil)
    }

    
    @objc func showPopUp() {
        let popUpVC = PopUpViewController() // Aqui criamos a instância do PopUpViewController.
        
        popUpVC.modalPresentationStyle = .overCurrentContext  // Para o pop-up aparecer sobre o atual contexto
        popUpVC.modalTransitionStyle = .crossDissolve  // Para uma transição suave
        
        present(popUpVC, animated: true, completion: nil) // Apresentando o PopUp
    }
}

extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let friend = friends[indexPath.row]
            
            // Verifica se a pessoa recebeu uma foto
            if friend.receivedPhoto {
                playVideo()
            }
        }
}


extension ChatViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
           return 1 //1 sessão, que é a sessão que tem os amigos mock
       }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return friends.count //num de amigos
   }
    
    
    //OQ EU PRECISO: Que deixe a interface mais bonitinha.
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath)
        let friend = friends[indexPath.row]
        
        // Estilizando a imagem do perfil para ser redonda
        cell.imageView?.image = friend.profilePicture
        cell.imageView?.layer.cornerRadius = (cell.imageView?.frame.width ?? 50) / 2
        cell.imageView?.layer.masksToBounds = true
        
        // Personalizando o nome do amigo
        cell.textLabel?.text = friend.profileName
        cell.textLabel?.font = UIFont(name: "Avenir-Heavy", size: 18)
        cell.textLabel?.textColor = .black
        
        // Criando ou reutilizando o indicador de nova mensagem
        let indicatorSize: CGFloat = 12
        let newMessageIndicator = UIView(frame: CGRect(x: 0, y: 0, width: indicatorSize, height: indicatorSize))
        newMessageIndicator.backgroundColor = .green
        newMessageIndicator.layer.cornerRadius = indicatorSize / 2
        newMessageIndicator.isHidden = !friend.receivedPhoto
        
        // Usando accessoryView para evitar múltiplas adições
        cell.accessoryView = newMessageIndicator

        // Fundo branco e sem seleção destacada
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        
        return cell
    }

}





