//
//  Dependencies.swift
//  ApLife
//
//  Created by Alexander Ivlev on 22/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import DITranquillity
import Core

class Dependencies {
    var application: Application {
        return container.resolve()
    }
    
    private let container = DIContainer()
    
    init() {
        DISetting.Defaults.injectToSubviews = false
        DISetting.Defaults.lifeTime = .prototype
        DISetting.Log.level = .verbose
        DISetting.Log.fun = Dependencies.log
        
        container.append(framework: AppFramework.self)
        
        #if DEBUG
        if !container.validate(checkGraphCycles: false) {
            fatalError("DI graph validation failed")
        }
        #endif
    }
    
    private static func log(level: DILogLevel, msg: String) {
        print("[\(level)]: \(msg)")
    }
    
}

private class AppFramework: DIFramework {
    static func load(container: DIContainer) {
        container.register(Application.init)
            .lifetime(.perRun(.strong))
        
        container.register(AppRouter.init)
            .as(IRouter.self)
            .lifetime(.objectGraph)
    }
}
