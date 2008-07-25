Header Authorize creates alterations of the Login System to accept Header information for authorization. This allows you to use a central authentication system for multiple applications.

An `authenticate_with_header` method is added as a before_filter on the ApplicationController. `authenticate_with_header` will look for a header specified and will allow or disallow based on a user in Radiant having the same value in the given attribute.

This requires that you manage your user accounts so that all active users have valid information listed in the Radiant database.

== Rake Task

If you would like to change the Header, Attribute and/or Development Account used to authorize users from a rake task you may run

	rake radiant:extensions:header_authorize:set HEADER='AUTHORIZED_USER' ATTRIBUTE='login' DEV_ACCOUNT='admin'

1. The `HEADER` variable specifies the HTTP Header that will be used for authorization.
2. The `ATTRIBUTE` variable specifies the attribute on the user account that will be used for authorization.
3. The `DEV_ACCOUNT` variable specifies the information in a user account that will be used for authorization. If you would like to disable the DEV_ACCOUNT feature, simply set the value to a blank string and restart.
	
== Configuration

Values are stored in the config database table as:

* authorization.header
* authorization.attribute
* authorization.development.account

Built by Saturn Flyer 

[http://www.saturnflyer.com](http://www.saturnflyer.com)