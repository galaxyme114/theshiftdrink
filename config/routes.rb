Rails.application.routes.draw do
	get '/.well-known/acme-challenge/Gcl13AN0SUH1veBZY_05y2Yv-WUWno3N5fG_2oV7h8A' => 'welcome#letsencrypt'
	get '/loaderio-89df6155f1caf8969ffbbc4eb70e9951/' => 'welcome#loaderio'
	get '/loaderio-89df6155f1caf8969ffbbc4eb70e9951.html' => 'welcome#loaderio'
	get '/loaderio-89df6155f1caf8969ffbbc4eb70e9951.txt' => 'welcome#loaderio'

  devise_for :users, scope: :admin, path: 'admin', skip: [:registrations, :omniauth_callbacks]

	get '/issue-desktop', to: redirect('/')
	get '/issue-mobile/:id', to: redirect('/m-issue/%{id}')
	get '/issue-desktop/:id', to: redirect('/issue/%{id}')
	get '/issue-archive', to: redirect('/')
	get '/archive-desktop/:id', to: redirect('/archives/%{id}')
	get '/archive-mobile/:id', to: redirect('/m-archives/%{id}')

  scope :admin, :module => 'admin' do
    resources :materials
		resources :author
		resources :comments

    resources :issues do
      resources :articles, except: [:index, :show, :new] do
        collection { patch :sort }
      end
    end

    scope :path => '/issues/:issue_id/:article_id' do
      resources :pages, except: [:show] do
        collection { patch :sort }

        delete 'thumbnail' => 'pages#remove_thumb', as: :remove_thumb

        resources :hyperlinks
      end

      resources :media, except: [:show] do
        collection { patch :sort }
      end

      post 'media/multiple' => 'media#multiple', as: :multiple_media
    end

    resources :analytics

    resources :users

    scope :account do
      get   'settings' => 'account#index',    as: :account_settings
      patch 'password' => 'account#password', as: :account_password
      patch 'profile'  => 'account#profile',  as: :account_profile
    end

    get '/' => 'issues#index'
  end

  namespace :api do
    namespace :v1 do
      resources :issues, only: [] do
        resources :pages, only: [:index, :show], param: :position
      end
    end
  end

  devise_for :users, only: [:omniauth_callbacks], path: '', controllers: { omniauth_callbacks: "auth/omniauth_callbacks" }

  resources :comments

  resources :materials, path: 'm', only: [] do
    get '(:id)' => 'materials#show', as: :show
  end

  resources :issues, path: '', only: [] do
    get 'advertisement' => 'issues#advertisement', as: :advertisement
    get 'interstitial'  => 'issues#interstitial',  as: :interstitial

    get '/preview/(:id)' => 'issues#previewed', as: :previewed
    get '(:id)' => 'issues#published', as: :published

    get '/:article_id/gallery' => 'issue_media#index', as: :gallery
  end
  root 'issues#published'

end
