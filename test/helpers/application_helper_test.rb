# frozen_string_literal: true

require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "not_turbo_native" do
    @request_from_turbo_native = true
    assert_nil not_turbo_native { "processed" }

    @request_from_turbo_native = false
    assert_equal "processed", not_turbo_native { "processed" }
  end

  # emulate ApplicationController#turbo_native? method
  def turbo_native?
    @request_from_turbo_native
  end
end
