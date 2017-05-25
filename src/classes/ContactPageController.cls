/**
 * Controller for ContactPage
 */
public with sharing class ContactPageController 
{
	public Contact con {get; set;}
	
	/**
     * Constructor 
     */
    public ContactPageController(ApexPages.StandardController controller) 
    {
    	con = (Contact)controller.getRecord();
    }
    
    /**
     * Save method to insert or update contact records 
     */
    public PageReference save()
    {
    	try
    	{
    		// DML operation
    		upsert con; 
    	}
    	catch(Exception ex)
    	{
    		ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, Label.ExecptionError + ex.getMessage()));
    	}
    	if(String.isNotEmpty(con.Id))
    	{
    		// Redirect to contact detail page
	    	PageReference pageRef = new PageReference('/' + con.Id);
			pageRef.setRedirect(true);
			return pageRef;
    	}
    	return null;
    }
}