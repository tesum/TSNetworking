//
//  API.swift
//  
//
//  Created by Arseny Drozdov on 09.08.2022.
//

import Alamofire

// Description all categories of your api
public enum MyAPI {
  case app(_ api: AppAPI)
  case user(_ api: UserAPI)
  
  var api: APIProtocol {
    switch self {
    case .app(let api):
      return api
    case .user(let api):
      return api
    }
  }
}
