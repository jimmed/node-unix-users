require! {
    assert
    Promise: bluebird
    _: lodash
}

class UnixUsers
    (@_users = []) ->

    propMap =
        passwd: <[ account password UID GID GECOS directory shell ]>
        shadow: <[ account hash changed minAge maxAge warnPeriod inactivityPeriod expire reserved ]>

    _readFile = _.partialRight Promise.promisify(require \fs .readFile), \utf8

    _read = (type) ->
        assert propMap[type], "Type must be 'passwd' or 'shadow'"

        _readFile "/etc/#type"
        .then (file) -> file.split /\n/g
        .map (line) -> line.split /:/g
        .map _.partial _.object, propMap[type]
        .filter (user) -> user.account

    list: (force = no) ~>
        return @_users unless force or not @_users.length

        _read \passwd
        .then (users) ->
            uses-shadow = _.filter users, password: \x

            return users unless uses-shadow?.length

            _read \shadow
            .then (passwords) ->
                uses-shadow.map (user) ->
                    user.password = _.find passwords, account: user.account
                    delete user.password.account
                return users

module.exports = new UnixUsers!
