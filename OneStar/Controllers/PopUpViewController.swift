//
//  PopUpViewController.swift
//  OneStar
//
//  Created by Nina Leonardo Pereira Brandão on 10/02/25.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var addingFriendscontrol: UITableView!
    
    weak var delegate: PopUpViewControllerDelegate?
    
    var users = Person.mockPeople()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addingFriendscontrol.delegate = self
        addingFriendscontrol.dataSource = self
    }
    
    func addFriendAndReloadData(friend: Person) {
            // Atualiza a lista de usuários após adicionar um amigo
            users = users.filter { $0.id != friend.id } // Remover o amigo adicionado da lista
            currentUser.add(friend: friend)
            addingFriendscontrol.reloadData() // Recarrega a tabela
            delegate?.reloadChatData()
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatTableViewCell
            
            let friend = users[indexPath.row]
            
            cell.setup(friend: friend, id: indexPath.row) {
                self.addFriendAndReloadData(friend: friend)
            }
            
            return cell
        }
}


protocol PopUpViewControllerDelegate: AnyObject {
    func reloadChatData()
    
}
