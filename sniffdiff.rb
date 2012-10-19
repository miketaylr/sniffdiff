require 'rubygems'
require 'sinatra'
require 'sinatra/config_file'
require 'sinatra/content_for'
require 'securerandom' 

config_file "config.yml"

helpers do
  # adds the version number into the ua string
  def uanum(version_number, ua_string)
    ua_string.sub!(/\{#\}/, version_number) 
  end
  
  def fetch(ua, url) 
    # curl options:
    # -i return headers with the response body
    # -# suppress the fancy progress bar
    # -s suppress output (including errors). might be a terrible ideas. 
    # -A custom user agent
    #
    page = `curl -i -# -s -A "#{ua}" #{url}`
    file = store(page)
  end

  def store(page)
    name = "tmp/" + SecureRandom.hex + ".txt"
    File.open(name, "w") do |f|
      f.puts page
    end
    name
  end

end

get '/' do
  erb :index
end

not_found do
  erb :'404', :locals => {:url => url }
end
# ideas: if there's a number after the UA param,
# use that in the UA string. seems a little messy, but useful
# so like, /firefox2/safari5.1/whatever.com
# question: what does it default to if you don't? most current?
# is there an api that lists the most current browser version?
# maybe http://api.html5please.com/ or something? 
get %r{(\w+)\/(\w+)\/((?:https?://)?[\S]+)} do | one, two, url|
  cleanurl = url.gsub(/^(https?:)?\//, '\1//')
  sdiff = `sdiff #{fetch(one, cleanurl)} #{fetch(two, cleanurl)}`

  erb :result, :locals => {:jank => sdiff.encode(:xml => :text), :url => cleanurl}
end

#get 'platform' do
  #look at get get params, and referer header maybe. return the actual content here, no need to render a 
  #template.
  
  # i don't remember what this is supposed to be :S
#end


