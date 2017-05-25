/**
 * Selector Class for Contact 
 */
public with sharing class ContactSelector
{
	/**
	 * Constructor
	 */
	public ContactSelector()
    {
    }
    
	/**
	 * select by email
	 */ 
	public List<Contact> selectByEmail(String field, List<String> emails, List<Contact> recordList)
	{
		return Database.query(String.format('SELECT {0} FROM Contact WHERE Email IN :emails AND Id NOT IN:recordList', 
			new List<String> 
			{
				field
			}));
	}
	/**
	 * select contacts
	 */ 
	public List<Contact> selectAllByFilter(String field, String whereClause, String orderByClause)
	{
		
		return Database.query(String.format('SELECT {0} FROM Contact WHERE {1} ORDER BY {2}',
			new List<String> 
			{
				field, whereClause, orderByClause
			}));
	}
}