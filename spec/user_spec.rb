require 'user'

describe User do
  it 'creates a new user' do
    user = User.create(email: 'test@example.com', password: 'password123')

    persisted_data = persisted_data(table: 'users', id: user.id)

    expect(user).to be_a User
    expect(user.email).to eq 'test@example.com'
    expect(user.id).to eq persisted_data.first['id']
  end

  it 'finds a user by id' do
    user = User.create(email: 'test@example.com', password: 'password123')
    result = User.find(user.id)

    expect(result.id).to eq user.id
    expect(result.email).to eq user.email
  end

  describe '.find' do
    it 'returns nil if there is no ID given' do
      expect(User.find(nil)).to eq nil
    end
  end
end
