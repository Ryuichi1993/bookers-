namespace :mail do
	
	task :send_ivate_to_user do
		NotificationMailer.send_ivate_to_user

end
end
