//
//  SelectedTeamAndSource.swift
//  FootballNews
//
//  Created by Kanti Krishnan on 11/8/15.
//  Copyright © 2015 Ram. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Team{

    var teamName:String = ""
    var sourceName:String = ""
    var sourceURL : String = ""
    open static var selectedSource:String=""
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    func convertMatchingEntityToTeamAndSourceEntity(_ matchingEntity:NSManagedObject) -> Team
    {
        let teamAndSource:Team = Team()
        print("ManageTeamsViewController.convertMatchingEntityToTeamAndSourceEntity")
        teamAndSource.sourceURL = (matchingEntity.value(forKey: "sourceURL") as? String)!
        teamAndSource.sourceName = (matchingEntity.value(forKey: "urlName") as? String)!
        teamAndSource.teamName = (matchingEntity.value(forKey: "teamName") as! String)
        
        return teamAndSource
        
    }

    func deleteEntity(_ sourceURL:String) ->Bool
    {
        var isDataDeleted = false
        if(!getStoredObjects(sourceURL).isEmpty)
        {
            print("Data Exists -> proceeding to Delete")
            let myEntity = NSEntityDescription.entity(forEntityName: "TeamAndSource",in: managedObjectContext)
            //Code to delete the EntityObject goes here
            let request = NSFetchRequest <TeamAndSource>(entityName:"TeamAndSource")
            request.entity = myEntity
            let pred = NSPredicate(format:"(sourceURL = %@)",sourceURL)
            request.predicate = pred
            
            do{
                let objects = try managedObjectContext.fetch(request)
                let results = objects
                if results.count > 0
                {
                    let matchingRecord = results[0] as NSManagedObject
                    managedObjectContext.delete(matchingRecord)
                    isDataDeleted = true
                    try managedObjectContext.save()
                }
            }
            catch
            {
                isDataDeleted = false
            }
        }
        else
        {
            isDataDeleted = false
        }
        
        return isDataDeleted
    }
    

    func saveData(_ teamName:String, sourceName:String, sourceURL:String) ->Bool
    {
        var isDataSaved = false;
        
        print("Inside ManageTeamsViewController.saveData")
        if(teamName.isEmpty)
        {
            print("teamName is empty")
            return isDataSaved
        }
        if(sourceName.isEmpty)
        {
            print("sourceName is empty")
            return isDataSaved
        }
        if(sourceURL.isEmpty){
            print("sourceURL is empty")
            return isDataSaved
        }
        //Check if sourceURL is already Existing
        //If yes, return false
        
        if(!Team().getStoredObjects(sourceURL).isEmpty)
        {
            return isDataSaved
        }
        
        //Else, proceed to save.
        let myEntity =  NSEntityDescription.entity(forEntityName: "TeamAndSource",in: managedObjectContext)
        let TandS = TeamAndSource(entity:myEntity!,insertInto: managedObjectContext)
        TandS.urlName = sourceName
        TandS.sourceURL = sourceURL
        TandS.teamName = teamName
        
        do{
            try managedObjectContext.save()
            print("New Team Saved Successfully")
            isDataSaved = true
        }
        catch
        {
            print("Errored while saving")
            isDataSaved = false
        }
        return isDataSaved
    }

    
    func getStoredObjects(_ sourceURL:String) -> [Team]
    {
        var matchingEntities : [NSManagedObject] = []
        var matchingTeamsAndSources:[Team] = []
        print("Inside Team.getStoredObjects ")
        let myEntity = NSEntityDescription.entity(forEntityName: "TeamAndSource",in: managedObjectContext)
        let sortDescriptor = NSSortDescriptor(key: "teamName",ascending:false)
        let sortDescriptors = [sortDescriptor]
        
        let request = NSFetchRequest<TeamAndSource>(entityName:"TeamAndSource")
        request.entity = myEntity
        request.sortDescriptors = sortDescriptors
        if(sourceURL.isEmpty || sourceURL == "")
        {
            //Do nothihng
        }
        else
        {
            let pred = NSPredicate(format:"(sourceURL = %@)",sourceURL)
            request.predicate = pred
        }
        do{
            let objects = try managedObjectContext.fetch(request)
            let results = objects
            if results.count > 0
            {
                matchingEntities = results 
                for matchingEntity in matchingEntities
                {
                    matchingTeamsAndSources.insert(Team().convertMatchingEntityToTeamAndSourceEntity(matchingEntity),at:0)
                    
                }
                return matchingTeamsAndSources
            }
        }
        catch
        {
            print("ManageTeamsViewController.getStoredObjects -> Catch Handler")
            return matchingTeamsAndSources
        }
        
        return matchingTeamsAndSources
    }
    
    

}
