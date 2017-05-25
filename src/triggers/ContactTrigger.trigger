/**
 * Trigger to stop insertion of duplicate emails in contacts
 */
trigger ContactTrigger on Contact (after insert, after update) 
{
	/**
	 * method execute on after insert
	 */
	if(Trigger.isInsert && Trigger.isAfter)
	{
		ContactTriggerHelper.afterInsert(Trigger.New, Trigger.NewMap);
	}
	/**
	 * method execute on after update
	 */
	if(Trigger.isUpdate && Trigger.isAfter)
	{
		ContactTriggerHelper.afterUpdate(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
	}
}