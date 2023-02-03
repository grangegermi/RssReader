//
//  modelXml.swift
//  Rss reader
//
//  Created by Даша Волошина on 31.01.23.
//

import Foundation

class FeedParses: NSObject, XMLParserDelegate {
    
    weak var viewController: ViewController?
    
    var persistentContainer = NewsCoreData.shared
    
    var itemRss:[News] = []   {
        didSet {
            DispatchQueue.main.async {
                self.viewController?.tableView.reloadData()
            }
        }
    }
    
    var currentElement = ""
    var currentTitle = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    var currentLink = "" {
        didSet {
            currentLink = currentLink.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    var currentPubDate = "" {
        didSet {
            currentPubDate = currentPubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    var currentImage = "" {
        didSet {
            currentImage = currentImage.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    var currentDescription = "" {
        didSet {
            currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var parserCompletionHandler: (([News]) -> Void)?
    
    func createRequest (completionHandler: (([News]) -> Void)?) {
        
        self.parserCompletionHandler = completionHandler
        
        var url = URL(string: "https://lenta.ru/rss")
        
        guard let url  =  url else {return}
        var request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, error, _ in
            guard let error = error else {return}
            guard let data = data else {return}
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        task.resume()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        if currentElement == "item" {
            
            currentTitle = ""
            currentDescription = ""
            currentLink = ""
            currentPubDate = ""
            currentImage = ""
        }
        
        if currentElement == "enclosure" {
            if let urlString = attributeDict["url"] {
                currentImage += urlString
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        switch currentElement {
        case "title":
            currentTitle += string
        case "description":
            currentDescription += string
        case "pubDate":
            currentPubDate += string
        case "link":
            currentLink += string
        default : break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item"{
            
            let new = News(context: persistentContainer.context)
            new.title = currentTitle
            new.image = currentImage
            new.link = currentLink
            new.date =  currentPubDate
            new.descriptions = currentDescription
            itemRss.append(new)
            persistentContainer.saveContext()
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(itemRss)
        
    }
}
