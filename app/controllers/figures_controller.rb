class FiguresController < Sinatra::Base

  set :views, Proc.new { File.join(root, "../views/") }
  register Sinatra::Twitter::Bootstrap::Assets

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/new'
  end

  post '/figures' do
    figure = Figure.create(name: params[:figure][:name])
    figure.update(title_ids: params[:figure][:title_ids])
    figure.update(landmark_ids: params[:figure][:landmark_ids])

    if params[:title][:name] != ""
      figure.titles << Title.create(name: params[:title][:name])
    end

    if params[:landmark][:name] != ""
      figure.landmarks << Landmark.create(name: params[:landmark][:name])
    end

    redirect to "figures/#{figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(name: params[:figure][:name], title_ids: params[:title_ids], title_ids: params[:landmark_ids])

    if params[:landmark][:name] != ""
      @figure.landmarks << Landmark.create(name: params[:landmark][:name])
    end

    if params[:title][:name] != ""
      @figure.landmarks << Title.create(name: params[:title][:name])
    end

    redirect to "figures/#{@figure.id}"
  end
end
