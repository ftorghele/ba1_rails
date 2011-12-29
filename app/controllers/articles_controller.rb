class ArticlesController < ApplicationController
  respond_to :json

  skip_before_filter :verify_authenticity_token

  def entry
    respond_with(:api => Article.api_links(:entryPoint))
  end

  def index
    @articles = Article.all
    respond_with({
      :content => @articles.collect{ |a| { :title => a.title, :text => a.text, :api => Article.api_links(:article, a.id)} },
      :api => Article.api_links(:allArticles)
    })
  end

  def create
    @article = Article.new(:title => params[:title], :text => params[:text])
    if @article.save
      response.status = 201 # Created
      respond_with({
        :content => @article,
        :api => Article.api_links(:article, @article.id)
      }, :location => article_path(@article))
    else
      return_status 400, @article.errors.to_hash
      return_status 400, @article.errors.to_hash
    end
  end

  def show
    if @article = Article.find_by_id(params[:id].to_i)
      respond_with({
        :content => @article,
        :api => Article.api_links(:article, @article.id)
      })
    else
      return_status 404, "Not found"
    end
  end

  def update
    if @article = Article.find_by_id(params[:id].to_i)

      @article.title = params[:title] unless params[:title].nil?
      @article.text = params[:text] unless params[:text].nil?

      if @article.save
        # respond_with does not fire
        render :json => {
          :content => @article,
          :api => Article.api_links(:article, @article.id)
        }
      else
        return_status 400, @article.errors.to_hash
      end
    else
      return_status 404, "Not found"
    end
  end

  def destroy
    if @article = Article.find_by_id(params[:id].to_i)
      @article.destroy
      head :no_content
    else
      return_status 404, "Not found"
    end
  end

  private

  def return_status(code, msg)
    # use render because respond_with doesn't fire at update'
    render :json => {
        :status => code,
        :reason => msg,
        :api => Article.api_links(:errorResponse) }, :status => code
  end

end
