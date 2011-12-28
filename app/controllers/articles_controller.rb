class ArticlesController < ApplicationController
  respond_to :json

  skip_before_filter :verify_authenticity_token

  def index
    @articles = Article.all
    respond_with(@articles)
  end

  def create
    @article = Article.new(:title => params[:title], :text => params[:text])
    if @article.save
      headers["Location"] = "/article/#{@article.id}"
      response.status = 201 # Created
      respond_with(@article)
    else
      return_json_status 400, @article.errors.to_hash
    end
  end

  def show
    if @article = Article.find_by_id(params[:id].to_i)
      respond_with(@article)
    else
      return_json_status 404, "Not found"
    end
  end

  def update
    if @article = Article.find_by_id(params[:id].to_i)

      @article.title = params[:title] unless params[:title].nil?
      @article.text = params[:text] unless params[:text].nil?

      if @article.save
        render :json => @article.to_json
      else
        return_json_status 400, @article.errors.to_hash
      end
    else
      return_json_status 404, "Not found"
    end
  end

  def destroy
    if @article = Article.find_by_id(params[:id].to_i)
      @article.destroy
      head :no_content
    else
      return_json_status 404, "Not found"
    end
  end

end
