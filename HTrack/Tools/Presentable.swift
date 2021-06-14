//
//  TransitionHandler.swift
//  HTrack
//
//  Created by Jedi Tones on 6/13/21.
//

import UIKit

/// Протокол, описыващий возможные варианты переходов между контроллерами
public protocol Presentable: AnyObject {
    /**
     Пушит контроллер
     
     - Parameters:
        - viewController:   Контроллер
        - animated:         Необходимость анимирования
     */
    func pushModule(with viewController: UIViewController, animated: Bool)

    /**
     Возвращается к контроллеру
     
     - Parameters:
        - viewController:   Контроллер
        - animated:         Необходимость анимирования
     */
    func popToModule(with viewController: UIViewController, animated: Bool)
    
    /**
        Заменяет стек контроллеров
     
     - Parameters:
        - viewControllers:   Контроллеры в стек
        - animated:         Необходимость анимирования
     */
    func setModules(viewControllers: [UIViewController], animated: Bool)
    
    /**
     Отображает контроллер в новом окне
     
     - Parameters:
        - viewController:   Контроллер
        - animated:         Необходимость анимирования
     */
    func presentModule(with viewController: UIViewController,
                       presentationStyle: UIModalPresentationStyle,
                       animated: Bool)
    
    /**
     Закрывает текущий контроллер
     
     - Parameter animated: Необходимость анимирования
     */
    func dismiss(_ animated: Bool, completion: (() -> Void)?)
    
    /**
     Закрывает текущий контроллер вместе с его модальными контроллерами
     
     */
    func dismissStack(animated: Bool, completion: (() -> ())?)
    
    /**
     Закрывает контроллер, предсьавленный этим контроллером
     */
    func dismissPresentedModule(animated: Bool, completion: (() -> ())?)
    
    /**
     Показывает ViewController, находящийся в TabBar контроллере и соответствующий требуемому протоколу
     */
    func showTab(withCondition condition: (UIViewController) -> Bool)
    
    /**
     Находит корневой Presentable  контроллер
     */
    func findRootPresentable() -> Presentable?
    
    /**
     Находит первый present контроллер
     */
    func getPresentedController() -> UIViewController?
    
    /**
     Находит  контроллер который отображает текущий
     */
    func getPresentingController() -> UIViewController?
}

public extension Presentable where Self: UIViewController {
    
    func pushModule(with viewController: UIViewController, animated: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            if let parentNavigationController = self?.parent as? UINavigationController {
                parentNavigationController.pushViewController(viewController, animated: animated)
            } else if let navigationController = self as? UINavigationController {
                navigationController.pushViewController(viewController, animated: animated)
            }
        }
    }
    
    func popToModule(with viewController: UIViewController, animated: Bool) {
        DispatchQueue.main.async { [weak self] in
            if let parentNavigationController = self?.parent as? UINavigationController {
                parentNavigationController.popToViewController(viewController, animated: animated)
            } else if let navigationController = self as? UINavigationController {
                navigationController.popToViewController(viewController, animated: animated)
            }
        }
    }
    
    func setModules(viewControllers: [UIViewController], animated: Bool) {
        DispatchQueue.main.async { [weak self] in
            if let parentNavigationController = self?.parent as? UINavigationController {
                parentNavigationController.setViewControllers(viewControllers, animated: animated)
            } else if let navigationController = self as? UINavigationController {
                navigationController.setViewControllers(viewControllers, animated: animated)
            }
        }
    }
    
    func dismiss(_ animated: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async { [weak self] in
            if let parentNavigationController = self?.parent as? UINavigationController,
               parentNavigationController.children.count > 1 {
                parentNavigationController.popViewController(animated: animated)
                completion?()
            } else if let presenting = self?.presentingViewController {
                presenting.dismiss(animated: animated, completion: completion)
            } else {
                self?.removeFromParent()
                self?.view.removeFromSuperview()
                completion?()
            }
        }
    }
    
    func dismissPresentedModule(animated: Bool, completion: (() -> ())?) {
        if let presentedViewController = self.presentedViewController {
            DispatchQueue.main.async {
                presentedViewController.dismiss(animated: animated, completion: completion)
            }
        }
    }
    
    func dismissStack(animated: Bool, completion: (() -> ())? = nil) {
        if let presentingViewController = self.presentingViewController {
            DispatchQueue.main.async {
                presentingViewController.dismiss(animated: animated, completion: completion)
            }
        }
    }
    
    func presentModule(with viewController: UIViewController,
                       presentationStyle: UIModalPresentationStyle,
                       animated: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            viewController.modalPresentationStyle = presentationStyle
            self?.present(viewController, animated: animated, completion: nil)
        }
    }
    
    func showTab(withCondition condition: (UIViewController) -> Bool) {
        guard let self = self as? UITabBarController else { return }
        if let appropriateViewController = self.viewControllers?.first(where: { condition(($0 as? UINavigationController)?.topViewController ?? $0) }) {
            self.selectedViewController = appropriateViewController
        }
    }
    
    func getPresentedController() -> UIViewController? {
        return self.presentedViewController
    }
    
    func getPresentingController() -> UIViewController? {
        return self.presentingViewController
    }
    
    func findRootPresentable() -> Presentable? {
        UIApplication.getRootViewController()
    }
}

