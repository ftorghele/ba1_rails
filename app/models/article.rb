class Article < ActiveRecord::Base

  validates_presence_of :title
  validates_presence_of :text

  scope :find_prev, lambda { |id| { :conditions => [ "id < :id", { :id => id } ] } }
  scope :find_next, lambda { |id| { :conditions => [ "id > :id", { :id => id } ] } }

  def self.api_links(action = nil, id = nil)
    case action
      when :entryPoint
        [ { :link => { :rel => "all", :uri => "/articles/"} },
          { :link => { :rel => "new", :uri => "/articles/"} }]
      when :allArticles
        [ { :link => { :rel => "new", :uri => "/articles/"} } ]
      when :article
        next_record = Article.find_next(id).first
        prev_record = Article.find_prev(id).last
        [ { :link => { :rel => "self", :uri => "/articles/#{id}"} },
          { :link => { :rel => "update", :uri => "/articles/#{id}"} },
          { :link => { :rel => "delete", :uri => "/articles/#{id}"} },
          { :link => { :rel => "next", :uri => next_record.nil? ? nil : "/articles/#{next_record.id}"} },
          { :link => { :rel => "prev", :uri => prev_record.nil? ? nil : "/articles/#{prev_record.id}"} }]
      when :errorResponse
        [ { :link => { :rel => "all", :uri => "/articles/"} },
          { :link => { :rel => "new", :uri => "/articles/"} }]
    end
  end
end
