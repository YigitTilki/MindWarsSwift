//
//  BaseService.swift
//  MindWars
//
//  Created by Yiğit Tilki on 8.01.2025.
//

import Foundation
import FirebaseFirestore

@MainActor
class BaseViewModel {
    let db = Firestore.firestore()
    @Published var isLoading: Bool = false
    
    
}

extension BaseViewModel {
    func performLoadingTask(_ task: @escaping () async throws -> Void) async {
          guard !isLoading else { return }
          isLoading = true
          defer { isLoading = false }
          
          do {
              print(task)
              try await task()
          } catch {
              print("🔥Error: \(error)")
          }
      }
  }
