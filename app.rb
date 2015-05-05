require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/task')
require('./lib/list')
require('pg')

DB = PG.connect({:dbname => "to_do"})

get('/') do
  erb(:index)
end

get('/lists/new') do
  erb(:list_form)
end

get('/lists') do
  @lists = List.all()
  erb(:lists)
end

get('/lists/:id') do
 @list = List.find(params.fetch("id").to_i())
 # @tasks = Task.all()
 erb(:list)
end

post('/lists') do
  name = params.fetch("name")
  new_list = List.new({:name => name, :id => nil})
  new_list.save()
  erb(:success)
end

get('/lists/:id/tasks/new') do
  @list = List.find(params.fetch("id").to_i())
  erb(:task_form)
end

post('/tasks') do
  description = params.fetch("description")
  list_id = params.fetch("list_id").to_i()
  @list = List.find(list_id)
  @task = Task.new(:description => description, :list_id => list_id)
  @task.save()

  # @list.add_task(@task)
  erb(:success)
end
