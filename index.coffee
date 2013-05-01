module.exports = (Impromptu) ->
  @register 'node', (done) ->
    @exec 'node --version', (err, version) ->
      done null, version?.replace(/^v/, '')

  @register 'nodeMajor', (done) ->
    @get 'node', (err, node) ->
      version = node?.match(/(\d+\.\d+)/).pop()
      done err, version

  @register 'coffee', (done) ->
    @exec 'coffee --version', (err, version) ->
      done null, version?.match(/(\d+\.\d+\.\d+)/).pop()

  @register 'coffeeMajor', (done) ->
    @get 'coffee', (err, coffee) ->
      version = coffee?.match(/(\d+\.\d+)/).pop()
      done err, version

  @register 'rubyLong', (done) ->
    @exec 'ruby --version', done

  @register 'ruby', (done) ->
    @get 'rubyLong', (err, rubyLong) ->
      version = rubyLong?.match(/ruby ([^\s]+)/).pop()
      done err, version

  @register 'rubyMajor', (done) ->
    @get 'rubyLong', (err, rubyLong) ->
      version = rubyLong?.match(/\D(\d+\.\d+)/).pop()
      done err, version

  @register 'php', (done) ->
    @exec 'php --version', (err, version) ->
      version = version?.match(/PHP (\d+\.\d+.\d+)/).pop()
      done err, version

  @register 'phpMajor', (done) ->
    @get 'php', (err, php) ->
      done err, php?.match(/^(\d+\.\d+)/).pop()

  @register 'python', (done) ->
    # Python outputs its version to stderr for some reason
    @exec 'python --version', (err, misleadingNonsense, version) ->
      version = version?.match(/Python (\d+\.\d+\.\d+)/).pop()
      done err, version

  @register 'pythonMajor', (done) ->
    @get 'python', (err, python) ->
      done err, python?.match(/^(\d+\.\d+)/).pop()
