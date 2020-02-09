class UsersController < ApplicationController
  before_action :load_user, except: [:index, :create, :new, :destroy]
  before_action :authorize_user, except: [:index, :new, :create, :show, :destroy]

  def index
    @users = User.all.order(id: :desc)
  end

  def new
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new
  end

  def edit
  end

  def create
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: 'Пользователь успешно создан!'
    else
      render 'new'
    end  
  end

  def update

    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Данные обновлены'
    else
      render 'edit'
    end  
  end

  def show
    # Достаем вопросы пользователя с помощью метода questions, который мы
    # объявили в модели User (has_many :questions), у результата возврата этого
    # метода вызываем метод order, который отсортирует вопросы по дате.
    @questions = @user.questions.order(created_at: :desc)

    # Для формы нового вопроса, которая есть у нас на странице пользователя,
    # создаем болванку вопроса, вызывая метод build у результата вызова метода
    # @user.questions.
    @new_question = @user.questions.build

    # Считаем общее количество вопросов, количество отвеченных и количество 
    # не отвеченных вопросов.
    @questions_count = @questions.count
    @unanswered = @questions.where(answer: nil).count
    @answered = @questions_count - @unanswered

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Ваш профиль удалён :('
  end

  private

  def authorize_user
    reject_user unless @user == current_user
  end

  def load_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username, :avatar_url, :color_code)
  end
end
