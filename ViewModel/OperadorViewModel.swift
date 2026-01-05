//
//  OperadorViewModel.swift
//  Property Pro
//
//  Created by Maurício Fonseca on 02/01/26.
//

import Foundation
import Combine

@MainActor
final class OperadorViewModel: ObservableObject{
    
    private let operadorRepository: OperadorRepository
    
    @Published var operadores: [Operador] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    init(repository: OperadorRepository = OperadorRepository()) {
        self.operadorRepository = repository
    }
    
    convenience init() {
        self.init(repository: OperadorRepository())
    }
}

extension OperadorViewModel{
    
    func fetchOperadores(){
        Task{
            do{
                isLoading = true
                operadores = try await operadorRepository.findByNome(by: searchText)
                isLoading = false
            } catch{
                isLoading = false
                errorMessage = error.localizedDescription
            }
        }
    }
}

extension OperadorViewModel{
    
    func onSearchTextChange(_ text: String){
        searchText = text
        fetchOperadores()
    }
}

extension OperadorViewModel {

    func addOperador(nome: String) {
        let operador = Operador(nome: nome)

        operadorRepository.addOperador(operador) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.fetchOperadores()
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

extension OperadorViewModel {

    func updateOperador(_ operador: Operador) {
        operadorRepository.updateOperador(operador) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.fetchOperadores()
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

extension OperadorViewModel {

    func deleteOperador(_ operador: Operador) {
        guard let id = operador.id else { return }

        operadorRepository.deleteOperador(id: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.operadores.removeAll { $0.id == id }
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
