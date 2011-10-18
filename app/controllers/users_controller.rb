class UsersController < ApplicationController
  #before_filter :get_user, :only => [:index,:new,:edit]
  #before_filter :accessible_roles, :only => [:new, :edit, :show, :update, :create]
  #load_and_authorize_resource :only => [:show,:new,:destroy,:edit,:update]

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @postcount = Post.count_by_sql ["select count(id) from POSTS where user_id = ?", params[:id] ]
    @replycount = Reply.count_by_sql ["select count(id) from REPLIES where user_id = ?", params[:id] ]
    @posts = Post.find_all_by_user_id(params[:id])
    @replies = Reply.find_all_by_user_id(params[:id])
    @postvotesearned = 0
    @replyvotesearned = 0
    unless @posts.nil?
      @posts.each do |pv|
        @postvotesearned = @postvotesearned + pv.vote_count
      end
    end
    unless @replies.nil?
      @replies.each do |rv|
        @replyvotesearned += rv.vote_count
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    if ( User.find_by_email(params[:user].email) || User.find_by_user_code(params[:user.user_code]) )
        format.html { redirect_to administrators_url, alert: 'Duplicate email or user name detected.' }
        format.json { render json: @user.errors, status:  :unprocessable_entity }
    else
      @user = User.new(params[:user])

      respond_to do |format|
        if @user.save
          format.html { redirect_to administrators_url, notice: 'User was successfully created.' }
          format.json { render json: administrators_url, status: :created, location: @user }
        else
          format.html { render action: "new" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to administrators_url, notice: 'User was successfully deleted.' }
      format.json { head :ok }
    end
  end
end
