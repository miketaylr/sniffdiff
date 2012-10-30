require 'rubygems'
require 'sinatra'
require 'sinatra/content_for'
require 'securerandom'
require 'pygments'
require 'yaml'

@@uas = YAML.load_file('user-agents.yml')

helpers do
  
  # adds the version number into the ua string
  # def uanum(version_number, ua_string)
  #   ua_string.sub!(/\{#\}/, version_number) 
  # end
  
  def get_ua_string(code)
    @@uas[code]
  end
  
  def fetch(code, url, write_to_disk=true) 
    ua = get_ua_string(code)
    # curl options:
    # -i return headers with the response body
    # -s suppress output (including errors). might be a terrible idea. 
    # -A custom user agent
    page = `curl -isA "#{ua}" #{url}`
    store(page) if write_to_disk
  end

  def store(page)
    #create a temporary page to store http response
    name = "tmp/" + SecureRandom.hex + ".txt"
    File.open(name, "w") do |f|
      f.puts page
    end
    #return the tempfile name
    name
  end
end

get '/' do
  erb :index
end

not_found do
  erb :'404', :locals => {:url => url }
end

get %r{(safari|firefox|opera|chrome|ie)\/(safari|firefox|opera|chrome|ie)\/((?:https?:\/\/)?\S+)} do | one, two, url|
  #remove extra slash
  cleanurl = url.gsub(/^(https?:)?\//, '\1//')
  #call sdiff
  sdiff = `sdiff #{fetch(one, cleanurl)} #{fetch(two, cleanurl)} --strip-trailing-cr -w 175`
  #make the results look pretty
  page = Pygments.highlight(sdiff.encode!(:universal_newline => true))
  
  #render result template
  erb :result, :locals => {
    :one    => one, 
    :two    => two,
    :url    => cleanurl,
    :jank   => page
  }
end

get %r{(safari|firefox|opera|chrome|ie)\/((?:https?:\/\/)?\S+)} do | one, url |
  raise "implement me!"
end

#get 'platform' do
  #look at get get params, and referer header maybe. return the content to be injected via xhr, no need to render a 
  #template.
  #should be a corresponding select box at top of page to set platform param
#end
