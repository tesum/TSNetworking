//
//  Logger.swift
//  
//
//  Created by Arseny Drozdov on 09.08.2022.
//

import Foundation
import Alamofire

final class Logger: EventMonitor {
  let queue: DispatchQueue = NetworkConfig.monitorQueue
  
  func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
    log()
  }
}

// MARK: Private Func
extension Logger {
  private func log() {
    print("–––––––––––––––––––––––––––––––––––––––")
  }
}
