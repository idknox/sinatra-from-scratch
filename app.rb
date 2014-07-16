require "sinatra"
require "sinatra/content_for"
require "active_record"
require "gschool_database_connection"
require "rack-flash"
require "date"

class App < Sinatra::Application
  helpers Sinatra::ContentFor
  enable :sessions
  use Rack::Flash

  def initialize
    super
    @database_connection = GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"])
  end

  get "/" do
    erb :home, :locals => {:users => get_users}
  end

  post "/" do
    @database_connection.sql(
      "INSERT INTO users (email, password) VALUES ('#{params[:email]}', '#{params[:password]}')"
    )
    flash[:notice] = "Thank you for registering"
    redirect "/"
  end

  private

  def get_users
    @database_connection.sql(
      "SELECT email FROM users"
    )
  end
end