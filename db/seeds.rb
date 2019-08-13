# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

MULTIPLE_CHOICE = 0
seed_data = {
  user1: {
    email: "thor123@gmail.com",
    first_name: "Thor",
    last_name: "Odinson",
    password: "thor123",
    password_confirmation: "thor123",
    confirmed_at: Time.now
  }
}

user1 = User.new(seed_data[:user1])
user1.skip_confirmation!
user1.save!

3.times do
  quiz = Quiz.new(title: Faker::Space.star_cluster, description: Faker::Lorem.paragraph(20, true, 20), user: user1 )

  3.times do
    deck = Deck.create(title: Faker::Space.galaxy, description: Faker::Lorem.paragraph(20, true, 20), user: user1)

    10.times do
      question = Question.new(question_type: MULTIPLE_CHOICE, text: Faker::Lorem.question(3, true, 12), deck: deck,
        description: Faker::Lorem.paragraph(10))

      question.choices << Choice.new(text: Faker::Superhero.power, truth_value: true, question: question)

      3.times do 
        question.choices << Choice.new(text: Faker::Superhero.power, truth_value: false, question: question)
      end
      
      question.save!
    end

    quiz.decks << deck
  end

  quiz.save!
end
