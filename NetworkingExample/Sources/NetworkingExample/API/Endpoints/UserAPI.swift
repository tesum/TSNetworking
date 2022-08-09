//
//  UserAPI.swift
//  
//
//  Created by Arseny Drozdov on 09.08.2022.
//

import Alamofire

public enum UserAPI: APIProtocol {
  case profile
  case editProfile(parameters: Parameters)
  case deleteProfile
  
  public var path: String {
    switch self {
    case .profile, .editProfile, .deleteProfile:
      return "/profile"
    }
  }
  
  public var method: HTTPMethod {
    switch self {
    case .profile:
      return .get
    case .editProfile:
      return .patch
    case .deleteProfile:
      return .delete
    }
  }
  
  public var parameters: Parameters? {
    switch self {
    case .editProfile(let parameters):
      return parameters
    default:
      return nil
    }
  }
}
