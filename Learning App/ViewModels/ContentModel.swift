//
//  ContentModel.swift
//  Learning App
//
//  Created by Dathan Felipe on 2/26/23.
//

import Foundation

class ContentModel: ObservableObject {
    
    // list of modules
    @Published var modules = [Module]()
    
    // current module
    @Published var currentModule:Module?
    var currentModuleIndex = 0
    
    var styleData:Data?
    
    init() {
        self.getLocalData()
    }
    
    // MARK: data methods
    func getLocalData() {
        
        // get url to the json file
        let jsonURL = Bundle.main.url(forResource: "data", withExtension: "json")
        
        // unwrap jsonURL
        guard let jsonURL = jsonURL else {
            return print("No json file found")
        }
        
        do {
            
            // turn the file into a data object
            let jsonData = try Data(contentsOf: jsonURL)
            
            // decode the json file into an array of modules
            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            // assign parsed modules to modules property
            self.modules = modules
        }
        
        // log the error
        catch {
            print("Couldn't parse json data")
        }
        
        // parse style data
        let styleURL = Bundle.main.url(forResource: "style", withExtension: "html")
        
        // unwrap styleURL
        guard let styleURL = styleURL else {
            return print("No html file found")
        }
        
        do {
            // read the file into a data object
            let styleData = try Data(contentsOf: styleURL)
            
            // assign parsed style data to styleData property
            self.styleData = styleData
        }
        
        catch {
            print("Couldn't parse html data")
        }
    }
    
    // MARK: module navigation methods
    func beginModule(moduleID:Int) {
        
        // find the index for this module id
        for index in 0..<modules.count {
            if modules[index].id == moduleID {
                
                // matching module found
                currentModuleIndex = index
                break
            }
        }
        
        // set current module
        currentModule = modules[currentModuleIndex]
    }
}
