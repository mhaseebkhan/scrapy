require 'test_helper'

class UrlTest < ActiveSupport::TestCase
  def setup
    @url = Url.create(url: "http://www.google.com/")
  end

  test "valid url" do
    assert @url.valid?
  end

  test "invalid without url" do
    url = Url.new()
    refute url.valid?, 'URL is valid without url'
  end

  test "unique url" do
    duplicate_url = @url.dup
    assert_not duplicate_url.valid?
  end
end
