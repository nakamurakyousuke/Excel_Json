Rails.application.routes.draw do

  root 'excel_jsons#index'

	get 'excel_jsons', to:'excel_jsons#index'
	get 'excel_jsons/show', to:'excel_jsons#show'
	post 'excel_jsons/show', to:'excel_jsons#show'

  post 'excel_jsons/create', to:'excel_jsons#create'

end
