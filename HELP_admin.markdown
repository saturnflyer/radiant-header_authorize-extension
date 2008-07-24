Header Authorize creates alterations of the Login System to accept Header information for authorization. This allows you to use a central authentication system for multiple applications.

An `authenticate_with_header` method is added as a before_filter on the ApplicationController. `authenticate_with_header` will look for a header specified and will allow or disallow based on a user in Radiant having the same value in the given attribute.

This requires that you manage your user accounts so that all active users have valid information listed in the Radiant database.

If you would like to change the Header or Attribute used to authorize users from a rake task you may run

	rake radiant:extensions:header_authorize:set HEADER='AUTHORIZED_USER' ATTRIBUTE='login'

Built by Saturn Flyer 

[http://www.saturnflyer.com](http://www.saturnflyer.com)