namespace :images_update do
	desc "Update Images in the db."
  	task :db_images => [:environment] do
	    Dir.glob('public/m4m-images/*').each do |dir|
	    	client_ids = []
	    	masseur_ids = []
	    	photo_ids = []
	    	document_ids = []
	    	puts'the original masseur_ids', masseur_ids
	    	puts'the original client_ids', client_ids
	    	entity = dir.split('/').last
	    	if entity == 'clients'
		      	Dir.glob(dir+'/profile_photos/000/000/*').each do |client_photos|
		      		client_id = client_photos.split('/').last
		      		puts'Updating client Image',client_id
		      		begin
		      			client = Client.find(client_id.to_i)
		 				original_image = Dir.glob(client_photos+'/original/*')
			      		if client.present?
			      			client.update(profile_photo: open(original_image[0]))
			      			client_ids << client_id.to_i
			      		end
		      		rescue
		      			next
			      	end
		      	end
		      	(Client.all.ids - client_ids).each do |client_id|
		      		client = Client.find(client_id)
		      		client.update(profile_photo: nil)
		      	end
		      	puts'the client_ids', client_ids
		    elsif entity == 'masseurs'
		      	Dir.glob(dir+'/profile_photos/000/000/*').each do |masseur_photos|
		      		masseur_id = masseur_photos.split('/').last
		      		puts'Updating masseur Image',masseur_id
		      		begin
		      			masseur = Masseur.find(masseur_id.to_i)
		 				original_image = Dir.glob(masseur_photos+'/original/*')
			      		if masseur.present?
			      			masseur.update(profile_photo: open(original_image[0]))
			      			masseur_ids << masseur_id.to_i
			      		end
		      		rescue
		      			next
		      		end
		      	end
		      	(Masseur.all.ids - masseur_ids).each do |masseur_id|
	      			masseur = Masseur.find(masseur_id)
	      			masseur.update(profile_photo: nil)
	      		end
	      		puts'the masseur_ids', masseur_ids
			elsif entity == 'photos'
		      	Dir.glob(dir+'/pictures/000/000/*').each do |photos|
		      		photo_id = photos.split('/').last
		      		begin
		      			photo = Photo.find(photo_id.to_i)
		 				original_image = Dir.glob(photos+'/original/*')
		      			puts'Updating photo Image',photo_id
			      		if photo.present?
		      				photo.update(picture: open(original_image[0]))
		      				photo_ids << photo_id.to_i
			      		end
		      		rescue
		      			next
		      		end
		      	end
		      	(Photo.all.ids - photo_ids).each do |photo_id|
	      			photo = Photo.find(photo_id)
	      			photo.update(picture: nil)
	      		end
			elsif entity == 'masseur_documentations'
		      	Dir.glob(dir+'/*').each do |files|
		      		folder = files.split('/').last
		      		Dir.glob(files+'/000/000/*').each do |certi|
		      			document_id = certi.split('/').last
		      			begin
			      			document = MasseurDocumentation.find(document_id.to_i)
			      			original_image = Dir.glob(certi+'/original/*')
			      			if folder == 'certifications'
			      				puts"updating certifications", document_id
			      				document.update(certification: open(original_image[0]))
				      		elsif folder == 'licenses'
				      			puts"updating licenses", document_id
				      			document.update(license: open(original_image[0]))
				      		elsif folder == 'photo_ids'
				      			puts"updating photo_ids", document_id
				      			document.update(photo_id: open(original_image[0]))
				      		end
				      	rescue 
				      		next
				      	end
		      		end
		      	end
		    end
	    end

    end
end