# Unix Users

This is a promisified library for managing and authorizing users (and groups) in Ubuntu Server.

## API

The API can be initialised using `require`:

    var Users = require('unix-users');

### Users.list([*bool* force])

This returns a Promise to list all of the users in the system. The result of this will be cached, unless `force` is truthy.

#### User properties

Each returned user has the following properties:

 - **account**: The username, i.e. 'root'.
 - **password**: Either a string containing the password hash, or an object containing a details on the password (see below).
 - **UID**: The user's ID.
 - **GID**: The user's group ID.
 - **directory**: The path to the user's home directory.
 - **shell**: The path to the user's shell binary.
 - **name**: *(optional)* The user's full name.
 - **room**: *(optional)* The user's building name and room number.
 - **phone**: *(optional)* The user's telephone number.
 - **contact**: *(optional)* Additional contact details.

#### Password properties

If a returned user's password is stored in the shadow password file, it will be returned with a password object. This object has the following properties:

 - **hash**: *(optional)* A string representing the user's password hash.
 - **changed**: Datestamp of when the password was last changed.
 - **minAge**: The minimum age of the password in days.
 - **maxAge**: The maximum age of the password in days.
 - **warnPeriod**: The number of days before password is to expire that user is warned that his/her password must be changed.
 - **inactivityPeriod**: The number of days after password expires that account is disabled.
 - **expire**: Datestamp of when the password will (or has) expire(d). 

### Users.map(callback)

`.map`, along with every other method in the lodash Collections library is proxied via a Promise. For example:

    Users.map(function(user) {
        console.log('Found user:', user.account);
    });

This is equivalent to

    Users.list()
    .then(function(users) {
        return _.map(users, function(user) {
            console.log('Found user:', user.account);
        });
    });

### Users.authenticate(*string* username, *string* password)

**N.B.** This is not yet implemented.

This returns a Promise to authenticate the user based on their `username` and `password`.
