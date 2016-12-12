consolePage = require('./console.coffee')
builderPage = require('./builder.coffee')

describe 'change hook', () ->
    builder = null
    console = null
    beforeEach(() ->
        builder = new builderPage('runtest', 'force')
        console = new consolePage()
    )
    it 'should create a build', () ->
        builder.go()
        builder.getBuildCount().then (lastbuild) ->
            browser.executeAsyncScript (done)->
                $.post('change_hook/base', {
                    comments:'sd',
                    project:'pyflakes'
                    repository:'git://github.com/buildbot/pyflakes.git'
                    author:'foo'
                    branch:'master'
                    }, done)
            builder.waitNextBuildFinished(lastbuild)
        console.go()
        expect(console.countSuccess()).toBeGreaterThan(0)
