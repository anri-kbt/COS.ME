Rails.application.routes.draw do
  
  devise_for :admins, skip:[:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  devise_for :customers, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  namespace :admin do
    resources :customers ,only:[:index,:edit,:show,:update,:destroy]
    resource :cosmetics ,only:[:destroy]
    resource :cosme_comments ,only:[:destroy]
  end
  scope module: :public do 
    resources :customers ,only:[:index,:show,:edit,:update]
    get 'customers/withdrawal' => 'customers#withdrawal'
    patch 'customers/out/:id' => 'customers#out',as: :out
    
    root :to =>"homes#top"
    get 'homes/about'
    resources :cosmetics
    resource :categories ,only:[:index]
    resource :brands ,only:[:index]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
