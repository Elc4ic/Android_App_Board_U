part of 'values.dart';

class SC {
  static const String APP_TITLE = "Доска объявлений ДВФУ";
  static const String RUBLES = "₽";

  //headers
  static const String SEARCH_HINT = "Поиск...";

  //login
  static const String YANDEX_AUTH = "Войти через яндекс";

  static const String SEARCH_NOTHING = "Ничего не найдено";

  //login
  static const String LOGIN = "Войти";
  static const String USERNAME = "Логин";
  static const String PASSWORD = "Пароль";
  static const String PHONE_NUM = "Номер телефона";
  static const String SIGN_UP = "Регистрация";
  static const String SIGNING_UP = "Зарегистрироваться";

  //add ad
  static const String PUBLISH_AD = "Разместить";
  static const String TITLE = "Заголовок";
  static const String PRICE = "Цена";
  static const String DECSRIPTION = "Описание";
  static const String REQUARIED = "Заполните все необходимые поля";
  static const String VALID = "Введите подходящие данные";

  //comment
  static const String COMMENT = "Прокомментировать";
  static const String ADD_COMMENT = "Добавить комментарий";


  //navbar
  static const String MAIN_LABEL = "Главная";
  static const String FAVORITE_LABEL = "Избранные";
  static const String AD_LABEL = "Объявления";
  static const String CHATS_LABEL = "Чаты";
  static const String SETTINGS_LABEL = "Настройки";

  //edit ad
  static const String EDIT = "Изменить";
  static const String DELETE = "Удалить";
  static const String HIDE = "Скрыть";
  static const String CLOSE = "Закрыть";

  //error
  static const String REQUIRED_ERROR = "Это поле обязательно для заполнения";
  static const String PHONE_ERROR = "Введите телефонный номер";
  static const String MIN_LENGHT_8_ERROR = "Минимальная длина 8 символов";
  static const String NO_SPEC_SIMBOLS_ERROR = "Нет 2 специальных символов (#!@\$%^&*-)";

  //patterns
  static const String PHONE_PATTERN = r'(^[\+7]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)';
  static const String PASSWORD_PATTERN = r'(?=.*?[#!@$%^&*-])';

  //ads
  static const String ACTIVE = "Активно";
  static const String UNACTIVE = "Не активно";


  //routes
  static const String MAIN_PAGE = "/home";
  static const String FAVORITE_PAGE = "/favorites";
  static const String AD_PAGE = "/my";
  static const String CHATS_PAGE = "/chats";
  static const String CHAT_PAGE = "/chat";
  static const String SETTINGS_PAGE = "/settings";
  static const String USER_PAGE = "/user";
  static const String ADD_PAGE = "/add";
  static const String CHANGE_PAGE = "/my/change";
  static const String LOGIN_PAGE = "/login";
  static const String SIGNUP_PAGE = "/signup";
  static const String COMMENT_PAGE = "/comments";
  static const String ADD_COMMENT_PAGE = "/addcomment";
}
