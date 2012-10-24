# Sniffdiff

A work in progress, with failing tests and everything!

###Dependencies:
* Ruby 1.9.2+
* [rubygems](http://rubyforge.org/frs/?group_id=126)
* `gem install sinatra`
* `gem install sinatra-contrib`

### Running tests
```
cd test
ruby test.rb
```

### Starting the app 

`ruby sniffdiff.rb`

#### TODO

Be able to change platform
Be able to set custom string
Be able to change version
Unminify html?
Make sure I've got all the right Syntax highlighting CSS
Show requests headers
More Tests (and fix two failures/errors)
get all the right default ua strings (windows/mac), right now it's mixed
need a rake task to clean up all the tmp files.
for a single ua name, app.com/firefox/site.com, just show the curl result

ideas: if there's a number after the UA param,
use that in the UA string. seems a little messy, but useful
so like, /firefox2/safari5.1/whatever.com
is there an api that lists the most current browser version?
maybe http://api.html5please.com/ or something? 

Issue: chopped off markup gets an .err class
Issue: what happens if you have /firefox/blah/ ??
-> right now it 404s (is that 404? more like a 500... but i guess maybe yes.)
  