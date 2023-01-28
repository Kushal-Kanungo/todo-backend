Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :todos, defaults: {format: :json}  do
        collection do
          get :new_tasks
          get :inprogress_tasks
          get :done_tasks
        end
      end
    end
  end
end
