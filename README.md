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

**N.B.**: If `Users.list` is called without sufficient permission to read the shadow file, the users list will be returned gracefully, with `'x'` in each password field.

### Users.map(callback)

`.map`, along with every other method in the lodash Collections library is proxied via a Promise. For example:

    Users.map(function(user) {
        console.log('Found user:', user.account);
    });

This is equivalent to:

    Users.list()
    .then(function(users) {
        return _.map(users, function(user) {
            console.log('Found user:', user.account);
        });
    });

The following methods from lodash are supported:

 - Users.all → [every](http://lodash.com/docs#every)
 - Users.any → [some](http://lodash.com/docs#some)
 - Users.[at](http://lodash.com/docs#at)
 - Users.collect → [map](http://lodash.com/docs#map)
 - Users.[contains](http://lodash.com/docs#contains)
 - Users.[countBy](http://lodash.com/docs#countBy)
 - Users.detect → [find](http://lodash.com/docs#find)
 - Users.each → [forEach](http://lodash.com/docs#forEach)
 - Users.eachRight → [forEachRight](http://lodash.com/docs#forEachRight)
 - Users.[every](http://lodash.com/docs#every)
 - Users.[filter](http://lodash.com/docs#filter)
 - Users.[find](http://lodash.com/docs#find)
 - Users.[findLast](http://lodash.com/docs#findLast)
 - Users.findWhere → [find](http://lodash.com/docs#find)
 - Users.foldl → [reduce](http://lodash.com/docs#reduce)
 - Users.foldr → [reduceRight](http://lodash.com/docs#reduceRight)
 - Users.[forEach](http://lodash.com/docs#forEach)
 - Users.[forEachRight](http://lodash.com/docs#forEachRight)
 - Users.[groupBy](http://lodash.com/docs#groupBy)
 - Users.include → [contains](http://lodash.com/docs#contains)
 - Users.[indexBy](http://lodash.com/docs#indexBy)
 - Users.inject → [reduce](http://lodash.com/docs#reduce)
 - Users.[invoke](http://lodash.com/docs#invoke)
 - Users.[map](http://lodash.com/docs#map)
 - Users.[max](http://lodash.com/docs#max)
 - Users.[min](http://lodash.com/docs#min)
 - Users.[pluck](http://lodash.com/docs#pluck)
 - Users.[reduce](http://lodash.com/docs#reduce)
 - Users.[reduceRight](http://lodash.com/docs#reduceRight)
 - Users.[reject](http://lodash.com/docs#reject)
 - Users.[sample](http://lodash.com/docs#sample)
 - Users.select → [filter](http://lodash.com/docs#filter)
 - Users.[shuffle](http://lodash.com/docs#shuffle)
 - Users.[size](http://lodash.com/docs#size)
 - Users.[some](http://lodash.com/docs#some)
 - Users.[sortBy](http://lodash.com/docs#sortBy)
 - Users.[where](http://lodash.com/docs#where)

### Users.authenticate(*string* username, *string* password)

**N.B.** This is not yet implemented.

This returns a Promise to authenticate the user based on their `username` and `password`.
