require 'rails_helper'
RSpec.describe Group, type: :model do
  let(:user) { User.create(name: 'John Adibe', email: 'example@mail.com', password: 'password') }
  let(:group) { Group.create(name: 'Bag', icon: 'https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg?auto=compress&cs=tinysrgb&w=600', user_id: user.id) }

  describe 'Validations' do
    context 'when valid' do
      it { expect(group).to be_valid }
    end

    it 'should allow valid name' do
      group.name = 'Eg'
      expect(group).to_not be_valid
    end

    it 'should allow valid name' do
      group.name = 'Outing'
      expect(group).to be_valid
    end

    it 'should allow valid user_id' do
      group.user_id = nil
      expect(group).to_not be_valid
    end
  end
end
