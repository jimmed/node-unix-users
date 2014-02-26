# Unix Users

This is a promisified library for managing and authorizing users (and groups) in Ubuntu Server.

## API

The API can be initialised using `require`:

    var Users = require('unix-users');

### Users.list([*bool* force])

This returns a Promise to list all of the users in the system. The result of this will be cached, unless `force` is truthy.

### Users.authenticate(*string* username, *string* password)

This returns a Promise to authenticate the user based on their `username` and `password`.
