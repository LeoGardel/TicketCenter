json.extract! project, :id, :name, :description, :start_date, :manager_id, :created_at, :updated_at
json.url project_url(project, format: :json)
