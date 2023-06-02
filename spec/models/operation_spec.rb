require 'rails_helper'
RSpec.describe Operation, type: :model do
  let(:user) { User.create(name: 'John Adibe', email: 'example@mail.com', password: 'password') }
  let(:group) { Group.create(name: 'Bag', icon: 'https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg?auto=compress&cs=tinysrgb&w=600', user_id: user.id) }
  let(:operation) { Operation.create(name: 'Bobby', amount: 12, user_id: user.id) }
  let(:money_group) { MoneyGroup.create(group_id: group.id, operation_id: operation.id) }

  describe 'Validations' do
    context 'when valid' do
      it { expect(operation).to be_valid }
    end

    it 'valid money_group' do
      expect(money_group).to be_valid
    end

    it 'should valid name ' do
      operation.name = nil
      expect(operation).to_not be_valid
    end
    it 'should valid amount ' do
      operation.amount = -10
      expect(operation).to_not be_valid
    end
    it 'should valid amount ' do
      operation.amount = 10
      expect(operation).to be_valid
    end
  end
end
