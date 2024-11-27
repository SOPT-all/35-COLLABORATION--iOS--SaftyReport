//
//  NetworkManager.swift
//  saftyReport
//
//  Created by 이지훈 on 11/18/24.
//

import Foundation

import Alamofire

class NetworkManager {
    
    func photoAPI(compleation: @escaping (Result<[GalleryPhotoList], NetworkError>) -> Void) {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else { return }
        
        let url = "\(baseURL)/api/v1/report/photo"
        
        let headers: HTTPHeaders = ["Content-Type": "application/json",
                                    "userId": "1"]
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .response { [weak self] response in
                guard let statusCode = response.response?.statusCode,
                      let data = response.data,
                      let self
                else {
                    compleation(.failure(.unknownError))
                    print("여기가 안됨 1")
                    return
                }
                
                switch response.result {
                case .success:
                    let photoList = self.decodePhoto(data: data)
                    compleation(.success(photoList))
                case .failure:
                    let error = self.handleStatusCode(statusCode, data: data)
                    print(error.localizedDescription)
                    compleation(.failure(error))
                }
                
            }
        
    }
    
    func decodePhoto(data: Data) -> [GalleryPhotoList] {
        guard let response = try? JSONDecoder().decode(GalleryResponse.self, from: data)
        else {
            return []
        }
        return response.data?.photoList ?? []
    }
    

    
}

extension NetworkManager {
    func decodeError(data: Data) -> String {
        guard let failResponse = try? JSONDecoder().decode(
            FailResponse.self,
            from: data
        ) else { return "" }
        return failResponse.status?.description ?? ""
    }
    
    func handleStatusCode(_ statusCode: Int, data: Data) -> NetworkError {
        let errorCode = decodeError(data: data)
        switch (statusCode, errorCode) {
        case (400, "00"):
            return .invalidRequest
        case (400, "01"):
            return .expressionError
        case (404, ""):
            return .invalidURL
        case (409, "00"):
            return .duplicateError
        case (500, ""):
            return .serverError
        default:
            return .unknownError
        }
    }
}
