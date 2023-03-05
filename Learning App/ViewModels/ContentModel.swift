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
    
    // current lesson
    @Published var currentLesson:Lesson?
    var currentLessonIndex = 0
    
    // current lesson explanation
    @Published var lessonDescription = NSAttributedString()
    
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
    
    func beginLesson(lessonIndex:Int) {
        
        // check that the lesson index is within range of module lessons
        if let currentModule = currentModule {
            if lessonIndex < currentModule.content.lessons.count {
                currentLessonIndex = lessonIndex
            }
            
            else {
                currentLessonIndex = 0
            }
            
            // set the current lesson
            currentLesson = currentModule.content.lessons[currentLessonIndex]
            
            // set current description
            if let currentLesson = currentLesson {
                lessonDescription = addStyling(htmlString: currentLesson.explanation)
            }
        }
    }
    
    func nextLesson() {
        
        // advance the lesson index
        currentLessonIndex += 1
        
        if let currentModule = currentModule {
            
            // check if it is within range
            if currentLessonIndex < currentModule.content.lessons.count {
                
                // set the current lesson property
                currentLesson = currentModule.content.lessons[currentLessonIndex]
                
                // set current description
                if let currentLesson = currentLesson {
                    lessonDescription = addStyling(htmlString: currentLesson.explanation)
                }
            }
            
            else {
                
                // reset the lesson state
                currentLesson = nil
                currentLessonIndex = 0
            }
        }
    }
    
    func hasNextLesson() -> Bool {
        
        guard let currentModule = currentModule else {
            return false
        }
        // check if there is a next lesson
        return (currentLessonIndex + 1 < currentModule.content.lessons.count)
    }
    
    // MARK: Code Styling
    private func addStyling(htmlString:String) -> NSAttributedString {
        
        var resultString = NSAttributedString()
        var data = Data()
        
        // add styling data
        if styleData != nil {
            data.append(styleData!)
        }
        
        // add html data
        data.append(Data(htmlString.utf8))
        
        // convert to attributed string
        do {
            let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            
            resultString = attributedString
        }
        
        catch {
            print("Couldn't convert html to attributed string")
        }
        
        return resultString
    }
}
