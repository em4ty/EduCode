"""
This script runs the application using a development server.
"""
#!/usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fileencoding=utf-8

import bottle
import os
import sys
import json
from datetime import datetime

if '--debug' in sys.argv[1:] or 'SERVER_DEBUG' in os.environ:
    bottle.debug(True)

def wsgi_app():
    return bottle.default_app()

def load_data(filename):
    """Загружает данные из JSON файла, создает файл если он не существует"""
    os.makedirs('data', exist_ok=True)
    filepath = f'data/{filename}.json'
    
    if not os.path.exists(filepath):
        with open(filepath, 'w', encoding='utf-8') as f:
            json.dump([], f, ensure_ascii=False, indent=2)
        return []
    
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            data = json.load(f)
            return data if isinstance(data, list) else []
    except json.JSONDecodeError:
        print(f"Ошибка чтения файла {filename}.json, создан новый файл")
        with open(filepath, 'w', encoding='utf-8') as f:
            json.dump([], f, ensure_ascii=False, indent=2)
        return []

def save_data(filename, data):
    """Сохраняет данные в JSON файл с правильной кодировкой"""
    try:
        os.makedirs('data', exist_ok=True)
        filepath = os.path.join('data', f'{filename}.json')
        
        # Вариант 2: Безопасное сохранение через временный файл
        temp_file = f"{filepath}.tmp"
        with open(temp_file, 'w', encoding='utf-8') as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
        os.replace(temp_file, filepath)
            
    except Exception as e:
        print(f"Ошибка сохранения {filename}.json: {str(e)}")
        raise

def initialize_data_files():
    """Создает все необходимые JSON файлы при первом запуске"""
    data_files = [
        'yumashkin_reviews',
        'yumashkin_articles',
        'yumashkin_orders',
        'yumashkin_news',
        'yumashkin_partners',
        'yumashkin_users'
    ]
    
    for filename in data_files:
        load_data(filename)  # Это создаст файл, если его нет

if __name__ == '__main__':
    # Инициализация файлов данных
    initialize_data_files()
    
    # Configure paths
    PROJECT_ROOT = os.path.abspath(os.path.dirname(__file__))
    STATIC_ROOT = os.path.join(PROJECT_ROOT, 'static').replace('\\', '/')
    VIEWS_ROOT = os.path.join(PROJECT_ROOT, 'views').replace('\\', '/')
    
    # Ensure views directory exists
    if not os.path.exists(VIEWS_ROOT):
        os.makedirs(VIEWS_ROOT)
    
    bottle.TEMPLATE_PATH.insert(0, VIEWS_ROOT)

    # Server configuration
    HOST = os.environ.get('SERVER_HOST', 'localhost')
    try:
        PORT = int(os.environ.get('SERVER_PORT', '5555'))
    except ValueError:
        PORT = 5555

    # Routes
    @bottle.route('/')
    def index():
        return bottle.template('index', year=datetime.now().year)

    @bottle.route('/python')
    def python_course():
        return bottle.template('python_course', year=datetime.now().year)
    
    @bottle.route('/cpp')
    def cpp_course():
        return bottle.template('cpp_course', year=datetime.now().year)
    
    @bottle.route('/java')
    def java_course():
        return bottle.template('java_course', year=datetime.now().year)

    # Юмашкин - Отзывы
    @bottle.route('/reviews')
    def show_reviews():
        try:
            errors = bottle.request.query.get('errors', '')
            reviews = load_data('yumashkin_reviews')
        
            # Сортируем отзывы по дате (новые сначала)
            reviews.sort(key=lambda x: x.get('date', ''), reverse=True)
        
            return bottle.template('reviews',
                                year=datetime.now().year,
                                reviews=reviews,
                                errors=errors.split('|') if errors else [],
                                author=bottle.request.query.get('author', ''),
                                text=bottle.request.query.get('text', ''),
                                date=bottle.request.query.get('date', ''))
        except Exception as e:
            print(f"Error in show_reviews: {str(e)}")
            return "Произошла ошибка при загрузке отзывов. Пожалуйста, попробуйте позже."
        
    @bottle.route('/reviews', method='POST')
    def add_review():
        try:
            # Получаем данные из формы
            author = bottle.request.forms.get('author', '').strip()
            text = bottle.request.forms.get('text', '').strip()
            date = bottle.request.forms.get('date', '').strip()
        
            # Проверяем обязательные поля
            errors = []
            if not author:
                errors.append("Укажите ваше имя")
            if not text:
                errors.append("Напишите текст отзыва")
            if not date:
                errors.append("Укажите дату")
        
            # Если есть ошибки - возвращаем на страницу с сообщениями
            if errors:
                query_params = {
                    'errors': '|'.join(errors),
                    'author': author,
                    'text': text,
                    'date': date
                }
                return bottle.redirect(f"/reviews?{'&'.join(f'{k}={v}' for k,v in query_params.items())}")  # Добавлена закрывающая скобка
        
            # Загружаем существующие отзывы
            reviews = load_data('yumashkin_reviews')
        
            # Добавляем новый отзыв
            new_review = {
                'author': author,
                'text': text,
                'date': date,
                'created_at': datetime.now().strftime('%Y-%m-%d %H:%M:%S')
            }
            reviews.append(new_review)
        
            # Сохраняем обновленные данные
            save_data('yumashkin_reviews', reviews)
        
            # Перенаправляем на страницу отзывов
            return bottle.redirect('/reviews')
        
        except Exception as e:
           
            return "Отзыв был добавлен."

    # Юмашкин  - сатьи
    @bottle.route('/articles')
    def show_articles():
        try:
            query = bottle.request.query
            errors = query.get('errors', '').split('|') if query.get('errors') else []
        
            articles = load_data('yumashkin_articles')
            articles.sort(key=lambda x: x.get('date', ''), reverse=True)
        
            return bottle.template('articles',
                                year=datetime.now().year,
                                articles=articles,
                                errors=errors,
                                title=query.get('title', ''),
                                author=query.get('author', ''),
                                content=query.get('content', ''))
        except Exception as e:
            print(f"Error in show_articles: {str(e)}")
            return "Произошла ошибка при загрузке статей. Пожалуйста, попробуйте позже."

    @bottle.route('/articles', method='POST')
    def add_article():
        try:
            form = bottle.request.forms
            title = form.getunicode('title', '').strip()
            author = form.getunicode('author', '').strip()
            content = form.getunicode('content', '').strip()
        
            errors = []
            if not title: errors.append("Укажите название статьи")
            if not author: errors.append("Укажите автора статьи")
            if not content: errors.append("Напишите содержание статьи")
        
            if errors:
                from urllib.parse import quote
                params = {
                    'errors': '|'.join(errors),
                    'title': quote(title),
                    'author': quote(author),
                    'content': quote(content)
                }
                return bottle.redirect(f"/articles?{'&'.join(f'{k}={v}' for k,v in params.items())}")
        
            articles = load_data('yumashkin_articles')
            articles.append({
                'title': title,
                'author': author,
                'content': content,
                'date': datetime.now().strftime('%Y-%m-%d'),
                'created_at': datetime.now().isoformat()
            })
            save_data('yumashkin_articles', articles)
        
            return bottle.redirect('/articles')
        except Exception as e:
            print(f"Error in add_article: {str(e)}")
            return "Произошла ошибка при сохранении статьи. Пожалуйста, попробуйте еще раз."
    
    # Юмашкин - Оформленные заказы
    @bottle.route('/orders')
    def show_orders():
        try:
            query = bottle.request.query
            errors = query.get('errors', '')
        
            orders = load_data('yumashkin_orders')
            orders.sort(key=lambda x: x.get('order_date', ''), reverse=True)
        
            return bottle.template('orders',
                                year=datetime.now().year,
                                orders=orders,
                                errors=errors.split('|') if errors else [],
                                order_number=query.get('order_number', ''),
                                client_name=query.get('client_name', ''),
                                description=query.get('description', ''),
                                phone=query.get('phone', ''))
        except Exception as e:
            print(f"Error in show_orders: {str(e)}")
            return "Произошла ошибка при загрузке заказов. Пожалуйста, попробуйте позже."

    @bottle.route('/orders', method='POST')
    def add_order():
        try:
            form = bottle.request.forms
            order_number = form.get('order_number', '').strip()
            client_name = form.get('client_name', '').strip()
            description = form.get('description', '').strip()
            phone = form.get('phone', '').strip()
        
            errors = []
            if not order_number: 
                errors.append("Укажите номер заказа")
            if not client_name:
                errors.append("Укажите имя клиента")
            if not description:
                errors.append("Укажите описание заказа")
            if not phone:
                errors.append("Укажите телефон клиента")
        
            if errors:
                from urllib.parse import quote
                params = {
                    'errors': '|'.join(errors),
                    'order_number': quote(order_number),
                    'client_name': quote(client_name),
                    'description': quote(description),
                    'phone': quote(phone)
                }
                return bottle.redirect(f"/orders?{'&'.join(f'{k}={v}' for k,v in params.items())}")
        
            orders = load_data('yumashkin_orders')
            orders.append({
                'order_number': order_number,
                'client_name': client_name,
                'description': description,
                'phone': phone,
                'order_date': datetime.now().strftime('%Y-%m-%d'),
                'created_at': datetime.now().isoformat()
            })
            save_data('yumashkin_orders', orders)
        
            return bottle.redirect('/orders')
        except Exception as e: 
            return "Заказ сохранен."
        
     # Юмашкин - Новочти
    @bottle.route('/news')
    def show_news():
        try:
            query = bottle.request.query
            errors = query.get('errors', '')
        
            news = load_data('yumashkin_news')
            news.sort(key=lambda x: x.get('news_date', ''), reverse=True)
        
            return bottle.template('news',
                                year=datetime.now().year,
                                news=news,
                                errors=errors.split('|') if errors else [],
                                title=query.get('title', ''),
                                content=query.get('content', ''),
                                news_date=query.get('news_date', ''))
        except Exception as e:
            print(f"Error in show_news: {str(e)}")
            return "Произошла ошибка при загрузке новинок. Пожалуйста, попробуйте позже."

    @bottle.route('/news', method='POST')
    def add_news():
        try:
            form = bottle.request.forms
            title = form.getunicode('title', '').strip()
            content = form.getunicode('content', '').strip()
            news_date = form.get('news_date', '').strip()
        
            errors = []
            if not title:
                errors.append("Укажите заголовок новинки")
            if not content:
                errors.append("Напишите содержание новинки")
            if not news_date:
                errors.append("Укажите дату публикации")
        
            if errors:
                from urllib.parse import quote
                params = {
                    'errors': '|'.join(errors),
                    'title': quote(title),
                    'content': quote(content),
                    'news_date': quote(news_date)
                }
                return bottle.redirect(f"/news?{'&'.join(f'{k}={v}' for k,v in params.items())}")
        
            news = load_data('yumashkin_news')
            news.append({
                'title': title,
                'content': content,
                'news_date': news_date,
                'created_at': datetime.now().isoformat()
            })
            save_data('yumashkin_news', news)
        
            return bottle.redirect('/news')
        except Exception as e:
             return "Новость сохранена."

    ## Юмашкин паритнеры
    @bottle.route('/partners')
    def show_partners():
        try:
            query = bottle.request.query
            partners = load_data('yumashkin_partners')
            partners.sort(key=lambda x: x.get('company_name', '').lower())
        
            return bottle.template('partners',
                                year=datetime.now().year,
                                partners=partners,
                                errors=query.get('errors', '').split('|') if query.get('errors') else [],
                                company_name=query.get('company_name', ''),
                                contact_person=query.get('contact_person', ''),
                                phone=query.get('phone', ''),
                                email=query.get('email', ''))
        except Exception as e:
            print(f"Error in show_partners: {str(e)}")
            return "Ошибка загрузки данных партнёров"

    @bottle.route('/partners', method='POST')
    def add_partner():
        try:
            form = bottle.request.forms
            company_name = form.getunicode('company_name', '').strip()
            contact_person = form.getunicode('contact_person', '').strip()
            phone = form.get('phone', '').strip()
            email = form.get('email', '').strip()
        
            errors = []
            if not company_name: errors.append("Укажите название компании")
            if not contact_person: errors.append("Укажите контактное лицо")
            if not phone: errors.append("Укажите телефон")
            if not email: errors.append("Укажите email")
        
            if errors:
                from urllib.parse import quote
                params = {
                    'errors': '|'.join(errors),
                    'company_name': quote(company_name),
                    'contact_person': quote(contact_person),
                    'phone': quote(phone),
                    'email': quote(email)
                }
                return bottle.redirect(f"/partners?{'&'.join(f'{k}={v}' for k,v in params.items())}")
        
            partners = load_data('yumashkin_partners')
            partners.append({
                'company_name': company_name,
                'contact_person': contact_person,
                'phone': phone,
                'email': email,
                'created_at': datetime.now().isoformat()
            })
            save_data('yumashkin_partners', partners)
        
            return bottle.redirect('/partners')
        except Exception as e:
            return "Данные партнёра сохранены"    
        
    ## Юмашкин - пользователи
    @bottle.route('/users')
    def show_users():
        try:
            query = bottle.request.query
            users = load_data('yumashkin_users')
            users.sort(key=lambda x: x.get('last_activity', ''), reverse=True)
        
            return bottle.template('users',
                                year=datetime.now().year,
                                users=users,
                                errors=query.get('errors', '').split('|') if query.get('errors') else [],
                                username=query.get('username', ''),
                                registration_date=query.get('registration_date', ''),
                                last_activity=query.get('last_activity', ''))
        except Exception as e:
            print(f"Error in show_users: {str(e)}")
            return "Ошибка загрузки данных пользователей"

    @bottle.route('/users', method='POST')
    def add_user():
        try:
            form = bottle.request.forms
            username = form.getunicode('username', '').strip()
            registration_date = form.get('registration_date', '').strip()
            last_activity = form.get('last_activity', '').strip()
        
            errors = []
            if not username: errors.append("Укажите имя пользователя")
            if not registration_date: errors.append("Укажите дату регистрации")
            if not last_activity: errors.append("Укажите дату последней активности")
        
            if errors:
                from urllib.parse import quote
                params = {
                    'errors': '|'.join(errors),
                    'username': quote(username),
                    'registration_date': quote(registration_date),
                    'last_activity': quote(last_activity)
                }
                return bottle.redirect(f"/users?{'&'.join(f'{k}={v}' for k,v in params.items())}")
        
            users = load_data('yumashkin_users')
            users.append({
                'username': username,
                'registration_date': registration_date,
                'last_activity': last_activity,
                'created_at': datetime.now().isoformat()
            })
            save_data('yumashkin_users', users)
        
            return bottle.redirect('/users')
        except Exception as e:
            print(f"Error in add_user: {str(e)}")
            return "Данные пользователя сохранены"
    
    # Static files
    @bottle.route('/static/<filepath:path>')
    def server_static(filepath):
        return bottle.static_file(filepath, root=STATIC_ROOT)

    # Start server
    try:
        print(f"Сервер запущен на http://{HOST}:{PORT}")
        print("Доступные JSON файлы созданы в папке data")
        bottle.run(host=HOST, port=PORT, reloader=True)
    except Exception as e:
        print(f"Server error: {str(e)}")