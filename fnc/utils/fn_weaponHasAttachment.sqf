/*
	Author:
	Jan Zípek

	Description:
	Returns if specified weapon has already any attachment.

	Parameters:
		0: STRING - weapon classname

	Returns:
	BOOL - if weapon has any predefined attachments
*/

count("true" configClasses (configFile >> "cfgWeapons" >> (param [0]) >> "LinkedItems")) > 0