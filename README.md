# Sniffdiff

A work in progress, with failing tests and everything!

###Dependencies:
* Ruby 1.9.2+
* [rubygems](http://rubyforge.org/frs/?group_id=126)
* [bundler](http://gembundler.com/)

One you have those:
`gem install bundler`
`bundle install`

### Running tests
`rake test`

### Starting the app 

`rake run` (or just `rake`)

#### TODO

* Be able to change platform
* Be able to set custom string
* Be able to change version
* Unminify html?
* Show requests headers
* More Tests (and fix two failures/errors)
* for a single ua name, app.com/firefox/site.com, just show the curl result

ideas: if there's a number after the UA param,
use that in the UA string. seems a little messy, but useful
so like, /firefox2/safari5.1/whatever.com

is there an api that lists the most current browser version?
maybe http://api.html5please.com/ or something? 

* Issue: chopped off markup gets an .err class
  