class User < ActiveRecord::Base
  rolify
  has_many :knowledge_details
  has_many :knowledge_comments
  has_many :surveys
  has_many :survey_responses

  belongs_to :company
  belongs_to :organization
  belongs_to :role

  has_one :flag_company
  has_one :employee
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:username],
         :reset_password_keys => [:username, :email]

  attr_accessor :password, :password_confirmation, :remember_me
  
  validates_confirmation_of :password
  # validates_presence_of :password, :on => :create
  #validates_presence_of [:username, :first_name, :last_name, :gender, :birth_place, :birth_date, :role, :status]
  validates_presence_of [:username]
  validates_uniqueness_of [:username, :email]

  mount_uploader :image, ImageUploader

  self.per_page = 5

  before_save :encrypt_password

  before_create :build_default_flag

  after_create :generate_employee

  def generate_employee
    Employee.create nik: id, name: full_name, company_id: company_id, status: 'Pending'
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  def encrypt_password
    if password.present?
      self.encrypted_password = BCrypt::Password.create(password)
    end
  end

  def self.set_per_page(number)
    self.per_page = number
  end

  def company_code
   company = organization.company rescue nil
   "#{company.created_at.strftime("%Y%m%d%H%M%S")}#{company.id}" rescue ''
  end

  def fullname
    [first_name, last_name].join(' ')
  end

  def name
    if self.first_name.present? and self.last_name.present?
  	  self.first_name + " " + self.last_name
    else
      return ''
    end
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
  end

  def active_for_authentication?
    super && self.status == "active" # i.e. super && self.is_active
  end

  def inactive_message
    "Sorry, this account is Inactive."
  end

  private
    def build_default_flag
      build_flag_company
    end
end
