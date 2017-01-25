require 'test_helper'

class UrlsControllerTest < ActionDispatch::IntegrationTest
  test "should create url" do
    VCR.use_cassette("google_post") do
      post '/v1/urls', params: {url: "https://www.google.com.pk/?gws_rd=cr&ei=0GKHWKKNJ8bfU_rvkegM"}
      assert JSON.parse(response.body)['status'] == 'success'
      assert_response :success
    end
  end

  test "should not create url" do
    VCR.use_cassette("google_post", :allow_playback_repeats => true) do
      post '/v1/urls', params: {url: "https://www.google.com.pk/?gws_rd=cr&ei=0GKHWKKNJ8bfU_rvkegM"}
      post '/v1/urls', params: {url: "https://www.google.com.pk/?gws_rd=cr&ei=0GKHWKKNJ8bfU_rvkegM"}
      assert JSON.parse(response.body)['url'] == ["has already been taken"]
      assert_response :success
    end
  end

  test "should list urls with tags" do
    VCR.use_cassette("google_get") do
      post '/v1/urls', params: {url: "https://www.google.com.pk/?gws_rd=cr&ei=0GKHWKKNJ8bfU_rvkegM"}
      get '/v1/urls'
      assert response.parsed_body[0]['tags'].count == 19
      assert_response :success
    end
  end

end
