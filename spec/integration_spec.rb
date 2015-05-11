require('capybara/rspec')
require('./app')
require('pry')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('path to making/editing lists and making tasks', {:type => :feature}) do
  it('allows user to add new list from the home page') do
    visit('/')
    click_link('Add new list')
    fill_in('name', :with => 'Epicodus Work')
    click_button('Add List')
    expect(page).to have_content('Success!')
  end

  it('allows user to click on a list and see it"s tasks') do
    test_list = List.new({:name => 'Housework', :id => nil})
    test_list.save()
    test_task = Task.new({:description => 'vacuum', :list_id => test_list.id()})
    test_task.save()
    visit('/')
    click_link('Housework')
    expect(page).to have_content(test_task.description)
  end

  it('allows user to click on Update this list and update and individual list') do
    test_list = List.new({:name => 'Housework', :id => nil})
    test_list.save()
    test_task = Task.new({:description => 'vacuum', :list_id => test_list.id()})
    test_task.save()
    visit('/')
    click_link('Update this list')
    expect(page).to have_content(test_list.name)
    fill_in('name', :with => 'homework')
    click_button('Update List')
    expect(page).to have_content('Success!')
    click_link('Back')
    expect(page).to have_content('homework')
  end

  it('allows the user to add a new task toa specific list') do
    test_list = List.new({:name => 'birds', :id => nil})
    test_list.save()
    test_task = Task.new({:description => 'vacuum', :list_id => test_list.id()})
    test_task.save()
    visit('/')
    click_link('birds')
    visit("/lists/#{test_list.id()}")
    click_link('Add New Task')
    fill_in('description', :with => 'read')
    click_button('Add Task')
    expect(page).to have_content('Success!')
  end

end
