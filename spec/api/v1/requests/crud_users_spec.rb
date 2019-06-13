require 'rails_helper'

describe "User" do
  context "Create" do
    it 'can be created with good credentials' do
      user_credentials = {first_name: "Billy", 
                          last_name: "Joel", 
                          ssn: "123456789",
                          email: "email@gmail.com"}
      post api_v1_users_path(user_credentials)

      user = User.find_by(email: "email@gmail.com")
      expect(response.body).to include(user.email)
    end

    it 'cannot be created with bad credentials' do
      user_credentials = {first_name: "Billy", 
                          last_name: "Joel", 
                          ssn: "123456789",
                          email: "email"}
      post api_v1_users_path(user_credentials)

      expect(response.body).to include("Email is invalid")
    end

    it 'can be created with hyphenated social security number' do
      user_credentials = {first_name: "Billy", 
                          last_name: "Joel", 
                          ssn: "123-45-6789",
                          email: "email@gmail.com"}

      post api_v1_users_path(user_credentials)

      user = User.find_by(email: "email@gmail.com")
      
      expect(response.body).to include(user.email)
    end
  end

  context "Read" do
    it 'can render a json of each user' do 
      user1_credentials = {first_name: "Billy", 
                          last_name: "Joel", 
                          ssn: "123456789",
                          email: "email@gmail.com"}
      user2_credentials = {first_name: "Elton", 
                          last_name: "John", 
                          ssn: "987654321",
                          email: "tiny_danc3r@gmail.com"}

      user1 = User.create(user1_credentials)
      user2 = User.create(user2_credentials)

      get api_v1_users_path

      expect(response.body).to include(user1.email)
      expect(response.body).to include(user2.email)
      expect(response.body).to_not include("ssn")
    end
  end
  
end
