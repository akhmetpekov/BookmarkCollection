//
//  LinkManager.swift
//  BookmarkCollection
//
//  Created by Erik on 09.10.2023.
//

import Foundation
import CoreData
import UIKit


class LinkManager {
    static let shared = LinkManager()
    
    private var links: [Link] = []
    
    func getLinks() -> [Link]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
            
        let fetchRequest: NSFetchRequest<Link> = Link.fetchRequest()
        do {
            links = try context.fetch(fetchRequest)
            return links
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func addLink(title: String, url: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        NotificationCenter.default.post(name: NSNotification.Name("NewBookmarkAdded"), object: nil)
        let entity = NSEntityDescription.entity(forEntityName: "Link", in: context)
        let linkObject = NSManagedObject(entity: entity!, insertInto: context) as! Link
        linkObject.title = title
        linkObject.url = url
            
        do {
            try context.save()
            links = getLinks()
            print("Saved")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteLink(at index: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
            
        let entity = links[index]
        do {
            context.delete(entity)
            try context.save()
            links = getLinks()
            print("deleted")
        } catch {
            print(error.localizedDescription)
        }
    }
}
