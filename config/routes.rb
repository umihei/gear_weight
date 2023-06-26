Rails.application.routes.draw do
  # 一旦，山行一覧をルートに
  root "mntevents#index"
  
  # sign upはユーザ名を登録するためにカスタムしている
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  # ブラウザからGETでログアウトするためにDeleteをGetで上書き
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  
  resources :mntevents
  
  resources :gears
  
end
