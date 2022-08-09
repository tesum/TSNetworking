//
//  AppAPI.swift
//  
//
//  Created by Arseny Drozdov on 09.08.2022.
//

import Alamofire

public enum AppAPI: APIProtocol {
  case locale(_ locale: String)
  case functions
  
  public var path: String {
    switch self {
    case .locale(let locale):
      return "/locale/\(locale)"
    case .functions:
      return "/functions"
    }
  }
  
  public var method: HTTPMethod {
    switch self {
    case .locale(_):
      return .post
    case .functions:
      return .get
    }
  }
}
