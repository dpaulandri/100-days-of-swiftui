//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Paul Andri on 08/02/2022.
//

import Foundation

// ADD 'decode' METHOD AS AN 'Bundle' EXTENSION
extension Bundle {
    // CONVERT "GENERIC" DATA INTO ANOTHER "GENERIC" DATA
    // THIS METHOD WILL RETURN A "GENERIC" TYPE DATA
    func decode<T: Codable>(_ file: String) -> T {
        // TRY TO LOCATE THE FILE URL PATH FROM BUNDLE
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in Bundle!")
        }
        
        // TRY TO LOAD THE JSON DATA FROM 'url' URL PATH
        // WE USE 'Data(contentsOf: )' BECAUSE CODABLE USES 'Data' TYPE
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from Bundle!")
        }
        
        // CREATE A JSONDECODER INSTANCE
        let decoder = JSONDecoder()
        
        
        // PASS ON A DATE FORMAT TO JSONDECODER
        // STEP 1: CREATE AN INSTANCE OF 'DateFormatter'
        let dateFormatter = DateFormatter()
        
        // STEP 2: PASS ON 'dateFormat' TO THE 'dateFormatter'
        // '.dateFormat' FORMAT VALUE IS CASE-SENSITIVE!!!
        dateFormatter.dateFormat = "y-MM-dd"
        
        // STEP 3: PASS ON 'dateFormatter' AS THE FORMAT FOR JSONDECODER's 'dataDecodingStrategy'
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        
        // TRY TO DECODE THE JSON DATA FROM 'data' TO A "GENERIC" TYPE DATA
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from Bundle!")
        }
        
        // RETURN 'loaded', A "GENERIC" TYPE DATA TO THE METHOD
        return loaded
    }
}
 
