require "test_helper"

class ItemTest < ActiveSupport::TestCase
  test 'scope :incompletes' do
    assert_equal items(:one, :three), Item.incompletes
  end

  test '#complete' do
    items(:one).complete
    assert items(:one).completed?
  end

  test '#incomplete' do
    items(:two).incomplete
    assert_not items(:two).completed?
  end
end
