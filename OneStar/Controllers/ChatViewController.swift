//
//  ChatView.swift
//  OneStar
//
//  Created by Nina Leonardo Pereira Brandão on 10/02/25.
//

import Foundation
import UIKit

class ChatViewController: UIViewController {
    @IBOutlet var chatControllerView: UITableView!
    
    @IBOutlet var addPersonButton: [UIBarButtonItem]!
    var friends = Person.mockFriends() //Aqui eu tenho todos os meus amigos

    override func viewDidLoad() {
        super.viewDidLoad()
        chatControllerView.delegate = self
        chatControllerView.dataSource = self
//        addPersonButton.first!.action = #selector(showPopUp)
//        addPersonButton.first!.target = self
        
        
    }
    
    @objc func showPopUp() {
        let popUpVC = PopUpViewController() // Aqui criamos a instância do PopUpViewController.
        
        // Definindo o estilo de apresentação do PopUp (modal)
        popUpVC.modalPresentationStyle = .overCurrentContext  // Para o pop-up aparecer sobre o atual contexto
        popUpVC.modalTransitionStyle = .crossDissolve  // Para uma transição suave
        
        present(popUpVC, animated: true, completion: nil) // Apresentando o PopUp
    }
}

extension ChatViewController: UITableViewDelegate {
    
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
        cell.textLabel?.font = UIFont(name: "Avenir-Heavy", size: 18) // Fonte parecida com a do Snapchat
        cell.textLabel?.textColor = .black
        
        // Fundo branco e sem seleção destacada
        cell.backgroundColor = .white
        cell.selectionStyle = .none
       return cell
   }
}

