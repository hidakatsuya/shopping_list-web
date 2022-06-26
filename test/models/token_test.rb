# frozen_string_literal: true

require 'test_helper'

class TokenTest < ActiveSupport::TestCase
  test 'regenerate_value!' do
    token = tokens(:one)

    assert_changes ->{ token.value } do
      token.regenerate_value!
    end
  end
end
