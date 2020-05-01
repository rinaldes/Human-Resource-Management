class DashboardsController < ApplicationController
  # before_action :get_blast_messages

  def index
    if current_user.flag_company_dashboard
      visi_misi
    else
      @first_level = BlastMessage.first_level
      @second_level = BlastMessage.second_level
      @company_blast_messages = BlastMessageDetail.where("created_at >= ? and company_id = ?", Time.zone.now.beginning_of_day, current_user.company_id.to_i)
      @division_blast_messages = BlastMessageDetail.where("created_at >= ? and organization_id = ?", Time.zone.now.beginning_of_day, current_user.organization_id.to_i)
      @group_blast_messages = BlastMessageDetail.where("blast_messages.created_at >= ? and sender_type = ?", Time.zone.now.beginning_of_day, 'admin').joins(:blast_message)
      knowledges = Knowledge.where("status IS TRUE")
      @hot_news = knowledges.sort_by{|a|a.knowledge_details.count}.reverse
      @first_hot_news = @hot_news.first
      @knowledges = {}
      Company::INITIAL_CATEGORIES.each{|news|
        @knowledges[news] = knowledges.where(
          "id IN (SELECT knowledge_id FROM knowledge_receivers INNER JOIN categories ON categories.id=knowledge_receivers.category_id WHERE name='#{news}')"
        )
      }
      @first_funpage = @knowledges['Funpage'][0]
      @hot_funpage = @knowledges['Funpage'].sort_by(&:read_count).last
      @new_news = Knowledge.order("created_at DESC").limit(1).first
      @photos = Photo.where("created_by IN (#{current_user.company.users.map(&:id).join(', ')})")
      @news_tickers = Knowledge.where("company_id = ? AND knowledge_receivers.category_id=(SELECT id FROM categories WHERE name='Ticker' AND created_by=#{current_user.id} LIMIT 1) AND end_date >= '#{Time.now.strftime('%Y-%m-%d 00:00:00')}'",
        @current_user.company_id.to_i).order("created_at DESC").limit(7).joins("INNER JOIN knowledge_receivers ON knowledge_receivers.knowledge_id=knowledges.id")
    end
  end

  def show
    @dashboard = BlastMessage.find(params[:id])
  end

  def new
    @dashboards = BlastMessage.all
  end

  def company_new
    @dashboards = BlastMessage.all 
  end

  def visi
    @visi = @current_company.vision
  end

  def misi
    @misi = @current_company.mision
  end

  def code_of_conduct
    @code_of_conduct = @current_company.code_of_conduct
  end

  def culture
    @culture = @current_company.culture
  end

    def value_company
      @value_company = @current_company.value
    end

    def knowledge
      @knowledge = @current_company.knowledge
    end
    # def visi_misi
    #   debugger
    #   @visi = @current_company.vision
    #   @misi = @current_company.mision
    # end

    private
      def visi_misi
        @flag = current_user.flag_company

        if params[:flag].present?
          @flag.update(params[:flag] => false)
        end

        if @flag.present?
          if @flag.vision
            redirect_to action: 'visi'
          elsif @flag.mision
            redirect_to action: 'misi'
          elsif @flag.code_of_conduct
            redirect_to action: 'code_of_conduct'
          elsif @flag.value_company
            redirect_to action: 'value_company'
          elsif @flag.culture
            redirect_to action: 'culture'
          else
            current_user.update(:flag_company_dashboard => false)
            redirect_to action: 'index'
          end

        else
          current_user.update(:flag_company_dashboard => false)
          redirect_to action: 'index'
        end
      end
  # private
  # 	def get_blast_messages
  #   	@blast_messages = BlastMessage.all.map{|x| [x.name, x.id]} 
  # 	end
end
