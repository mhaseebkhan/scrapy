module Api::V1
  class UrlsController < ApplicationController

    # GET /urls
  def index
    @urls = Url.includes(:tags).all
    render :json => @urls
  end

  def create
    @url = Url.new(url: params[:url])
    res = crawl_url params[:url]

    if !res.nil? && res.code == "200"
      @url.data = res.body
      if @url.save
        render json: {status: 'success',url: @url.url,
                      a: @url.tags.where(tag: 'a').count,
                      h1: @url.tags.where(tag: 'h1').count,
                      h2: @url.tags.where(tag: 'h2').count,
                      h3: @url.tags.where(tag: 'h3').count }
        return
      end
    end

    render json: @url.errors
  end
  private
  def crawl_url url
    begin
      url = URI.parse(url)
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port,:use_ssl => url.scheme == 'https') {|http|
        http.request(req)
      }
    rescue Timeout::Error, EOFError, Net::HTTPBadResponse,
        Net::HTTPHeaderSyntaxError, Net::ProtocolError , Exception => e
      @url.errors.add(:status,  e.to_s)
      res
    end
    res
  end

  end
end
