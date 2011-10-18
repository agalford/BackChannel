class PostVotesController < ApplicationController
  # GET /post_votes
  # GET /post_votes.json
   before_filter :authenticate_user!

  def index
    @post_votes = PostVote.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @post_votes }
    end
  end

  # GET /post_votes/1
  # GET /post_votes/1.json
  def show
    @post_vote = PostVote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post_vote }
    end
  end

  # GET /post_votes/new
  # GET /post_votes/new.json
  def new
    pid = params[:format]
    @vote = PostVote.new
    @post = Post.find(pid)
    vote_exists = PostVote.find_by_sql ["SELECT id FROM post_votes WHERE (user_id = ? AND post_id = ?)", current_user.id, pid]
    if ( @post.user_id == current_user.id)
      redirect_to posts_path, alert:  'You may not vote for your own posts.'
    else
      if ( vote_exists.size == 0 )
        @vote = PostVote.new(params[:post_vote])
        @vote.post_id = @post.id
        @vote.user_id = current_user.id
        @vote.save
        @post.vote_count += 1
        @post.save
        redirect_to posts_path, notice: 'Vote successfully recorded'
      else
        @vote.destroy
        redirect_to posts_path, alert: 'You have previously voted for this post.  Users can only vote once for each post.'
      end
    end
  end

  # GET /post_votes/1/edit
  def edit
    @post_vote = PostVote.find(params[:id])
  end

  # POST /post_votes
  # POST /post_votes.json
  def create
    @post_vote = PostVote.new(params[:post_vote])

    respond_to do |format|
      if @post_vote.save
        format.html { redirect_to @post_vote, notice: 'Post vote was successfully created.' }
        format.json { render json: @post_vote, status: :created, location: @post_vote }
      else
        format.html { render action: "new" }
        format.json { render json: @post_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /post_votes/1
  # PUT /post_votes/1.json
  def update
    @post_vote = PostVote.find(params[:id])

    respond_to do |format|
      if @post_vote.update_attributes(params[:post_vote])
        format.html { redirect_to @post_vote, notice: 'Post vote was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @post_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_votes/1
  # DELETE /post_votes/1.json
  def destroy
    @post_vote = PostVote.find(params[:id])
    @post_vote.destroy

    respond_to do |format|
      format.html { redirect_to post_votes_url }
      format.json { head :ok }
    end
  end
end
