_it = it
modulePath = \../src/main.ls
instance = -> require modulePath

describe \unix-users, ->
    _it "can be required", ->
        instance.should.not.throw!

    _it "has a list method", ->
        users = instance!
        users.list.should.be.a.Function
