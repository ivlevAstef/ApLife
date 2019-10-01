//
//  NavigationController.swift
//  UIComponents
//
//  Created by Alexander Ivlev on 22/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit
import Common

public final class NavigationController
{
    public let uiController: UINavigationController

    public var topRouter: IRouter? {
        return vcRouterContainer.lastRouter
    }

    private let vcRouterContainer = VCRouterContainer()

    public init(controller: UINavigationController) {
        self.uiController = controller
    }

    public func push(_ router: IRouter, animated: Bool = true) {
        let vc = router.rootViewController
        push(vc, animated: animated)
        vcRouterContainer.push(vc: vc, router: router)

        router.start()
    }

    public func notStartPush(_ router: IRouter, animated: Bool = true) {
           let vc = router.rootViewController
           push(vc, animated: animated)
           vcRouterContainer.push(vc: vc, router: router)
       }

    public func push(_ vc: UIViewController, animated: Bool = true) {
        if self.uiController.viewControllers.isEmpty {
            self.uiController.setViewControllers([vc], animated: animated)
        } else {
            self.uiController.pushViewController(vc, animated: animated)
        }
    }

    public func pop(animated: Bool = true) {
        if let popingVC = self.uiController.viewControllers.last {
            vcRouterContainer.pop(vc: popingVC)?.stop()
        }
        self.uiController.popViewController(animated: animated)
    }

    public func popTo(_ vc: UIViewController, animated: Bool = true) {
        var found: Bool = false
        var foundedVCs: [UIViewController] = []
        for iterVC in self.uiController.viewControllers {
            foundedVCs.append(iterVC)
            if iterVC === vc {
                found = true
                break
            }
        }

        assert(found, "Call pop to vc, but view controller not found.")
        if found {
            vcRouterContainer.pop(vcs: foundedVCs).forEach { $0.stop() }
            self.uiController.popToViewController(vc, animated: animated)
        }
    }

    public func popToRoot(animated: Bool = true) {
        let vcsWithoutRoot = Array(self.uiController.viewControllers.dropFirst())
        vcRouterContainer.pop(vcs: vcsWithoutRoot).forEach { $0.stop() }
        self.uiController.popToRootViewController(animated: animated)
    }
}

private class VCRouterContainer {
    private var vcWithRouterList: [(WeakRef<UIViewController>, Weak<IRouter>)] = []

    internal var lastRouter: IRouter? {
        removeOldRouters()
        for (_, routerRef) in vcWithRouterList.reversed() {
            if let router = routerRef.value {
                return router
            }
        }
        return nil
    }

    func push(vc: UIViewController, router: IRouter) {
        removeOldRouters()

        vcWithRouterList.append((WeakRef(vc), Weak(router)))
    }

    func pop(vc: UIViewController) -> IRouter? {
        removeOldRouters()

        let foundRouters = vcWithRouterList.compactMap { (vcRef, routerRef) -> IRouter? in
            return vcRef.value === vc ? routerRef.value : nil
        }
        assert(foundRouters.count <= 1)

        vcWithRouterList.removeAll { (vcRef, routerRef) -> Bool in
            return vcRef.value === vc
        }

        return foundRouters.first
    }

    func pop(vcs: [UIViewController]) -> [IRouter] {
        removeOldRouters()

        let foundRouters = vcWithRouterList.compactMap { (vcRef, routerRef) -> IRouter? in
            return vcs.contains(where: { $0 == vcRef.value }) ? routerRef.value : nil
        }
        assert(foundRouters.count <= vcs.count)

        vcWithRouterList.removeAll { (vcRef, routerRef) -> Bool in
            return vcs.contains(where: { $0 == vcRef.value })
        }

        return foundRouters
    }

    private func removeOldRouters() {
        for (vcRef, routerRef) in vcWithRouterList {
            if vcRef.value == nil {
                routerRef.value?.stop()
            }
        }
        // I can call separate this loops, because this function called only from main thread -> VC don't removed between two loop
        vcWithRouterList.removeAll { (vcRef, routerRef) -> Bool in
            return vcRef.value == nil || routerRef.value == nil
        }
    }
}

