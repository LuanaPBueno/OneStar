//
//  PageViewController.swift
//  OneStar
//
//  Created by Nina Leonardo Pereira Brandão on 17/02/25.
//

import Foundation
import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {

    let viewControllerIDs = ["CameraView", "ChatView"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        
        if let firstViewController = viewControllerAtIndex(1) { // ChatView está no índice 1
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
        self.delegate = self
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = indexOfViewController(viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        return viewControllerAtIndex(previousIndex)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = indexOfViewController(viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < viewControllerIDs.count else {
            return nil
        }
        
        return viewControllerAtIndex(nextIndex)
    }

    func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        
        // Verifica se o índice é válido
        guard index >= 0 && index < viewControllerIDs.count else {
            return nil
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerIDs[index])
        
        return viewController
    }

    func indexOfViewController(_ viewController: UIViewController) -> Int? {
        
        guard let identifier = viewController.restorationIdentifier else {
            return nil
        }
        
        return viewControllerIDs.firstIndex(of: identifier)
    }
}

extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed, let currentViewController = pageViewController.viewControllers?.first {
            if currentViewController.restorationIdentifier == "ChatView" {
                for gesture in pageViewController.gestureRecognizers {
                    if let panGesture = gesture as? UIPanGestureRecognizer {
                        panGesture.isEnabled = false
                    }
                }
            } else {
                for gesture in pageViewController.gestureRecognizers {
                    if let panGesture = gesture as? UIPanGestureRecognizer {
                        panGesture.isEnabled = true
                    }
                }
            }
        }
    }
}
