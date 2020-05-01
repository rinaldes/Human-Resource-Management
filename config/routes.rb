Rails.application.routes.draw do

  # mount Ckeditor::Engine => '/ckeditor'
  resources :schedules do
    collection do
      get :get_employee
      get :autocomplete_employee_name
      post :import
    end
    member do
      get :detail
    end
  end

  resources :performances do
    collection { post :import }
  end



  # resources :photos
  # get :autocomplete_name

resources :photos do
    collection do
      get :autocomplete_organization
      get :autocomplete_photo_activity_name
      get :photo_new
      get :search
      
      get :photo_new
      post :photo_create
      delete :photo_destroy
      get :photo_edit
      patch :photo_update
      put :photo_update
      # post :dropzone
      # get :dropzone
    end
      member do
      put :comment
    end
  end


  resources :holidays do
  collection { post :import }
end

  resources :leave_requests do
  collection { post :import }
end

  resources :overtime_requests do
  collection { post :import }
end

  resources :attendance_settings

  resources :employee_surveys

  resources :admin_surveys

  resources :dashboards do
    collection do
      get :company_new
      # get :visi_misi
      get :visi
      get :misi
      get :code_of_conduct
      get :culture
      get :value_company
    end
  end

  # get 'recruitments/index'

  # get 'dashboards/index'

  get 'components/index'

   get 'user_managements/index'

  get 'categories/index'

  get 'shifts/index'

  get 'blast_messages/index'

  get 'holidays/index'

  get 'values/index'

  get 'cultures/index'

  get 'visions/index'

  get 'misions/index'

  get 'code_of_conducts/index'

  get 'approvals/index'

  get 'approval_employees/index'

  get 'divisions/index'

  post '/tinymce_assets' => 'tinymce_assets#create'

  namespace :admin do
    get "logout" => "sessions#destroy", :as => "logout"
    get "login" => "sessions#new", :as => "login"
    get "dashboard" => "dashboard#index", :as => "dashboard"
    get "confirmation/:id" => "confirmations#index", :as => "confirmation"
    resources :sessions, only: [:destroy, :create, :new]
    resources :passwords, only: [:create, :update, :edit, :new]
    # resources :dashboard, only: :index
    resources :companies do
      member do
        get :resend
      end
      collection do
        get :get_city
        post :search
        get :search
      end
    end
    resources :blast_messages, only: [:index, :create] do
      collection do
        get :autocomplete_company_email
      end
    end
    root :to => "sessions#new"
    # devise_for :users, path_prefix: 'admin', controllers: {sessions: "admin/sessions"}
    # devise_scope :user do
      # get '/users/sign_in', :to => 'sessions#new', as: :new_api_user_session
    # end
  end

  #untuk mengubah locale (bahasa)
  # get "set_language/change_locale" 

  resources :user_managements

  devise_for :users
  resources :users
  # resources :users do
  #   collection do
  #     post :search
  #     get :search
  #     get :autocomplete_name
  #   end
  #   member do
  #     get :unsuspend
  #   end
  # end
  

  resources :organizations do
    member do
      get :position_edit
    end
    collection do
      get :search
      get :posisision_data
      get :position_index
      post :position_index
      get :position_show
      get :position_new
      post :position_create
      delete :position_destroy
      patch :position_update
      put :position_update
      
    end
  end

   resources :positions

  resources :fingerprints do
    collection do
      get :search
    end
  end
  
  

  resources :companies do
    collection do
      get :get_city
    end
  end

  resources :roles

  resources :approvals

  resources :asset_assignments do
    collection do
      post :return
    end
  end

  resources :recruitments do
    member do
      get :detail
      post :add_employee
    end
  end

  resources :visions, only: [:index, :show] do
    collection do
      post :setup
      get :visi_misi
    end
  end

  resources :misions, only: [:index, :show] do
    collection do
      post :setup
    end
  end

  resources :cultures, only: [:index, :show] do
    collection do
      post :setup
    end
  end


  resources :code_of_conducts, only: [:index, :show] do
    collection do
      post :setup
    end
  end

  resources :values, only: [:index, :show] do
    collection do
      post :setup
    end
  end

  resources :holidays

  resources :personal_datas

  resources :holiday_types do
    collection do
      put :update_holiday_type
      get :search
    end
  end

  resources :shifts

  resources :knowledges do
    collection do
      get :autocomplete_name
      get :autocomplete_tag_name
      get :knowledge_new
      get :search
      get :knowledge_show
      get :knowledge_new
      post :knowledge_create
      post :give_rate
      delete :knowledge_destroy
      get :knowledge_edit
      patch :knowledge_update
      put :knowledge_update
      # post :dropzone
      # get :dropzone
    end
    member do
      put :comment
    end
  end


  resources :blast_messages do
    collection do
      get :autocomplete_organization_name
      get :autocomplete_employee_name
    end
  end  
   
  resources :components do
  collection do
      put :update_component
      post :import
    end
  end

  resources :categories do
  collection do
      put :update_category
      post :import
    end
  end

  resources :photo_activities do
  collection do
      put :update_photo_activity
      post :import
    end
  end
  
  resources :selecteds

  resources :knowledges

  resources :knowledge_details

  resources :families do
    collection do
      put :update_family
    end
  end

  resources :employee_histories do
    collection do
      put :update_employee_histories
      post :import
    end
  end

  resources :employee_resigns

  resources :employee_working_datas do
    collection do
      put :update_employee_working_data
      post :import
    end
  end

  resources :salaries do
    collection do
      put :update_salary
      post :import
    end
  end

  resources :performances do
    collection do
      put :update_performance
    end
  end

  # resources :employees do
  #   member do
  #     patch :update_approval
  #     put :update_approval
  #   end
  #   collection do
  #     get :absence
  #     get :search_absence
      
  #   end
  # end

  resources :components

  resources :families do
    collection do
      put :update_family
    end
  end

  resources :position_details do
    collection do
      put :update_position_detail
      post :import
    end
  end

  resources :contracts do
    collection do
      put :update_contract
      post :import
    end
  end

  resources :training_histories do
    collection do
      put :update_training_history
      post :import
    end
  end

  resources :language_skills do
    collection do
      put :update_language_skill
      post :import
    end
  end

  resources :skills do
    collection do
      put :update_skill
      post :import
    end
  end

resources :violation_details do
    collection do
      put :update_violation_detail
      post :import
    end
  end

  resources :salaries do
    collection do
      put :update_salary
    end
  end

  resources :education_details do
    collection do
      put :update_education_detail
      post :import
    end
  end

  resources :external_work_experiences do
    collection do
      put :update_external_work_experience
      post :import
    end
  end

  resources :internal_work_experiences do
    collection do
      put :update_internal_work_experience
      post :import
    end
  end

  resources :history_of_organizations do
    collection do
      put :update_history_of_organization
      post :import
    end
  end

  resources :certifications do
    collection do
      put :update_certification
      post :import
    end
  end

  resources :performances do
    collection do
      put :update_performance
    end
  end

  resources :goal_values do
    collection do
      put :update_goal_value
      get :search
      get :autocomplete_goal_value
      post :import
    end
  end

    resources :goals do
    collection do
      put :update_goal
      get :search
      get :autocomplete_goal
      post :import
    end
  end

  resources :employees do
    collection do
      get :employee_working_datas
      get :new_employee_working_datas
      post :create_employee_working_datas
      get :employee_histories
      get :new_employee_histories
      post :create_employee_histories
      get :family_details
      get :new_family_details
      post :create_family_details
      get :new_personal_data
      post :create_personal_data
      get :account_setting
      patch :change_setting
      get :absence
      get :search_absence
    end
  end
  
  resources :divisions

  resources :absences do
    collection do
      post :check_in
      post :check_out
      post :permition
      get :search_employee
    end
  end

  resources :appraisals do
    collection do
      get :get_value
      get :goal
      get :value
      get :autocomplete_goal
      get :autocomplete_goal_value
    end
  end

  resources :leave_requests

  resources :overtime_requests
   
  resources :overtime_requests do
    collection do
      put :update_overtime_request
      post :import
    end
  end

  resources :interview_results do
    member do
      patch :update_status
      put :update_status
    end
  end

  resources :test_results do
    member do
      patch :update_status
      put :update_status
      patch :set_score
      put :set_score
    end
  end


  resources :approval_levels do
    collection do 
      get :autocomplete_employee_name
    end
  end

  resources :approval_employees 
  resources :code_of_conducts, only: [:index] do
    collection do
      post :index
      post :setup
    end
  end
  resources :media_socials

  # post '/add_user' => "users#create"
  # put "/profiles" => "users#update_profile"
  # get "/profile" => "users#profile"

  root 'dashboards#index'
  

resources :surveys do
    collection do
      post :filter
      get :filter

      post :get_view
      get :reload
      post :reorder
      get :question_list
      get "preview/:id" => "surveys#preview", as: :preview
      get :add_row
      get :remove_row
      get :question_detail
      get :question_page
      get :reset_session
      
      post :set_question
      get :edit_question
      get :add_question
      get "manage_question/:section" => "surveys#manage_question", as: :manage_question
      post "manage_question/:section" => "surveys#manage_question", as: :manage_question_post
      
      post :set_logical
      get :edit_logical
      get :add_logical
      get "manage_logical/:section" => "surveys#manage_logical", as: :manage_logical
      post "manage_logical/:section" => "surveys#manage_logical", as: :manage_logical_post
      
      post :set_page
      get :edit_page
      get :add_page
      get "manage_page/:section" => "surveys#manage_page", as: :manage_page
      post "manage_page/:section" => "surveys#manage_page", as: :manage_page_post
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
