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
  before(:each) do
    @user = User.new(email: 'test@test.com', gender: 'other', password: 'ABC12345',
                     password_confirmation: 'ABC12345')
  end

  it 'is not valid without required attributes' do
    user = User.new
    expect(user).to_not be_valid
  end

  it 'is not valid without an email' do
    user = @user
    user.email = nil
    expect(user).to_not be_valid
  end

  it 'is not valid if the email is already registered' do
    User.create!(email: 'test2@test.com', gender: 'other', password: 'ABC12345',
                 password_confirmation: 'ABC12345')
    user = User.new(email: 'test2@test.com', gender: 'other', password: 'ABC12345',
                    password_confirmation: 'ABC12345')
    expect(user).to_not be_valid
  end

  it 'is not valid without a gender' do
    user = @user
    user.gender = nil
    user.save!
    expect(user).to_not be_valid
  end

  it 'is not valid without a password' do
    user = @user
    user.password = nil
    expect(user).to_not be_valid
  end

  it 'is not valid if password and password_confirmation are not the same' do
    user = @user
    user.password = 'ABC'
    expect(user).to_not be_valid
  end
end
