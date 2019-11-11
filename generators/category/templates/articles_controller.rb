class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  # show, new, edit, create and update

  # GET /articles
  def index
    if params[:category].blank?
      @articles = Article.all
    else
      @articles = category_attributes.most_recent.published
    end
  end

  # GET /articles/1
  def show
    # increment page count
    @article.increment!(:pagecount)
  end

  # GET /articles/new
  def new
    @article = Article.new
    @article.pictures.build
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  def create
    @article = current_admin_user.articles.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /articles/1
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
    end
  end

  # find all categorys matching id
  def category_attributes
    Article.where(category_id: params[:category])
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content, :published, :published_at, :category_id, :user_id, pictures_attributes: [:id, :name])
    end
end
