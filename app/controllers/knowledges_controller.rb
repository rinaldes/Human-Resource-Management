class KnowledgesController < ApplicationController
  autocomplete :category, :name

  def give_rate
    hash = {user_id: current_user.id, knowledge_id: params[:knowledge_id]}
    current_rate = Rate.where(hash).last
    current_rate ? current_rate.update_attributes(rate: params[:value]) : Rate.create(hash.merge(rate: params[:value]))
    @knowledge =Knowledge.find_by_id(params[:knowledge_id])
    @rates = @knowledge.rates.map(&:rate)
    respond_to {|format|
      format.js
    }
  end

  def index
    @user_count = User.count
    @knowledges = Knowledge.search params.merge(company_id: @current_user.company_id)
  end

  def show
    @knowledge =Knowledge.find_by_id(params[:id])
    @publish_date = @knowledge.publish_date
    @knowledge_comment = KnowledgeComment.new
    @knowledge_details = @knowledge.knowledge_details
    @comments = @knowledge.knowledge_comments
    @unread_users = User.where("company_id=? AND id NOT IN (SELECT user_id FROM knowledge_details)", current_user.company_id)
    KnowledgeDetail.where(user_id: current_user.id, knowledge_id: @knowledge.id).first_or_create
    @knowledge.update_attributes(read_count: @knowledge.read_count.to_i+1)
    @rate = Rate.find_by_user_id_and_knowledge_id(current_user.id, @knowledge.id).rate rescue 0
    @rates = @knowledge.rates.map(&:rate)
  end

  def new
    @knowledge =Knowledge.new
    select_all_categories
  end

  def edit
    @knowledge = Knowledge.find_by_id(params[:id])
    select_all_categories
    @current_categories = @knowledge.knowledge_receivers.map(&:category_id)
    @tags = "#{@knowledge.tags.map(&:name).join('# ')}#"
  end

  def comment
    @knowledge_comment = KnowledgeComment.new(comment_params.merge(knowledge_id: params[:id], user_id: current_user.id))
    @knowledge_comment.save
    redirect_to action: 'show'
  end

  def create
    params[:knowledge][:user_id] = current_user.id
    params[:knowledge][:company_id] = current_user.company_id
    if params[:commit] == "Publish"
      params[:knowledge][:status] = true
      params[:knowledge][:publish_date] = Time.now
    else
      params[:knowledge][:status] = false
    end
    end_date = params[:knowledge][:end_date].split('/') rescue ''
    @knowledge = Knowledge.new(knowledge_params.merge(end_date: ("#{end_date[2]}-#{end_date[1]}-#{end_date[0]}" rescue nil)))
    respond_to do |format|
      if params[:preview_button] || @knowledge.save
        generate_categories
        @knowledge.generate_tags params
        format.html { redirect_to knowledge_path(@knowledge), notice: 'Knowledge was successfully created.' }
        format.json { render :show, status: :created, location: @knowledge }
      else
        select_all_categories
        @tags = "#{@knowledge.tags.map(&:name).join('# ')}#"
        format.html { render :new }
        format.json { render json: @knowledge.errors, status: :unprocessable_entity }
      end
    end
  end

  def generate_categories
    receiver_category = params[:knowledge][:category_id].split(", ")
    receiver_category.each do |category|
      category = Category.find_by_name(category)
      KnowledgeReceiver.create(category_id: category.id, knowledge_id: @knowledge.id) if category.present?
    end
  end

  def update
    @knowledge = Knowledge.find(params[:id])
    params[:knowledge][:user_id] = current_user.id
    params[:knowledge][:company_id] = current_user.company_id
    if params[:commit] == "Publish"
      params[:knowledge][:status] = true
      params[:knowledge][:publish_date] = Time.now unless @knowledge.status
    else
      params[:knowledge][:status] = false
    end
    respond_to do |format|
      if params[:preview_button] || @knowledge.update_attributes(knowledge_params)
        @knowledge.knowledge_receivers.delete_all
        generate_categories
        @knowledge.article_tags.delete_all
        @knowledge.generate_tags params
        format.html { redirect_to @knowledge, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @knowledge }
      else
        select_all_categories
        @tags = "#{@knowledge.tags.map(&:name).join('# ')}#"
        format.html { render :edit }
        format.json { render json: @knowledge.errors, status: :unprocessable_entity }
      end
    end
  end

  def autocomplete_name
    render json: Category.joins(:user).where("users.company_id=#{@current_user.company_id} AND LOWER(name) like '%#{params[:term].downcase}%'").map { |category|
      {value: category.name.to_s, text: category.name.to_s}
    }
  end

  def autocomplete_tag_name
    render json: Tag.where("LOWER(name) like '%#{params[:term].downcase}%'").map { |tag| {value: tag.name.to_s, text: tag.name.to_s} }
  end

  private
    def select_all_categories
      @categories = Category.joins(:user).where("users.company_id=#{@current_user.company_id}").group_by(&:category_group)
      @origin_categories = Category.joins(:user).where("users.company_id=#{@current_user.company_id}")
      @most_used_tags = ArticleTag.select("tags.name AS tag_name, count(*) AS count_tag_id").group(:tag_name).joins(:tag).order("count_tag_id DESC").limit(35)
    end

    def set_knowledge
        @knowledge = Knowledge.find(params[:id])
    end

    def knowledge_params
      params.require(:knowledge).permit(:article_name, :status, :image, :content, :user_id, :company_id, :category_id, :publish_date, :end_date)
    end

    def comment_params
      params.require(:knowledge_comment).permit(:comment)
    end
end
