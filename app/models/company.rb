class Company < ActiveRecord::Base

  INITIAL_CATEGORIES = %w(Business Lifestyle Education Technology Entertainment Funpage)

  has_many :users
  has_many :organizations
  has_many :employees
  has_one  :mision
  has_one  :value
  has_one  :vision
  has_one  :code_of_conduct
  has_one  :culture
  has_many :blast_message_details
  has_many :approval_levels
  belongs_to :province
  belongs_to :city

  after_create :build_approval_levels

  accepts_nested_attributes_for :users, :reject_if => :all_blank, :allow_destroy => true

  validates_presence_of [:name, :phone, :address, :postal_code, :province_id, :city_id, :owner_name, :com_email, :joined_at]
  validates_uniqueness_of [:com_email, :name]

  mount_uploader :com_logo, ImageUploader

  before_create :confirmation_token


  def misions
    Mision.where("company_id=?", id)
  end

  def cultures
    Culture.where("company_id=?", id)
  end


  def code_of_conducts
    Mision.where("company_id=?", id)
  end

  def values
    Value.where("company_id=?", id)
  end

  def visions
    Vision.where("company_id=?", id)
  end

  self.per_page = 5

  def self.set_per_page(number)
    self.per_page = number
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    self.is_active =  true
    save!(:validate => false)
  end

  private
    def confirmation_token
      self.confirm_token = SecureRandom.urlsafe_base64.to_s if self.confirm_token.blank?
    end

    def build_approval_levels
      ["Leave Request", "Overtime Request", "Recruitment"].each do |feature_name|
        approval_levels.build(feature_name: feature_name)
      end
      INITIAL_CATEGORIES.each{|category|
        Category.create name: category, created_by: users.first.id
      }
    end
end
