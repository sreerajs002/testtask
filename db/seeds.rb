# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
begin
	# unless user = User.create!(name:'Sreeraj', email:'sreeraj.siddantam@gmail.com', password: ENV["SA_PASS"], password_confirmation: ENV["SA_PASS"], role: UsersHelper::SuperAdminUser)
	# 	raise user.errors.full_messages.to_a.join(',')
	# end	
	unless user = User.create!(name:'Sreeraj', email:'sreeraj@gmail.com', password: ENV["SA_PASS"], password_confirmation: ENV["SA_PASS"], role: UsersHelper::ParticipantUser)
		raise user.errors.full_messages.to_a.join(',')
	end
rescue => e 
	puts "Error: #{e}"
end