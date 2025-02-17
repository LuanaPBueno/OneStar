//
//  PageViewController.swift
//  OneStar
//
//  Created by Nina Leonardo Pereira Brandão on 17/02/25.
//

import Foundation
import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {

    // Array com os IDs dos view controllers no storyboard
    let viewControllerIDs = ["CameraView", "ChatView"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define o dataSource
        self.dataSource = self
        
        // Configura o primeiro view controller (ChatView)
        if let firstViewController = viewControllerAtIndex(1) { // ChatView está no índice 1
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
        // Adiciona um observer para detectar mudanças no view controller atual
        self.delegate = self
    }

    // Método para retornar o view controller anterior (swipe para a direita)
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = indexOfViewController(viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // Verifica se o índice é válido
        guard previousIndex >= 0 else {
            return nil
        }
        
        return viewControllerAtIndex(previousIndex)
    }

    // Método para retornar o próximo view controller (swipe para a esquerda)
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = indexOfViewController(viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        // Verifica se o índice é válido
        guard nextIndex < viewControllerIDs.count else {
            return nil
        }
        
        return viewControllerAtIndex(nextIndex)
    }

    // Método para retornar o view controller com base no índice
    func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        
        // Verifica se o índice é válido
        guard index >= 0 && index < viewControllerIDs.count else {
            return nil
        }
        
        // Obtém o view controller do storyboard usando o ID
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerIDs[index])
        
        return viewController
    }

    // Método para obter o índice do view controller atual
    func indexOfViewController(_ viewController: UIViewController) -> Int? {
        
        // Obtém o identificador do view controller
        guard let identifier = viewController.restorationIdentifier else {
            return nil
        }
        
        // Retorna o índice correspondente no array
        return viewControllerIDs.firstIndex(of: identifier)
    }
}

// Extensão para implementar o UIPageViewControllerDelegate
extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        // Verifica se a transição foi concluída e se o view controller atual é o ChatView
        if completed, let currentViewController = pageViewController.viewControllers?.first {
            if currentViewController.restorationIdentifier == "ChatView" {
                // Desabilita o gesto de swipe para a direita
                for gesture in pageViewController.gestureRecognizers {
                    if let panGesture = gesture as? UIPanGestureRecognizer {
                        panGesture.isEnabled = false
                    }
                }
            } else {
                // Habilita o gesto de swipe para a direita
                for gesture in pageViewController.gestureRecognizers {
                    if let panGesture = gesture as? UIPanGestureRecognizer {
                        panGesture.isEnabled = true
                    }
                }
            }
        }
    }
}
