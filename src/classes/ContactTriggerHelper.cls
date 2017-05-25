/**
 * Helper class for ContactTrigger
 */
public with sharing class ContactTriggerHelper 
{
	
	/**
	 * method execute on after insert
	 */
	public static void afterInsert(List<Contact> newRecordList, Map<Id, Contact> newRecordMap)
	{
		filterValidContacts(newRecordList, newRecordMap, null, null);
	}
	
	/**
	 * method execute on after update
	 */
	public static void afterUpdate(List<Contact> newRecordList, Map<Id, Contact> newRecordMap, List<Contact> oldRecordList, Map<Id, Contact> oldRecordMap)
	{
		filterValidContacts(newRecordList, newRecordMap, oldRecordList, oldRecordMap);
	}
	
	/**
	 * method to find duplicate emails in contact
	 */
	public static void filterValidContacts(List<Contact> newRecordList, Map<Id, Contact> newRecordMap, List<Contact> oldRecordList, Map<Id, Contact> oldRecordMap)
	{
		List<String> newConEmails = new List<String>();
		// Emails in new list
		for(Contact con : newRecordList) 
		{
			if(String.isNotEmpty(con.Email))
			{
				newConEmails.add(con.Email);
			}
		}
		ContactSelector selector = new ContactSelector();
		// Duplicate Emails in system
		set<String> duplicateEmails = new set<String>();
		for(Contact con : selector.selectByEmail('Id, Email', newConEmails, newRecordList)) 
		{
			duplicateEmails.add(con.Email);
		}
		for(Contact con : newRecordList)
		{
			// Error if email is duplicate
			if(String.isNotEmpty(con.Email) && duplicateEmails.contains(con.Email))
			{	
				con.addError(Label.DuplicateEmailError);
			}
		}
	}
}