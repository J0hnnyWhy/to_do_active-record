require('capybara/rspec')
require('./app')
require('pry')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('path to adding a new list', {:type => :feature}) do
  it('allows user to add new list from the home page') do
    visit('/')
    click_link('Add New List')
    fill_in('name', :with => 'Epicodus Work')
    click_button('Add List')
    expect(page).to have_content('Success!')
  end
end

describe('path to viewing all lists', {:type => :feature}) do
  it('allows user to click link and view all lists') do
    list = List.new({:name => 'Epicodus Homework', :id => nil})
    list.save()
    visit('/')
    click_link('View All Lists')
    expect(page).to have_content(list.name())
  end
end

describe('the path to viewing details of individual list item', {:type => :feature}) do
  it('allows user to click on list name and and view its details') do
    test_list = List.new({:name => 'Housework', :id => nil})
    test_list.save()
    test_task = Task.new({:description => 'vacuum', :list_id => test_list.id()})
    test_task.save()
    visit('/lists')
    click_link(test_list.name())
    expect(page).to have_content(test_task.description)
  end
end

describe('path to add a new task', {:type => :feature}) do
  it('allows the user to add a new task') do
    test_list = List.new({:name => 'schoolwork', :id => nil})
    test_list.save()
    visit("/lists/#{test_list.id()}")

    click_link('Add New Task')
    fill_in('description', :with => 'read')
    click_button('Add Task')
    expect(page).to have_content('Success!')

  end
end
