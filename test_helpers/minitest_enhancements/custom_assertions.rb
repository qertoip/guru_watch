# -*- coding: UTF-8 -*-

module MiniTest::Assertions
  def assert_valid( act, msg = nil )
    valid = act.valid?
    msg = message(msg, "") { "Expected #{act.class.name} to be valid but found errors #{act.errors.full_messages}" }
    assert( valid, msg )
  end

  def refute_valid( act, msg = nil )
    valid = act.valid?
    msg = message(msg, "") { "Expected #{act.class.name} to be invalid but found no errors" }
    refute( valid, msg )
  end
end

# Define the assertions as expectations
module MiniTest::Expectations
  infect_an_assertion :assert_valid, :must_be_valid
  infect_an_assertion :refute_valid, :wont_be_valid
end

# Add the expectations to all objects
class Object
  include MiniTest::Assertions
  include MiniTest::Expectations
end
