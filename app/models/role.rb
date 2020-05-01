class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true
  has_one :user
  has_many :features, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  # validates :resource_type,
  #           :inclusion => { :in => Rolify.resource_types },
  #           :allow_nil => true
            

  scopify


  # def feature_all
  # 	html = ""
  # 	# self.features.each do |feature|
  # 	# 	html += (feature.feature_name.name +" become "+ feature.feature_group.name +"<br/>").to_s
  # 	# end
  # 	return html
  # end
end
