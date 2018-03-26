class SponsoredPostsController < ApplicationController

  def index

  end

  def show
    @sponsored_post = Sponsored_post.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @sponsored_post = Sponsored_post.new
  end
end
