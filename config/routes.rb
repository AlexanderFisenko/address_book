Rails.application.routes.draw do
  root 'contacts#index'
  resources :contacts do
    collection do
      post :import
      get :export
    end
  end
end
