//
//  NetworkConfig.swift
//  
//
//  Created by Arseny Drozdov on 09.08.2022.
//

import Foundation
import Alamofire

enum NetworkConfig {
  // if you have one stand you can init baseURL here
  static var baseURL: String = "https://myTrustedServer.com/v1.0"
  
  // if you need an authToken for identify the user
  static var authToken: String?
  
  static let rootQueue = DispatchQueue(label: "com.appname.company.af.root", qos: .userInitiated)
  static let requestQueue = DispatchQueue(label: "com.appname.company.af.request", qos: .userInitiated)
  static let serializationQueue = DispatchQueue(label: "com.appname.company.af.serializer", qos: .userInitiated)
  static let monitorQueue = DispatchQueue(label: "com.appname.company.af.monitor", qos: .userInitiated)
}
