Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :users do
        get '/' => 'api_users#index'
        post '/' => 'api_users#create'
        get '/:name/' => 'api_users#show'
        put '/:name/' => 'api_users#update'
      end
    end
  end

end
