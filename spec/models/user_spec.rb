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
    expect(user).to_not be_valid
  end

  # it 'is not valid if gender has a value not valid' do
  #   user = User.new(email: 'test@test.com', gender: 'X', password: 'ABC12345',
  #   password_confirmation: 'ABC12345')
  #   expect(user).to raise_error(ArgumentError, /'X' is not a valid gender/)
  # end

  it 'is not valid without a password' do
    user = @user
    user.password = nil
    expect(user).to_not be_valid
  end

  it 'is not valid without a password_confirmation' do
    user = @user
    user.password_confirmation = nil
    expect(user).to_not be_valid
  end

  it 'is not valid if password and password_confirmation are not the same' do
    user = @user
    user.password = 'ABC'
    expect(user).to_not be_valid
  end
end
