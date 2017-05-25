/**
 * Custom setting for Contact 
 */
public with sharing class ContactSetting 
{
	// Custom setting instance
    private static ContactSetting__c configSettingsData = ContactSetting__c.getInstance();

	/**
	 * Page size for ContactList page 
	 */
    public static Integer getPageSize()
    {
        if(configSettingsData.PageSize__c != null)
            return (Integer)configSettingsData.PageSize__c;
		else
        	return 5;
    }
    
    /**
	 * searchfilter control for ContactList page 
	 */
    public static boolean getSearchAll()
    {
    	return configSettingsData.SearchAll__c;
    }
}