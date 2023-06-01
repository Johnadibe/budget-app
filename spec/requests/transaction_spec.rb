require 'rails_helper'

RSpec.describe 'Transactions', type: :request do
  describe 'GET categories#index' do
    before(:each) do
      user = User.create name: 'John', email: 'johnadibe1234@example.com', password: '111111'
      post user_session_path, params: { user: { email: user.email, password: user.password } }
      @category = Group.create(name: 'Bag',
                               icon: 'https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg?auto=compress&cs=tinysrgb&w=600',
                               user_id: user.id)
      @transaction = Operation.create(name: 'Bobby', amount: 12, user_id: user.id)
      get category_transactions_path(@category)
    end

    it 'should return http success' do
      expect(response).to have_http_status(:success)
    end

    it 'should render correct template' do
      expect(response).to render_template(:index)
    end

    it "should render page contenting 'Transaction'" do
      expect(response.body).to include('Transaction')
    end
  end
end
