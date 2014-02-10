class SessionsController < ApplicationController
  def new
    # renderöi kirjautumissivun
  end

  def create
    # haetaan usernamea vastaava käyttäjä tietokannasta
    user = User.find_by username: params[:username]
    if user.nil? or not user.authenticate params[:password]
      redirect_to :back, notice: "Username or password do not match!"
    else
      # talletetaan sessioon kirjautuneen käyttäjän id (jos käyttäjä on olemassa)
      session[:user_id] = user.id
      # uudelleen ohjataan käyttäjä omalle sivulleen
      redirect_to user, notice: "Welcome back! #{user.username}!"
    end
  end

  def destroy
    # nollataan sessio
    session[:user_id] = nil
    # uudelleenohjataan sovellus pääsivulle
    redirect_to :root
  end
end