Rails.application.routes.draw do

  scope '/api' do
    scope '/v1' do
      scope '/users' do
        get '/' => 'api_users#index'
        post '/' => 'api_users#create'
        scope '/:name' do
          get '/' => 'api_users#show'
          put '/' => 'api_users#update'
        end
      end
    end
  end

end
