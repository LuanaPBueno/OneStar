//
//  PopUpViewController.swift
//  OneStar
//
//  Created by Nina Leonardo Pereira Brandão on 10/02/25.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var addingFriendscontrol: UITableView!
    
    var users = Person.mockPeople()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addingFriendscontrol.delegate = self
        addingFriendscontrol.dataSource = self
    }
}

extension PopUpViewController: UITableViewDelegate {
    
}

extension PopUpViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return users.count
   }
    
    
    //OQ EU PRECISO: Que deixe a interface mais bonitinha.
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath)
        let friend = users[indexPath.row]
        
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

