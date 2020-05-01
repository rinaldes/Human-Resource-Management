class KnowledgeReceiver < ActiveRecord::Base
	belongs_to :category
	belongs_to :knowledge
	
end
