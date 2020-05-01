class Knowledge < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  has_many :category, :through => :knowledge_receivers
  has_many :knowledge_receivers
  has_many :knowledge_details
  has_many :knowledge_comments
  has_many :categories, :through => :knowledge_receivers
  has_many :knowledge_receivers
  has_many :users, :through => :knowledge_details
  has_many :knowledge_details
  has_many :article_tags
  has_many :tags, through: :article_tags
  has_many :rates

  belongs_to :user

  def generate_tags params
    params[:tags].split('#').each{|tag|
      ArticleTag.create knowledge_id: id, tag_id: Tag.where(name: tag).first_or_create.id
    }
  end

  def thumbnail
    return "<img src='#{image}'/>" if image.present?
    content.split("<").each{|msg|
      return "<#{msg.split('>')[0]}>" if msg[0..2] == 'img'
    }
    "<img src='#{user.company.com_logo}'/>"
  end

  def medium_dashboard
    return "<img src='#{image.medium.url}' class='image-responsive-width hover-effect-img'/>" if image.present?
    content.split("<").each{|msg|
      return "<#{msg.split('>')[0]} class='image-responsive-width hover-effect-img'>" if msg[0..2] == 'img'
    }
    "<img src='#{user.company.com_logo.medium.url}' class='image-responsive-width hover-effect-img'/>"
  end

  def thumbnail_dashboard
    return "<img src='#{image.thumb.url}' class='image-responsive-width hover-effect-img'/>" if image.present?
    content.split("<").each{|msg|
      if msg[0..2] == 'img'
        img = msg.split('src="')[1].split('"')[0].split('/').last
        return "<#{msg.split('>')[0].gsub(img, "thumb_#{img}")} class='image-responsive-width hover-effect-img'>"
      end
    }
    "<img src='#{user.company.com_logo.thumb.url}' class='image-responsive-width hover-effect-img'/>"
  end

  def self.search params
    conditions = ["company_id=#{params[:company_id]}"]
    conditions << "tags.name='#{params[:tag]}'" if params[:tag].present?
    Knowledge.joins("LEFT OUTER JOIN article_tags ON knowledges.id=article_tags.knowledge_id LEFT OUTER JOIN tags ON article_tags.tag_id=tags.id").where(conditions.join(' AND ')).uniq
  end
end