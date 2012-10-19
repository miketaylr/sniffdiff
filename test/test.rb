require '../sniffdiff'
require 'test/unit'
require 'rack/test'

ENV['RACK_ENV'] = 'test'

class SniffDiffTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def is_this_thing_on
    get '/'
    assert last_response.ok?
  end

  def test_that_index_gives_instructions
    get '/'
    assert last_response.ok?
    assert last_response.body.include?('Usage');
  end

  def test_404
    get '/doesntexist'
    assert last_response.status == 404
  end

  def test_everything_works_as_expected
    get '/firefox/opera/miketaylr.com' 
    # i don't actually know why this is a 500 :S

    assert last_response.body.include?('X-Burger: Illegal')
  end

  def test_everything_works_2
    get '/firefox/opera/http://miketaylr.com'
    assert last_response.body.include?('X-Burger: Illegal')
  end

  def test_bogus_url
    get '/firefox/opera/http::///miketaylr..com'
    assert last_response.status == 500
  end
  
  def test_only_one_ua
    get '/firefox/miketaylr.com'
    assert last_response.status = 404
    #probably should land you on a page that explains the instructions again
  end

  def test_404_page_is_useful
    get '/dfkjdkfjdkfjdfd'
    assert last_response.status == 404
    assert last_response.body.include?('Whoops')
  end

  def test_title_matches_url
    get '/opera/opera/miketaylr.com'
    puts last_response.body.title
  end


end
