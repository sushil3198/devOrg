/*****************************************************************
* ClassName : assetController
* Author : Sushil Sharma
* createdDate : 01 June, 2022
* Description : Controller class for Global asset to fetch information based on Profiles and users
* Test Class : No test class as of Now
* LastModifiedDate : 28-06-2022
* LastModifiedBy : Sushil Sharma
******************************************************************/
public class assetController {   
    @AuraEnabled
    public static AssetWrapper returnResult(String value){
        System.debug('Value----> ' + value);
        AssetWrapper wrp = new AssetWrapper(value);
        return wrp;
    }
    
    @AuraEnabled
    public static List<ApexClass> permissionManipulation(String profileId){
        System.debug('received Id -----> ' + profileId);
        PermissionSet ps = [Select Id from PermissionSet WHERE Profile.Id = :profileId LIMIT 1];
        List<ApexClass> classList = [SELECT Name
                                     FROM ApexClass 
                                     WHERE Id IN (SELECT SetupEntityId 
                                                  FROM SetupEntityAccess 
                                                  WHERE ParentId = :ps.Id 
                                                  AND SetupEntityType = 'ApexClass') 
                                     ORDER BY Name
                                    ];
        return classList;
    }
    
    /*Method to fetch sObject CRUD permission for a specific Profile*/
    @AuraEnabled
    public static List<ObjectPermissions> sObjectPermission(String profileId){
        List<ObjectPermissions> ops = [SELECT sObjectType, 
                                       PermissionsCreate,
                                       PermissionsRead,
                                       PermissionsEdit, 
                                       PermissionsDelete, 
                                       PermissionsModifyAllRecords, 
                                       PermissionsViewAllRecords 
                                       FROM ObjectPermissions 
                                       WHERE ParentId IN ( SELECT Id 
                                                          FROM permissionset 
                                                          WHERE PermissionSet.Profile.Id = :profileId )
                                      ];
        return ops;
    }
    
    /*Method to fetch List of Custom Permission Sets assigned to a user*/
    @AuraEnabled
    public static List<PermissionSetAssignment> getUserPermissionSets(String userId){
        System.debug('Data-------> ' + userId);
        return [Select Id, PermissionSet.Name, Assignee.Name, 
                PermissionSetGroup.DeveloperName 
                From PermissionSetAssignment 
                WHERE AssigneeId = :userId
                AND PermissionSet.isCustom = True
               ];
    }
    
    /*Method to fetch Custom Permissions assigned to a specific Permission Set*/
    @AuraEnabled
    public static List<CustomPermission> fetchCustomPermission(String permissionSetId){
        List<SetupEntityAccess> seaList = [Select SetupEntityId from SetupEntityAccess WHERE ParentId = :permissionSetId];
        
        System.debug('Debug-----> ' + seaList);
        /*
System.debug('Debug-----> ' + sea.Id);
Id seaId = sea.SetupEntityId;
System.debug('Debug-----> ' + seaId);
List<CustomPermission> customPermList = [Select id, DeveloperName from CustomPermission WHERE Id = :seaId];
return customPermList;
*/
        Set<Id> seaIdSet = new Set<Id>();
        for(SetupEntityAccess sea : seaList){
            seaIdSet.add(sea.SetupEntityId);
        }
        System.debug('Debug-----> ' + seaIdSet);
        System.debug('Debug-----> ' + seaIdSet.size());
        List<CustomPermission> customPermList = [Select id, DeveloperName from CustomPermission WHERE Id = :seaIdSet];
        System.debug('Debug-----> ' + customPermList);
        return customPermList;
    }
    
    
    @AuraEnabled
    public static List<ObjectPermissions> sObjectPermissionFLS(String profileId){
        List<ObjectPermissions> ops = [SELECT sObjectType, 
                                       PermissionsCreate,
                                       PermissionsRead,
                                       PermissionsEdit, 
                                       PermissionsDelete, 
                                       PermissionsModifyAllRecords, 
                                       PermissionsViewAllRecords 
                                       FROM ObjectPermissions 
                                       WHERE ParentId IN ( SELECT Id 
                                                          FROM permissionset 
                                                          WHERE PermissionSet.Profile.Id = :profileId )
                                       AND PermissionsRead = true 
                                      ];
        return ops;
    }
    /*Method to fetch Object wise FLS*/
    @AuraEnabled
    public static List<FieldPermissions> fetchObjectFLS(String profileId, String objectName){
        System.debug(profileId + ' --- YO --- ' + objectName);
        return [Select Field, Id, PermissionsEdit, PermissionsRead, SObjectType 
                From FieldPermissions 
                WHERE SobjectType = :objectName 
                AND ParentId IN (SELECT id FROM permissionSet 
                                 WHERE PermissionSet.ProfileId = :profileId)
               ];
    }
    
    /*Schema Methods*/
    @AuraEnabled
    public static void testMyMethod(String objectName){
        List<String> objList = new List<String>();
        objList.add(objectName);
        List<Schema.DescribeSObjectResult> metaList = Schema.describeSObjects(objList);
        System.debug(metaList);
        for(describeSobjectResult res : metaList){
            System.debug('yo-> ' + res);
        }
        
        Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get('Account').getDescribe().fields.getMap();
        System.debug(fieldMap);
        
         for(Schema.SObjectField f : fieldMap.values()){
            System.debug(f);
        } 
        boolean objMap = Schema.getGlobalDescribe().get('Account').getDescribe().isAccessible();
        System.debug(objMap);
    }
    /***********************************************************
Wrapper Class
************************************************************/
    
    public Class AssetWrapper{
        @AuraEnabled
        public List<Profile> profileList {get; set;}
        @AuraEnabled
        public List<User> userList {get; set; }
        @AuraEnabled
        public List<PermissionSet> permList {get; set; }
        
        public assetWrapper(String val){
            if(val == 'Profile')
                profileList = [Select Id, Name from Profile ORDER BY Name LIMIT 2000];
            else if (val == 'User'){
                userList = [Select Id, UserName from User];
            }
            else if(val == 'Permission_Set'){
                permList = [Select Id, Name from PermissionSet WHERE isCustom = true];
            }
        }
    }
}