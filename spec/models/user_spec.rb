# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  gender                 :integer
#  image                  :string
#  name                   :string
#  nickname               :string
#  provider               :string           default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  tokens                 :json
#  uid                    :string           default(""), not null
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build :user }

  it 'is valid with required attributes' do
    expect(user).to be_valid
  end

  it 'is not valid without email' do
    user.email = nil
    expect(user).to_not be_valid
  end

  it 'is not valid with a invalid gender' do
    expect { build(:user, gender: :wrong) }
      .to raise_error(ArgumentError)
      .with_message(/'wrong' is not a valid gender/)
  end

  context 'is not valid if the email is already registered' do
    let(:existed_user) { create :user }
    let(:newuser) { build :user, email: existed_user.email }

    it 'should return email already registered' do
      expect(newuser).to be_invalid
    end
  end

  it 'is not valid without a password' do
    user.password = nil
    expect(user).to_not be_valid
  end

  it 'is not valid if password and password_confirmation are not the same' do
    user.password = 'ABC'
    expect(user).to_not be_valid
  end
end
