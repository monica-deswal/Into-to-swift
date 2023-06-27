//
//  AsyncAwaitOperation.swift
//  Dispatch_operation
//
//  Created by Laxmi Ganesh on 19/04/22.
//

import Foundation

struct AsyncAwaitOperation {
    
    //Example without async await
    func fetchWeatherHistory(completion: @escaping (([Double]) -> Void)) {
        
        DispatchQueue.global().async {
            let results = (1...1000).map{_ in Double.random(in: -10...20)}
            completion(results)
        }
    }
    
    func calculateAverageTemperature(for records: [Double], completion: @escaping (Double) -> Void) {
        
        DispatchQueue.global().async {
            let total = records.reduce(0, +)
            let average = total/Double(records.count)
            completion(average)
        }
    }
    
    func upload(result: Double, completion: @escaping (String) -> Void) {
        
        DispatchQueue.global().async {
            completion("OK")
        }
    }
    
    func operateWithoutAsyncAwait() {
        fetchWeatherHistory { records in
            calculateAverageTemperature(for: records) { average in
                upload(result: average) { response in
                    print("Server response \(response)")
                }
            }
        }
    }
}

extension AsyncAwaitOperation {
    
    func fetchWeatherHistory() async -> [Double] {
        (1...1000).map {_ in Double.random(in: -10...20) }
    }
    
    func calculateAverageTemperature(for records: [Double]) async -> Double {
        let total = records.reduce(0, +)
        let average = total/Double(records.count)
        return average
    }
    
    func upload(result: Double) async -> String {
        "Ok"
    }
    
    func operateWithAsyncAwait() async {
        let records = await fetchWeatherHistory()
        let average = await calculateAverageTemperature(for: records)
        let response = await upload(result: average)
        print("Server response: \(response)")
    }
}

extension AsyncAwaitOperation {
    enum UserError: Error {
        case invalidCount, dataTooLong
    }
    
    func fetchUsers(count: Int) async throws -> [String] {
        if count > 3 {
            
            throw UserError.invalidCount
        }
        
        return Array(["Antony", "Karamo", "Tan"].prefix(count))
    }
    
    func save(users: [String]) async throws -> String {
        let savedUsers = users.joined(separator: ",")
        
        if savedUsers.count > 32 {
            throw UserError.dataTooLong
        } else {
            return "Saved \(savedUsers)"
        }
    }
    
    func updateUsers() async {
        do {
            let users = try await fetchUsers(count: 3)
            let result = try await save(users: users)
            print(result)
        } catch {
            print("Ooops")
        }
    }
}
