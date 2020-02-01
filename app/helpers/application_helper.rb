# В этом файле мы можем писать вспомогательные методы (хелперы) для
# шаблонов (view) нашего приложения.
module ApplicationHelper
  # Этот метод возвращает ссылку на автарку пользователя, если она у него есть.
  # Или ссылку на дефолтную аватарку, которая лежит в app/assets/images
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end
  # Этот метод будет склонять слова. Для примера используем слово "енот"
	def inclination(number, enot, enota, enotov)
	  # Если ничего не ввели или ввели не число, считаем, что ввели 0
	  if (number == nil || !number.is_a?(Numeric))
	    number = 0
	  end

	  # Обрабатываем особенный интервал, где также множественное число
	  if (11..14).include?(number % 100)
	    return enotov
	  end

	  # Склоняем в зависимости от остатка деления на 10
	  ostatok = number % 10

	  if ostatok == 1
	    return enot
	  end

	  if (2..4).include?(ostatok)
	    return enota
	  end

	  if ostatok > 4 || ostatok == 0
	    return enotov
	  end
	end
end
