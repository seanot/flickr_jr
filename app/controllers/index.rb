get '/' do
  erb :index
end

get '/albums/:id' do
  @user = current_user
  @album = @user.albums.find(params[:id])
  erb :upload_album
end

get '/invalid_login' do
  @error = "Invalid email or password. Please try again."
  erb :index
end

get '/logout' do
  session.clear
  redirect to('/')
end

get '/photo/:id' do
  @photo = Photo.find(params[:id])
  @album = @photo.album
  @user = @photo.user
  erb :photo_view
end

get '/user/new' do
  erb :create_user
end

get '/user/new/error' do
  @error = "Invalid email or password. Please try again."
  erb :create_user
end

get '/user/:id' do
  @user = current_user
  @albums = @user.albums.all
  erb :album
end


#=======POST===========

post '/albums/create' do
  @album = Album.create(album_name: params[:album_name],
                          user_id: session[:user_id])
  redirect '/user/:id'
end

post '/albums/:id' do
  @photo = Photo.create(file: params[:image], album_id: params[:id])
  p @photo

  redirect "/albums/#{params[:id]}"
end

post '/login' do
  @user = User.authenticate(params[:email], params[:password])

  if @user
    session[:user_id] = @user.id
    redirect to("/user/#{@user.id}")
  else
    redirect to('/invalid_login')
  end
end
 
post '/photo/:id/delete' do
  @photo = Photo.find(params[:id])
  @album = @photo.album
  @photo.delete
  redirect "/albums/#{@album.id}"
end

post '/user/:id' do
  @user = User.create(params[:user])
  if @user.valid?
    session[:user_id] = @user.id
    @album = Album.create(album_name: 'Default', user_id: session[:user_id])
    redirect to("/user/#{@user.id}")
  else
    redirect to('/user/new/error')
  end
end



