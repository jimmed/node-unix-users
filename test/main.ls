_it = it
modulePath = \../src/main.ls
instance = -> require modulePath

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
                done!
