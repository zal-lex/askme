# (c) goodprogrammer.ru
#
# Контроллер, управляющий пользователями. Должен уметь:
#
#   1. Показывать страницу пользователя
#   2. Создавать новых пользователей
#   3. Позволять пользователю редактировать свою страницу
#
class UsersController < ApplicationController
  # Это действие отзывается, когда пользователь заходит по адресу /users
  def index
    # Мы создаем массив из двух болванок пользователей. Для создания фейковой
    # модели мы просто вызываем метод User.new, который создает модель, не
    # записывая её в базу.
    @users = [
      User.new(
        id: 1,
        name: 'Vadim',
        username: 'installero',
        avatar_url: 'https://secure.gravatar.com/avatar/' \
          '71269686e0f757ddb4f73614f43ae445?s=100'
      ),
      User.new(id: 2, name: 'Misha', username: 'aristofun')
    ]
  end

  def new
  end

  def edit
  end

  # Это действие отзывается, когда пользователь заходит по адресу /users/:id,
  # например /users/1.
  def show
    # Болванка пользователя
    @user = User.new(
      name: 'Vadim',
      username: 'installero',
      avatar_url: 'https://secure.gravatar.com/avatar/' \
        '71269686e0f757ddb4f73614f43ae445?s=100'
    )

    # Болванка вопросов для пользователя
    @questions = [
      Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'В чем смысл жизни?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'Какой у тебя рост?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'Отку да ты?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'Где учился?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'Где работал?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'Бывал на море?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'А в горах?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'Нырял с аквалангом?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'Прыгал с парашютом?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'Сколько продержишься под водой?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'Катаешь на сноуборде?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'Любимое блюдо?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'Любимый алкогольный напиток?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'Любимый безалкогольный напиток?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'Какие языки программирования знаешь?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'А CSS и JS знаешь?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'В Rspec умеешь?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'Git и GitHub освоил?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'Коварный вопрос: что такое SCSS?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'ThinkPad или MacBook?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'Просто контрольный: android или ios?', created_at: Date.parse('27.03.2016'))
    ]

    # Болванка для нового вопроса
    @new_question = Question.new

    # Обратите внимание, пока ни одна из болванок не достается из базы
  end
end
