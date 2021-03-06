
require('sinatra')
require('sinatra/reloader')
require("sinatra/activerecord")
also_reload('lib/**/*.rb')
require('./lib/task')
require('./lib/list')
require('pg')
require('pry')


get('/') do
  @lists =List.all()
  erb(:index)
end

post('/tasks') do
  description = params.fetch("description")
  list_id = params.fetch("list_id").to_i()
  @list = List.find(list_id)
  @task =Task.new(:description => description, :done => false, :list_id => list_id)
  @task.save()
  erb(:success)
end

get ('/tasks/:id/edit') do
  @task = Task.find(params.fetch("id").to_i())
  erb(:task_edit)
end

patch('/tasks/:id') do
  description = params.fetch("description")
  @task = Task.find(params.fetch("id").to_i())
  @task.update({:description => description})
  @tasks = Task.all()
  @lists = List.all()
  erb(:index)
end

delete("/tasks/:id") do
  @task = Task.find(params.fetch("id"))
  @task.delete()
  @tasks =Task.all()
  erb(:success)
end

get('/lists/:id/tasks/new') do
  @list = List.find(params.fetch("id").to_i())
  erb(:task_form)
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
  @tasks = @list.tasks
  erb(:list)
end

get ('/lists/:id/edit') do
  @list = List.find(params.fetch("id").to_i())
  erb(:list_edit)
end

delete('/lists/:id') do
  @list = List.find(params.fetch("id"))
  @list.delete()
  @lists =List.all()
  erb(:index)
end

patch('/lists/:id') do
  name = params.fetch("name")
  @list = List.find(params.fetch("id").to_i())
  @list.update({:name => name})
  @lists = List.all()
  erb(:success)
end


post('/lists') do
  name = params.fetch("name")
  new_list = List.new({:name => name, :id => nil})
  new_list.save()
  erb(:success)
end
