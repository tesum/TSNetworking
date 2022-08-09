//
//  APIProtocol.swift
//  
//
//  Created by Arseny Drozdov on 09.08.2022.
//

import Foundation
import Alamofire

/**
 Description of the `URL request`  to the server

 - `path`: `required`,  –  endpoint of API's method
 - `method`: `required`,  –  HTTP method for example `get`
 - `parameters`: `optional`,  –   body of endpoint for example `"version": 5.1`
 - `headers`: `optional`,  –  custom  headers of endpoint
 - `timeout`: `optional`,  –  custom timeout for endpoint

 - Note: `headers` , `parameters` and `timeout` have standard value
*/
public protocol APIProtocol {
  var path: String { get }
  var method: HTTPMethod { get }
  var parameters: Parameters? { get }
  var headers: HTTPHeaders { get }
  var timeout: TimeInterval { get }
}

extension APIProtocol {
  public var headers: HTTPHeaders {
    var headers = [
      "Content-Type": "application/json",
    ]
    if let authToken = NetworkConfig.authToken {
      headers["AuthToken"] = authToken
    }
    
    return HTTPHeaders(headers)
  }
  
  public var parameters: Parameters? {
    return nil
  }
  
  public var timeout: TimeInterval {
    return 30.0
  }
  
  func urlString() -> String {
    return NetworkConfig.baseURL + path
  }
}
