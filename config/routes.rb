Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace 'api' do
    namespace 'v1' do
      resources :todos do
        collection do
          get :new_tasks
          get :inprogress_tasks
          get :done_tasks
        end
      end
    end
  end
end
