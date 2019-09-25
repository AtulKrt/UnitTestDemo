//
//  ListViewController.swift
//  UnitTestDemo
//
//  Created by Atul Kumar Tiwari-iOS on 22/06/19.
//  Copyright © 2019 Tokopedia. All rights reserved.
//

import Foundation

class HTTPClient {
	static let shared = HTTPClient()
	
	private let session = URLSession.shared
	
	private init() {
		
	}
	
	// MARK:- Public Methods
	func get(url: String, callback: @escaping (_ data: Data?, _ error: Error?)->Void ) {
		guard let link = URL(string: url) else {
			let error = NSError(domain: "URL Error", code: 1, userInfo: nil)
			callback(nil, error)
			return
		}
		let request = URLRequest(url: link)
		let task = session.dataTask(with: request) {(data, response, error) in
			callback(data, error)
		}
		task.resume()
	}
}
