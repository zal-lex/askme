class UsersController < ApplicationController
  def index
  end

  def new
  end

  def edit
  end

  def show
  	@user = User.new(
  	  name: 'Lex',
  	  username: 'zal-lex',
  	  avatar_url: 'https://secure.gravatar.com/avatar/0cf1881e88da48980e84bb90161b878f'
  		)
  end
end
