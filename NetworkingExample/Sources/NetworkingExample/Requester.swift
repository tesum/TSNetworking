//
//  Requester.swift
//  
//
//  Created by Arseny Drozdov on 09.08.2022.
//

import Foundation
import Alamofire

// MARK: - NetworkingProtocol

public protocol NetworkingProtocol: AnyObject {
  /**
   Creates a request based on an `enum` signed under `APIProtocol`
   
   - Parameters:
     - API: enum's case
     - onSuccess: returns a serialized structure in case of a successful request, you must specify <T>
     - onFailure: returns `AFError`
  
   ```
   // Example:
   .request(.app(.locale("en"))) { (model: APIModel) in
     <your code>
   } onFailure: { error in
     <your error handler>
   }
   ```
  
   - Returns:`DataRequest` – request, for `cancel` if you need
   - Note: `<T>` – `Decolable` serialized structure
   - Note: The returned object does not have to be processed
  */
  @discardableResult
  func request<T: Decodable>(
    api: MyAPI,
    onSuccess: @escaping onSuccess<T>,
    onFailure: @escaping onFailure
  ) -> DataRequest
  
  /**
   Creates a request based on an `enum` signed under `APIProtocol`
  
   - Parameters:
     - API: enum's case
     - onSuccess: returns a serialized structure in case of a successful request, you must specify <T>
     - onFailure: returns a serialized structure in case the request fails, you must specify <F>
  
   ```
   // Example:
   .request(.app(.locale("en"))) { (model: APIModel) in
     <your code>
   } onFailure: { error in
     <your error handler>
   }
   ```
  
   - Returns:`DataRequest` – request, for `cancel` if you need
   - Note: `<T>` – `Decolable` serialized structure
   - Note: The returned object does not have to be processed
  */
  @discardableResult
  func request<T: Decodable, F: Decodable>(
    api: MyAPI,
    onSuccess: @escaping onSuccess<T>,
    onFailure: @escaping onFailureObject<F>
  ) -> DataRequest
  
  func updateConfig(baseURL: String, authToken: String)
}

// MARK: - Networking

public final class Networking {
  
  private let session: Session = {
    let trustManager = ServerTrustManager(evaluators: [
      "": DefaultTrustEvaluator()
    ])
    let monitor = Logger()

    let configuration = Session(
      rootQueue: NetworkConfig.rootQueue,
      requestQueue: NetworkConfig.requestQueue,
      serializationQueue: NetworkConfig.serializationQueue,
      serverTrustManager: trustManager,
      eventMonitors: [monitor]
    )
    return configuration
  }()
}

// MARK: Response

public typealias onSuccess<T: Decodable> = (_ model: T) -> Void
public typealias onFailure = (AFError?) -> Void
public typealias onFailureObject<F: Decodable> = (_ error: F?) -> Void

// MARK: - NetworkingProtocol

extension Networking: NetworkingProtocol {
  @discardableResult
  public func request<T: Decodable>(
    api: MyAPI,
    onSuccess: @escaping onSuccess<T>,
    onFailure: @escaping onFailure
  ) -> DataRequest {
    let request = createRequest(api: api.api).responseDecodable(of: T.self) { response in
      guard let value = response.value else {
        onFailure(response.error)
        return
      }
      onSuccess(value)
    }
    return request
  }
  
  @discardableResult
  public func request<T: Decodable, F: Decodable>(
    api: MyAPI,
    onSuccess: @escaping onSuccess<T>,
    onFailure: @escaping onFailureObject<F>
  ) -> DataRequest {
    let request = createRequest(api: api.api).responseDecodable(of: T.self) { response in
      guard let value = response.value else {
        if let data = response.data {
          do {
            onFailure(try JSONDecoder().decode(F.self, from: data))
          } catch {
            onFailure(nil)
          }
        }
        onFailure(nil)
        return
      }
      onSuccess(value)
    }
    return request
  }
  
  public func updateConfig(baseURL: String, authToken: String) {
    NetworkConfig.baseURL = baseURL
    NetworkConfig.authToken = authToken
  }
}

// MARK: - Private func

extension Networking {
  private func createRequest(api: APIProtocol) -> DataRequest {
    return session.request(
      api.urlString(),
      method: api.method,
      parameters: api.parameters,
      encoding: JSONEncoding.default,
      headers: api.headers
    ) {
      $0.timeoutInterval = api.timeout
    }
  }
}
