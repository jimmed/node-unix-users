_it = it
modulePath = \../src/main.ls
instance = -> require modulePath

testUser =
    account: \nobody
    password:
        changed: 15939
        minAge: null
        maxAge: 99999
        warnPeriod: 7
        inactivityPeriod: null
        expire: null
        reserved: ''
    UID: 65534
    GID: 65534
    directory: \/nonexistent
    shell: \/bin/sh
    name: \nobody


describe \unix-users, ->

    _it "can be required", ->
        instance.should.not.throw!

    _it "has a list method", ->
        users = instance!
        users.list.should.be.a.Function

    describe \#list, ->

        _it "should return a Promise", ->
            users = instance!
            list-result = users.list!
            list-result.should.be.an.Object
            list-result.then.should.be.a.Function

        _it "should resolve to a list of users", (done) ->
            users = instance!

            users.list!
            .then (users) ->
                users.should.be.an.Array
                users.map (user) ->
                    user.should.be.an.Object
                    user.account.should.be.a.string
                    user.account.length.should.be.above 0
            .finally done

    describe \#find, ->

        _it "should return a Promise", ->
            users = instance!
            find-result = users.find \nobody .catch ->
            find-result.should.be.an.Object
            find-result.then.should.be.a.Function

        _it "should resolve to a user, called with account name", (done) ->
            users = instance!

            users.find testUser.name
            .then -> it.should.eql testUser
            .finally done

        _it "should resolve to a user, called with properties", (done) ->
            users = instance!

            users.find UID: testUser.UID
            .then -> it.should.eql testUser
            .finally done

        _it "should resolve to a user, called with predicate", (done) ->
            users = instance!

            users.find -> it.account is testUser.account
            .then -> it.should.eql testUser
            .finally done
