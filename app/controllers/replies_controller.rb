class RepliesController < ApplicationController
  # GET /replies
  # GET /replies.json
  def index
    @replies = Reply.all
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @replies }
    end
  end

  # GET /replies/1
  # GET /replies/1.json
  def show
    if (params[:id] == 'search')
      @posts = Post.search( params[:q] )
      @replies = Reply.search( params[:q] )
      @user = User.search( params[:q] )
      @userPost = Array.new
      unless @user.nil?
        @user.each do |users|
          @userPost << Post.find_by_user_id(users.id)
        end
      end
      render 'posts/search' and return
    end
    #@reply = Reply.find(params[:id])
    #@reply2 = Reply.where(:post_id => params[:id])
    @post = Post.find(params[:id])
    @reply = Reply.find_by_sql ["select * from replies where post_id = ?", params[:id]]
    @reply.sort! { |a,b| b.vote_count <=> a.vote_count }
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reply }
    end
  end

  # GET /replies/new
  # GET /replies/new.json
  def new
    @reply = Reply.new
    session[:post_id] = params[:id]
    #@reply.post_id = params[:id]
    #@reply.user_id = current_user.id
    #@reply.post_id = params[:id].to_i
    #@reply.vote_count = 1
    #@post = Post.find(params[:id])
    #@reply.post_id = params[:id].to_i
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reply }
    end
  end

  # GET /replies/1/edit
  def edit
    @reply = Reply.find(params[:id])
    if current_user.id != @reply.user_id
      redirect_to posts_path, alert:  'You may only edit your own replies.'
    end
  end

  # POST /replies
  # POST /replies.json
  def create
    @reply = Reply.new(params[:reply])
    @reply.user_id = current_user.id
    @reply.post_id = session[:post_id]
    @reply.vote_count = 0
    respond_to do |format|
      if @reply.save
        format.html { redirect_to reply_path(@reply.post_id), notice: 'Reply was successfully created.' }
        format.json { render json: @reply, status: :created, location: @reply }
      else
        format.html { render action: "new" }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /replies/1
  # PUT /replies/1.json
  def update
    @reply = Reply.find(params[:id])

    respond_to do |format|
      if @reply.update_attributes(params[:reply])
        format.html { redirect_to reply_path(@reply.post_id), notice: 'Reply was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /replies/1
  # DELETE /replies/1.json
  def destroy
    @reply = Reply.find(params[:id])
    @post = Post.find(@reply.post_id)
    @reply.destroy

    respond_to do |format|
      format.html { redirect_to reply_path(@post.id) }
      format.json { head :ok }
    end
  end

  def add_reply

  end
end
