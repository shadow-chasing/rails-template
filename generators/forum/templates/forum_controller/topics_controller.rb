class Forum::TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]
  after_action :last_commenter, only: [:create]


  # GET /topics
  def index
    if params[:forum_id]
      @forum = Forum.find(params[:forum_id])
      @topics = @forum.topics
      @forum.increment!(:pagecount)
    else
      @topics = Topic.all
    end
  end

  # GET /topics/1
  def show
    # build articles/_form
    @comment = @topic.comments.build
    @topic.increment!(:pagecount)
  end

  # GET /topics/new
  def new
    @topic = Topic.new
    @topic.comments.build
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  def create
    @topic = current_user.topics.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to topic_url(@topic), notice: 'Topic was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /topics/1
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to topic_url(@topic), notice: 'Topic was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /topics/1
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to forums_url, notice: 'Topic was successfully destroyed.' }
    end
  end

  private

    def last_commenter
      if current_user.present?
        @topic.update(last_poster_id: current_user.id, last_poster_username: current_user.username, last_post_at: Time.now)
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:name, :last_poster_id, :last_post_at, :last_poster_username, :forum_id, comments_attributes: [:id, :name, :content, :topic_id, :user_id])

    end
end
