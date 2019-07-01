class PostsController < ApplicationController
  def index
    if params[:search]
      # select searched post and sorted descend
      @posts = Post.search(params[:search ]).all.order('created_at DESC').paginate(:per_page => 10, :page => params[:page])
    else
      # select all post and sorted descend
      @posts = Post.all.order('created_at DESC').paginate(:per_page => 10, :page => params[:page])
    end
    @categories = Category.all
  end

  def show
    @posts = Post.find(params[:id])
    @categories = Category.all
    @comment = Comment.new
    @comments = Comment.all
  end
end
