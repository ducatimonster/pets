Rails.application.routes.draw do

  get 'reports/new_clients'

  get 'reports/return_visit'

  get 'reports/expired_rabies'
  get 'reports/incidents'

  get 'groomings/pet_grooming_index'

  get 'shot_records/pet_shot_record_index'

  get 'pets/show'

  get 'incidents/show'

  get 'clients/show'

  get 'pet_image_repos/pet_image_index'



  #
  # resources :pet_image_repos

  # resources :pet_image_repos
  resources :autocompletes

  resources :pages
  resources :colors do
    collection do
      post 'import'
    end
  end
  resources :grooming_services do
    collection do
      post 'import'
    end
  end
  resources :groomings do
    collection do
      post 'import'
    end
  end
  resources :note_types do
    collection do
      post 'import'
    end
  end
  resources :pet_breeds do
    collection do
      post 'import'
    end
  end
  resources :shot_records do
    collection do
      post 'import'
    end
  end
  resources :notes do
    collection do
      post 'import'
    end
  end
  resources :vaccinations do
    collection do
      post 'import'
    end
  end
  resources :pets do
    collection do
      post 'import'
    end
  end
  resources :pets do
    collection do
      post 'import'
    end
  end
  resources :pets do
    collection do
      post 'import'
    end
  end
  resources :authorized_people do
    collection do
      post 'import'
    end
  end
  resources :clients do
    collection do
      post 'import'
    end
  end
  resources :employee_services do
    collection do
      post 'import'
    end
  end
  resources :services do
    collection do
      post 'import'
    end
  end
  resources :employees do
    collection do
      post 'import'
    end
  end
  resources :breeds do
    collection do
      post 'import'
    end
  end
  resources :incidents do
    collection do
      post 'import'
    end
  end
  resources :pet_incidents do
    collection do
      post 'import'
    end
  end
  resources :reports do
    collection do
      post 'import'
    end
  end
  resources :pet_image_repos do
    collection do
      post 'import'
    end
  end


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'groomings#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable
  # Example resource route within a namespace:



  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
