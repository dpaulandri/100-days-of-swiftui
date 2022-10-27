//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Paul Andri on 10/27/2022.
//

import Foundation

// ADD 'decode' METHOD AS AN 'Bundle' EXTENSION
extension Bundle {
	/// Convert "Generic" 'Decodable' Data into another "Generic" Data
    /// Accept a 'String' file name, returns a "Generic" Data type
    func decode<T: Decodable>(_ file: String) -> T {
		/// Try to locate file url path from Bundle
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in Bundle!")
        }
        
		/// Try to load JSON Data from 'url' Path
		/// 'Data(contentsOf: )' is used because 'Codable' uses 'Data' type
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from Bundle!")
        }
        
		/// Create a 'JSONDecoder' Instance
        let decoder = JSONDecoder()
        
        /// Try to decode 'data' (JSON Data) into a "Generic" Data type
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from Bundle!")
        }
        
		/// Return 'loaded', a "Generic" Data type, to the Method
        return loaded
    }
}
 
