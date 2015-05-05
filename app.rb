require('sinatra')
#set :bind, '0.0.0.0'
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
 erb(:list)
end

post('/lists') do
  name = params.fetch("name")
  new_list = List.new({:name => name, :id => nil})
  new_list.save()
  erb(:success)
end

# post('/tasks') do
#   description = params.fetch('description')
#   task = Task.new(description)
#   task.save()
#   erb(:success)
# end
