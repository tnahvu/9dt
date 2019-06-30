//
//  MoveManager.swift
//  9dt
//
//  Created by Tuan Vu on 6/29/19.
//  Copyright © 2019 Tuan Vu. All rights reserved.
//

import Foundation

class MovesManager {
    
    static let shared = MovesManager()
    
    private let baseUrl = "https://w0ayb2ph1k.execute-api.us-west-2.amazonaws.com/production?moves="
    private let space = " "
    private let emptyValue = ""
    init(){}
}

extension MovesManager {
    func getMoves(with moves: [Int], completionHandler: @escaping (_ moves: [Int]?, _ error: Error?) -> Void) {
        
        let movesString = moves.description.replacingOccurrences(of: space, with: emptyValue)

        let fullUrlString = baseUrl + movesString
        guard let url = URL(string: fullUrlString) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                if error != nil {
                    completionHandler(nil, error)
                }

                // Decode into moves array
                let decoder = JSONDecoder()

                guard
                    let data = data,
                    let newMoves = try? decoder.decode([Int].self, from: data)
                    else { completionHandler(nil, error); return }

                completionHandler(newMoves, nil)
            }
    
        }.resume()
    }
}

