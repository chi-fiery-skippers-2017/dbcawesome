require 'faker'

users_desired = 25
users_available = User.all.count

(users_desired - users_available).times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  username = "#{first_name}.#{last_name}"
  email = Faker::Internet.safe_email(username)

  user = User.create(username: username, email: email, password: "password")

  rand(1..10).times do
    question = Question.new(title: "#{Faker::Beer.name}?", body: Faker::Hipster.sentence(rand(20..50)), author: user)
    question.save

    rand(1..5).times do
      question.comments << Comment.new(commenter_id: rand(1..users_desired), body: Faker::Hipster.sentence(rand(10-20)))
    end

    rand(1..7).times do
      answer = Answer.new(author_id: rand(1..users_desired), question: question, body: Faker::Hipster.sentence(rand(15..35)))
      answer.save

      rand(1..5).times do
        answer.comments << Comment.new(commenter_id: rand(1..users_desired),  body: Faker::Hipster.sentence(rand(10-20)))
      end

    end
  end

end
