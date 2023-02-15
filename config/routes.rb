Rails.application.routes.draw do
  scope :v1 do
    resources :jobs, except: [:edit, :new]

    resources :companies, only: [:index, :create]
    get "/companies/search", to: "companies#search", as: "companies_search"

    resources :user_skills, except: [:new, :edit, :update]

    resources :skills, only: [:index]
    get "/skills/search", to: "skills#search", as: "skills_search"

    resources :resumes, except: [:edit, :new]

    mount_devise_token_auth_for "User", at: "auth"
  end
end
