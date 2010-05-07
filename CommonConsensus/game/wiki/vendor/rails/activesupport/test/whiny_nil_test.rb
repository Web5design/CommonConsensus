require 'test/unit'

# mock to enable testing without activerecord
module ActiveRecord
  class Base
    def save!
    end
  end
end

require File.dirname(__FILE__) + '/../lib/active_support/inflector'
require File.dirname(__FILE__) + '/../lib/active_support/whiny_nil'

class WhinyNilTest < Test::Unit::TestCase
  def test_unchanged
    nil.method_thats_not_in_whiners
  rescue NoMethodError => nme
    assert_match(/nil:NilClass/, nme.message)
  end
  
  def test_active_record
    nil.save!
  rescue NoMethodError => nme
    assert(!(nme.message =~ /nil:NilClass/))
  end
  
  def test_array
    nil.each
  rescue NoMethodError => nme
    assert(!(nme.message =~ /nil:NilClass/))
  end

  def test_id
    nil.id
  rescue RuntimeError => nme
    assert(!(nme.message =~ /nil:NilClass/))
  end
end