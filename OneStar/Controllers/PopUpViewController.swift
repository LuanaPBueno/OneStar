//
//  PopUpViewController.swift
//  OneStar
//
//  Created by Nina Leonardo Pereira Brandão on 10/02/25.
//

import UIKit

class PopUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var addingFriendscontrol: UITableView!
    
    weak var delegate: PopUpViewControllerDelegate?
    
    var users = Person.mockPeople() // Lista completa de usuários
    var filteredUsers: [Person] = [] // Lista filtrada de usuários
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurar a searchBar
        searchBar.delegate = self
        
        // Configurar a tableView
        addingFriendscontrol.delegate = self
        addingFriendscontrol.dataSource = self
        
        // Inicializar a lista filtrada com todos os usuários
        filteredUsers = users
    }
    
    func addFriendAndReloadData(friend: Person) {
        // Atualiza a lista de usuários após adicionar um amigo
        users = users.filter { $0.id != friend.id } // Remover o amigo adicionado da lista
        filteredUsers = filteredUsers.filter { $0.id != friend.id } // Remover da lista filtrada também
        addingFriendscontrol.reloadData() // Recarrega a tabela
        delegate?.reloadChatData()
    }
}

// MARK: - UITextFieldDelegate
extension PopUpViewController {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Captura o texto atual da searchBar
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // Filtra a lista de usuários com base no texto da searchBar
        if newText.isEmpty {
            // Se a searchBar estiver vazia, mostrar todos os usuários
            filteredUsers = users
        } else {
            // Filtrar os usuários cujo nome começa exatamente com o texto da searchBar (case insensitive)
            filteredUsers = users.filter { $0.profileName.lowercased().hasPrefix(newText.lowercased()) }
        }
        
        // Recarregar a tabela com os dados filtrados
        addingFriendscontrol.reloadData()
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Esconder o teclado quando o botão de return for clicado
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - UITableViewDelegate
extension PopUpViewController: UITableViewDelegate {
    // Implemente métodos do UITableViewDelegate, se necessário
}

// MARK: - UITableViewDataSource
extension PopUpViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUsers.count // Usar a lista filtrada
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatTableViewCell
        
        let friend = filteredUsers[indexPath.row] // Usar a lista filtrada
        
        cell.setup(friend: friend, id: indexPath.row) {
            self.addFriendAndReloadData(friend: friend)
        }
        
        return cell
    }
}

// MARK: - Protocolo
protocol PopUpViewControllerDelegate: AnyObject {
    func reloadChatData()
}
