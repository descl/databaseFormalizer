require 'test_helper'

class DatabaseformalizerTest < Test::Unit::TestCase
  load_schema

  def test_fixtures_are_working
    assert_equal databaseformalizer_widget(:first).title, "This is the title"
  end
  
    
end
