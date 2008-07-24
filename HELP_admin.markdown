Header Authorize creates alterations of the Login System to accept Header information for authorization. This allows you to use a central authentication system for multiple applications.

An @authenticate_with_header@ method is added as a before_filter on the ApplicationController. @authenticate_with_header@ will look for a header named @user_email@ and will allow or disallow based on a user in Radiant having the given email address.

This requires that you manage your user accounts so that all active users have valid email addresses listed in the Radiant database.

Built by Saturn Flyer http://www.saturnflyer.com