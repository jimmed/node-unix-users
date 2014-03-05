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

    _read = ->
        assert propMap[it], "Type must be 'passwd' or 'shadow'"

        _readFile "/etc/#it"
        .then -> it.split /\n/g
        .map -> it.split /:/g
        .map _.partial _.object, propMap[it]
        .filter -> it.account

    list: (force = no) ~>
        return @_users unless force or not @_users.length

        _read \passwd
        .then (users) ->
            users.map (user) ->
                if user.GECOS
                    parts = user.GECOS.split \,
                    <[ name room phone contact ]>.map (name, i) ->
                        user[name] = parts[i] if parts[i]
                delete user.GECOS
                <[ UID GID ]>.map -> user[it] = parseInt user[it], 10

            uses-shadow = _.filter users, password: \x
            return users unless uses-shadow?.length

            _read \shadow
            .then (passwords) ->
                uses-shadow.map (user) ->
                    user.password = _.find passwords, account: user.account
                    <[ changed minAge maxAge warnPeriod inactivityPeriod expire ]>.map (name) ->
                        user.password[name] = parseInt user.password[name], 10 or null
                    delete user.password.hash if user.password.hash is \*
                    delete user.password.account
                return users
            .catch -> users

module.exports = new UnixUsers!
