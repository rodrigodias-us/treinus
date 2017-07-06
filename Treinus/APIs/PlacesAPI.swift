//
// PlacesAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Alamofire



open class PlacesAPI: APIBase {
    /**
     Get Places
     
     - parameter location: (query) Lat,Long (optional)
     - parameter radius: (query) in meters (optional)
     - parameter types: (query) types (optional)
     - parameter name: (query) description (optional)
     - parameter key: (query) description (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func searchByLocation(location: String? = nil, radius: String? = nil, types: String? = nil, name: String? = nil, key: String? = nil, completion: @escaping ((_ data: ResponseApiMaps?,_ error: Error?) -> Void)) {
        searchByLocationWithRequestBuilder(location: location, radius: radius, types: types, name: name, key: key).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Get Places
     - GET /place/nearbysearch/json
     - Get Places
     - examples: [{contentType=application/json, example={
  "results" : [ {
    "types" : [ "Gym" ],
    "scope" : "GOOGLE",
    "rating" : 4.2,
    "name" : "TopFit",
    "geometry" : {
      "location" : {
        "lng" : "151.194217",
        "lat" : "-33.86879"
      }
    },
    "vicinity" : "Avenida José Faria da Rocha, 3208, Contagem",
    "id" : "21a0b251c9b8392186142c798263e289fe45b4aa",
    "photos" : [ {
      "photo_reference" : "CmRaAAAAX7hSMJyCGUrt2csn5SXzPBwA7PMoT77eKNZxctHatk7qBJVqVJdGjB8NZZ-0Ww58BcPtF3uLCV3wLi1wzPPOBck4qWIJ28oruTCpe4Gf9hfyTuktcokaFOyNpjSCk9zvEhCKoPP0qkzYQx8Hj-DCZCNKGhQU0zfPh1ZQRlQO4VKqY1vUYGlNzQ",
      "width" : 200,
      "height" : 200
    } ],
    "place_id" : "ChIJyWEHuEmuEmsRm9hTkapTCrk"
  } ]
}}]
     
     - parameter location: (query) Lat,Long (optional)
     - parameter radius: (query) in meters (optional)
     - parameter types: (query) types (optional)
     - parameter name: (query) description (optional)
     - parameter key: (query) description (optional)

     - returns: RequestBuilder<ResponseApiMaps> 
     */
    open class func searchByLocationWithRequestBuilder(location: String? = nil, radius: String? = nil, types: String? = nil, name: String? = nil, key: String? = nil) -> RequestBuilder<ResponseApiMaps> {
        let path = "/place/nearbysearch/json"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "location": location, 
            "radius": radius, 
            "types": types, 
            "name": name, 
            "key": key
        ])
        

        let requestBuilder: RequestBuilder<ResponseApiMaps>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}