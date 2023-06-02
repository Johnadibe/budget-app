require 'rails_helper'

RSpec.describe 'Testing category views', type: :feature do
  describe 'Category#index' do
    before(:each) do
      user = User.create(name: 'Tom', email: 'tommy@example.com', password: 'password')
      (1..5).each { |i| user.groups.create(name: "Test category #{i}", icon: 'https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg?auto=compress&cs=tinysrgb&w=600') }

      visit new_user_session_path
      fill_in 'Email', with: 'tommy@example.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
      visit categories_path
    end

    it 'can see all the category' do
      expect(page).to have_content 'Test category 1'
      expect(page).to have_content 'Test category 2'
      expect(page).to have_content 'Test category 3'
      expect(page).to have_content 'Test category 4'
      expect(page).to have_content 'Test category 5'
    end

    it 'should be able to see Add New Category Link on page' do
      within('body') do
        expect(page).to have_link('Add New Category')
      end
    end
  end
end
