//
//  ModuleAssembly.swift
//  
//
//  Created by Arseny Drozdov on 09.08.2022.
//

import Swinject

public final class ModuleAssembly: Swinject.Assembly {
  public func assemble(container: Container) {
    container.register(NetworkingProtocol.self) { _ in
      return Networking()
    }.inObjectScope(.container)
  }
}
