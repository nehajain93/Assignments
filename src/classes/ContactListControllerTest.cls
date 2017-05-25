/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 */ 
@isTest
private class ContactListControllerTest 
{
    /**
	 * method to test controller features
	 */
    static testMethod void testContactListController()
    {
    	//create test data
    	List<Contact> con = new List<Contact>();
    	con.add(new Contact(LastName = 'abc', Email = 't1@gmail.com'));
    	con.add(new Contact(LastName = 'pqr', Email = 't2@gmail.com'));
		con.add(new Contact(LastName = 'xyz', Email = 't3@gmail.com'));
		insert con;
		
		Test.startTest();
		// contact size
		ContactListController obj = new ContactListController();
		system.assertEquals(obj.getContacts().size(), 3);
		
		// sort
		obj.orderByField = 'LastName';
		obj.sortContacts();
		system.assertEquals(obj.orderByDir, 'DESC');
		Contact con1 = obj.getContacts().get(0);
		system.assertEquals(con1.LastName, 'xyz');
		obj.sortContacts();
		system.assertEquals(obj.orderByDir, 'ASC');
		Contact con2 = obj.getContacts().get(0);
		system.assertEquals(con2.LastName, 'abc');
		
		// Search
		obj.searchString = 'ab';
		obj.refreshContacts();
		system.assertEquals(obj.getContacts().size(), 1);
		Test.stopTest();
    }
    
    /**
	 * method to test controller features
	 */
    static testMethod void testCustomSetting()
    {
    	//create test data
    	List<Contact> con = new List<Contact>();
    	con.add(new Contact(LastName = 'abc', Email = 'abc@gmail.com'));
    	con.add(new Contact(LastName = 'abc1', Email = 'abc1@gmail.com'));
    	con.add(new Contact(LastName = 'abc2', Email = 'abc2@gmail.com'));
    	con.add(new Contact(LastName = 'abc3', Email = 'abc3@gmail.com'));
    	con.add(new Contact(LastName = 'pqr', Email = 'xyz@gmail.com'));
		con.add(new Contact(LastName = 'xyz', Email = 'pqr@gmail.com'));
		insert con;
		insert new ContactSetting__c(PageSize__c = 4, SearchAll__c = true);
		
		Test.startTest();
		ContactListController obj = new ContactListController();
		// page size from custom setting
		system.assertEquals(obj.getContacts().size(), 4);
		
		// Search in all columns
		obj.searchString = 'pq';
		obj.refreshContacts();
		system.assertEquals(obj.getContacts().size(), 2);
		Test.stopTest();
    }
    
    /**
	 * method to test controller with bulk records 
	 */
    static testMethod void testBulkCheck()
    {
    	//create test data
    	List<Contact> con = new List<Contact>();
    	for(Integer counter = 0 ; counter < 10000 ; counter++)
    	{
    		con.add(new Contact(LastName = 't'+counter, Email = 't' + counter + '@gmail.com'));
    	}
		insert con;
		
		Test.startTest();
		// No error on page with 10000 records 
		ContactListController obj = new ContactListController();
		// default page size 
		system.assertEquals(obj.getContacts().size(), 5);
		Test.stopTest();
    }
}