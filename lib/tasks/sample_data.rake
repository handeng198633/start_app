namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		admin = User.create!(name: "Oliver",
							email: "han.deng@ansys.com",
							password: "foobar",
							password_confirmation: "foobar",
							admin: true)
		users = User.all(limit: 1)
		50.times do
			content = Faker::Lorem.sentence(5)
			users.each { |user| user.microposts.create!(content: content) }
		end
	end
end