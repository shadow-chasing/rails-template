class Forum::ForumsController < ApplicationController
  before_action :set_forum, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :new]

  # GET /forums
  # GET /forums.json
  def index
    @forums = Forum.all.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /forums/new
  def new
    @forum = Forum.new
  end

  # GET /forums/1/edit
  def edit
  end

  # POST /forums
  def create
    @forum = current_user.forums.new(forum_params)

    respond_to do |format|
      if @forum.save
        binding.pry
        # forum id needed for index topic params
        format.html { redirect_to forums_url(@forum.id), notice: 'Forum was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /forums/1
  def update
    respond_to do |format|
      if @forum.update(forum_params)
        format.html { redirect_to @forum, notice: 'Forum was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /forums/1
  def destroy
    @forum.destroy
    respond_to do |format|
      format.html { redirect_to forums_url, notice: 'Forum was successfully destroyed.' }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_forum
      @forum = Forum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def forum_params
      params.require(:forum).permit(:name, :description)
    end
end
