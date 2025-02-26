//
//  BaseViewModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 24.01.2025.
//

import Foundation

@MainActor
class BaseViewModel {
    @Published var isLoading: Bool = false
    @Published var alertItem: AlertItem?
    @Published var showAlert: Bool = false
    @Published var error: String?
    @Published var isError: Bool = false
    @Published var locale = Locale.current.identifier
    

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
