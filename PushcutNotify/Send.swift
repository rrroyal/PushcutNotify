//
//  Send.swift
//  notify
//
//  Created by royal on 02/08/2020.
//

import Foundation
import ArgumentParser

/// Sends the Pushcut notification.
struct Send: ParsableCommand {
	public static let configuration = CommandConfiguration(abstract: "Sends the Pushcut notification.")
	
	@Argument(help: "Endpoint name")
	private var endpoint: String
	
	@Argument(help: "Notification title")
	private var title: String
	
	@Argument(help: "Notification body")
	private var body: String?
	
	@Flag private var verbose: Bool
	
	func run() throws {
		guard let endpoints = UserDefaults.standard.dictionary(forKey: "Endpoints"),
			  let endpointURL: String = endpoints[endpoint] as? String,
			  let url: URL = URL(string: endpointURL) else {
			throw AppError.noEndpointURL
		}
		
		var request: URLRequest = URLRequest(url: url)
		request.httpMethod = "POST"
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		
		if (verbose) {
			print("\(request.httpMethod ?? "<no method>") \(request.url?.absoluteString ?? "<no url>")")
			for header in (request.allHTTPHeaderFields ?? [:]) {
				print("\(header.key): \(header.value)")
			}
			print("")
		}
		
		let requestBody: [String: Any] = ["title": title, "text": body ?? ""]
		if (verbose) {
			print(requestBody)
			print("")
		}
		
		guard let httpBody: Data = try? JSONSerialization.data(withJSONObject: requestBody, options: []) else {
			throw AppError.encodingError
		}
		request.httpBody = httpBody
		
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			if let data = data,
			   let dictionary: [String: Any] = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
				if let message: String = dictionary["message"] as? String {
					print(message.colorize(color: message.localizedCaseInsensitiveContains("success") ? 32 : 33))
				} else {
					print(dictionary)
				}
			}
			
			if let httpResponse = response as? HTTPURLResponse {
				if (200...302 ~= httpResponse.statusCode) {
					Send.exit()
				} else {
					Send.exit(withError: error)
				}
			} else {
				Send.exit(withError: error)
			}
			
			Send.exit()
		}
		task.resume()
	}
}
