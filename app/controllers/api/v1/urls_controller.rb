module Api::V1
  class UrlsController < ApplicationController

    # GET /urls
    def index
      @urls = Url.includes(:tags).all
      render :json => @urls
    end

    # POST /urls
    def create
      @url = Url.new(url: params[:url])
      res = crawl_url params[:url]

      if !res.nil? && res.message.downcase.to_sym == :ok
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
      response = HTTParty.get(url)
      rescue Exception => e
        @url.errors.add(:status,  'failure')
        @url.errors.add(:message,  e.to_s)
      end
      response
    end
  end
end
