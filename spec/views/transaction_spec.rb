require 'rails_helper'

RSpec.describe 'Testing category views', type: :feature do
  describe 'Category#index' do
    before(:each) do
      user = User.create(name: 'Tom', email: 'tommy@example.com', password: 'password')
      category = user.groups.create(name: 'Bag', icon: 'https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg?auto=compress&cs=tinysrgb&w=600') 

      visit new_user_session_path
      fill_in 'Email', with: 'tommy@example.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
      visit category_transactions_path(category)
    end

    it 'should be able to see Add New Transaction Link on page' do
      within('body') do
        expect(page).to have_link('Add a new transaction')
      end
    end
  end
end