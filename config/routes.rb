require 'resque_web'

Rails.application.routes.draw do
  # Mailboxer
  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post 'reply'
    end
    
    collection do
      get 'sent'
      get 'trash'
    end
  end

  resources :messages, only: [:new, :create]

  get 'subscriptions/new'

  devise_for :admins, controllers: {
    sessions: 'admin/sessions'
  }
  
  devise_for :clients, controllers: {
    registrations: 'clients/registrations',
    sessions: 'shared_devise/sessions',
    passwords: 'shared_devise/passwords'
  }
  
  devise_for :masseurs, controllers: {
    registrations: 'masseurs/registrations',
    sessions: 'shared_devise/sessions',
    passwords: 'shared_devise/passwords'
  }
  
  # for shared forms
  devise_scope :client do
    get '/login' => 'shared_devise/sessions#new'
    delete '/logout' => 'shared_devise/sessions#destroy'
  end
  
  devise_scope :masseur do
    get '/login' => 'shared_devise/sessions#new'
    delete '/logout' => 'shared_devise/sessions#destroy'
  end
  match 'admin/emails/send_email' => 'admin/emails#send_email', :via => :post
  namespace :admin do
    root 'dashboard#index'

    resque_web_constraint = lambda do |request|
      current_user = request.env['warden'].user
      current_user.present? && current_user.kind_of?(Admin)
    end

    constraints resque_web_constraint do
      mount ResqueWeb::Engine => "/resque"
    end
    
    resources :tracking_links
    resources :emails
     
    
    resources :reviews do
      member do
        get 'approve'
        get 'reject'
      end
    end
    
    resources :masseur_documentations do
      member do
       post 'approve'
       post 'deny' 
      end
    end

    resources :photos do
      collection do
        get 'approval_queue'
      end
      
      member do
        post 'approve'
        post 'approve_as_adult'
        post 'deny'
      end
    end
    
    resources :promo_codes do
      member do
        post 'activate'
        post 'deactivate'
      end
    end
    
    resources :subscriptions
    
    resources :masseurs do
      collection do
        get 'approval_queue'
        get 'search'
        get  'blocked_history'
        get 'suspended_history'
        get 'uncompleted_profile'
        get 'send_bulk_reminder'
        get 'site_setting_report'
      end
      
      member do
        post 'upload_photo'
        post 'approve'
        post 'unapprove'
        post 'deny'
        post 'suspend'
        post 'unsuspend'
        post  'unblock'
        get 'impersonate'
        get 'send_reminder'
        delete 'unimpersonate'   
      end
    end
    
    resources :clients do
      collection do
        get 'search'
      end
      
      member do
        get 'impersonate'
        delete 'unimpersonate'
        
        post 'suspend'
        post 'unsuspend'
      end
    end
    
    
    # DEMOGRAPHIC MANAGERS AND STUFF
    resources :airports
    resources :body_hairs
    resources :builds
    resources :drug_frequencies
    resources :ethnicities
    resources :eye_colors
    resources :hair_colors
    resources :languages
    resources :sexual_orientations
    resources :smoking_frequencies
    resources :site_setting_logs
    resources :static_pages
    resources :site_settings
  end
  # END ADMIN NAMESPACE
  
  post 'ads/search' => 'ads#search'
  get 'ads/search' => 'ads#search'
  
  post 'subscriptions/postback' => 'subscriptions#postback'
  
  post 'promo_codes/check' => 'promo_codes#check'
  

  resources :clients, only: [:show] do
    member do
      # /dashboard aliases to clients/edit
      devise_scope :client do
        get '/dashboard' => 'clients/registrations#edit'
      end      
      get 'favorites'
      get 'reviews'      

      get 'upload_profile_photo'
    end
  end
  
  resources :masseurs, only: [:show] do
    member do      
      get 'dashboard'
      get 'become_available'
      post 'toggle_availability'

      post 'favorite'
      post 'defavorite'     

      get 'notifications'

      get 'upload_profile_photo'
      
      # Dynamic routes for massage types, so we can add new ones
      # MassageType.find_each do |type|
      #   formatted_type = type.name.downcase
        
      #   # get formatted_type, as: "#{formatted_type}_ad"
      # end
    end
    
    resource :masseur_documentation
    
    # collection do
    #   get 'available_now'
    # end
    
    resource :masseur_detail do
      resources :rates
    end
    
    resources :photos, shallow: true do
      collection do
        get 'manage'
      end
    end
    
    resources :ads do
      collection do
        get 'manage'
        get 'therapeutic', to: 'ads#therapeutic'
        get 'relaxation', to: 'ads#relaxation'
        get 'sensual', to: 'ads#sensual'
        get 'customized', to: 'ads#customized'
      end
      
      member do
        get 'show_new'
      end
    end
    
    resources :travel_ads
    
    resources :reviews do
      get 'approve'
      get 'deny'
    end
    
    resources :subscriptions, shallow: true do
      collection do
        get 'success'
        get 'failure'        
      end
    end
    
    collection do      
      get 'switch_to_premium'
      
      get 'me'
    end
  end
  
  ## Static pages

  # Tracking Links
  get '/r/:refer' => 'static_pages#show', id: 'advertise-with-us'

  get '/signup' => 'static_pages#signup'
  get '/get_location' => 'static_pages#get_location'
  get '/country_info' => 'static_pages#country_info'
  get '/advertise' => 'static_pages#advertise'
  get '/contact' => 'static_pages#contact'
  post '/contact' => 'static_pages#contact'
  
  # # Dynamically map all StaticPages
  get '/:id', to: 'static_pages#show'

  root 'static_pages#home'
end
