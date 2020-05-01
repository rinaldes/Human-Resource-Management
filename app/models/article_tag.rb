class ArticleTag < ActiveRecord::Base
  belongs_to :knowledge
  belongs_to :tag
end
