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
    list = List.new({:name => 'Housework', :id => nil})
    list.save()
    visit('/lists')
    click_link('Housework')
    expect(page).to have_content('Add New Task')
  end
end
