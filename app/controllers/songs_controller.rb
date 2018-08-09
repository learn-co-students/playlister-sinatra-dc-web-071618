class SongsController < ApplicationController
    use Rack::Flash
    
    get '/songs' do 
        @songs = Song.all 
        erb :'songs/index'
    end

    post '/songs' do 

        artist = Artist.find_or_create_by(name: params[:song][:artist][:name])
        song = Song.create(name: params[:song][:name], artist: artist)
        params[:song][:genres].each do |genre_id|
            song.genres << Genre.find(genre_id)
        end
        flash[:message] = "Successfully created song."
        # binding.pry
        redirect to "/songs/#{song.slug}"
    end

    get '/songs/new' do 
        @genres = Genre.all
        erb :'songs/new'
    end

    get '/songs/:slug' do 
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/show'
    end

    get '/songs/:slug/edit' do 
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/edit'
    end

    patch '/songs/:slug' do 
        # binding.pry
        @song = Song.find_by_slug(params[:slug])

        @song.update(name: params[:song][:name])
        # binding.pry
        if !params[:song][:artist][:name].empty?
            @song.artist = Artist.find_or_create_by(name: params[:song][:artist][:name])
        end
        params[:song][:genres].each do |genre_id|
            @song.genres << Genre.find(genre_id) unless @song.genres.map{|genre|genre.id}.include?(genre_id)
        end
        # binding.pry
        @song.save
        flash[:message] = "Successfully updated song."
        redirect to "/songs/#{@song.slug}"
    end
end