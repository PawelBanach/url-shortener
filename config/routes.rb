Rails.application.routes.draw do
  scope module: :api do
    scope module: :v1 do
      post "/shorten", to: 'urls#shorten', as: 'shorten'
      get '/:key', to: 'urls#redirect', as: 'redirect'
    end
  end
end
