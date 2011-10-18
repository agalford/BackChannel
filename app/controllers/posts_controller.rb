class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  before_filter :authenticate_user!, :except => [:index, :show, :search]

  def index
    @posts = Post.all
    date = DateTime.now.to_date
    @posts.sort! { |a,b| (b.vote_count - (date - b.created_at.to_date)**1.5  <=>
                              a.vote_count - (date - a.created_at.to_date)**1.5) }
    @replies = Array.new
    @posts.each do |post|
      @replies << Reply.where(:post_id => post.id)
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts, json: @replies }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    if current_user.id != @post.user_id
      redirect_to posts_path, alert:  'You may only edit your own posts.'
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.user_id = current_user.id   # Assign FK to posting for user
    # --> Do we want to assign a vote of 1 to each post initially?
    @post.vote_count = 0

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: 'Post was successfully created.' }
        format.json { render json: posts_path, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
    end
  end

  def search
    @posts = Post.search( params[:q] )
    @replies = Reply.search( params[:q] )
    @user = User.search( params[:q] )
    @userPost = Array.new
    unless @user.nil?
      @user.each do |users|
        @userPost << Post.find_by_user_id(users.id)
      end
    end
    #puts "Posts found ==> " + @posts.to_s
    #n = "Searching for \'" + params[:q].to_s + "\'"

    respond_to do |format|
      format.html
      format.json { head :ok }
    end
  end
end
