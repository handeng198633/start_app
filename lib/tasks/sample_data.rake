namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		admin = User.create!(name: "Oliver",
							email: "han.deng@ansys.com",
							password: "foobar",
							password_confirmation: "foobar",
							admin: true)
	end
end