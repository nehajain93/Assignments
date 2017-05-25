/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 */
@isTest
private class ContactPageControllerTest  
{
	/**
	 * method to test controller features
	 */
    static testMethod void testController()
    {
    	//create test data
    	Contact con1 = new Contact(LastName = 't1', Email = 't1@gmail.com'); 
		Contact con2 = new Contact(LastName = 't2', Email = 't2@gmail.com'); 
		insert new List<Contact>{ con1, con2};
        // duplicate email in record
        Contact con = new Contact(LastName = 't', Email = 't1@gmail.com'); 
        
        Test.startTest();
		ContactPageController obj = new ContactPageController(new ApexPages.StandardController(con));
        obj.save();
        List<Apexpages.Message> msgs = ApexPages.getMessages();
		boolean b = false;
		for(Apexpages.Message msg:msgs)
		{
		    if (msg.getDetail().contains(Label.DuplicateEmailError)) 
		    	b = true;
		}
		// email error on page
		system.assert(b);
		
		// update operation
        con.Email = 't3@gmail.com';
        system.assert(obj.save().getUrl().equals('/' + con.Id));
        Test.stopTest();
    }
    
    /**
	 * method to test trigger bulk insert
	 */
    static testMethod void testBulkCheck()
    {
    	//create test data
    	List<Contact> con = new List<Contact>();
    	for(Integer counter = 0 ; counter < 201 ; counter++)
    	{
    		con.add(new Contact(LastName = 't'+counter, Email = 't' + counter + '@gmail.com'));
    	}
		insert con;
		system.assertEquals(con.size() , 201);
    }
    
    /**
	 * method to test duplicate email id check (swaping case)
	 */
    static testMethod void testDuplicateEmailCheck()
    {
    	//create test data
        Contact con1 = new Contact(LastName = 't1', Email = 't1@gmail.com'); 
		Contact con2 = new Contact(LastName = 't2', Email = 't2@gmail.com'); 
		insert new List<Contact>{con1,con2};
		con1.Email = 't2@gmail.com';
		con2.Email = 't1@gmail.com';
		update new List<Contact>{con1,con2};
		system.assertEquals(con1.Email , 't2@gmail.com');
		system.assertEquals(con2.Email , 't1@gmail.com');
    }
}