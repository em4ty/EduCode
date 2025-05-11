% rebase('layout.tpl', title='Актуальные новинки', year=year)

<style>
    /* Общие стили */
    .container {
        color: #000000;
        padding: 20px;
    }
    
    /* Стили карточек новинок */
    .news-card {
        background-color: #ffffff;
        border: 1px solid #e0e0e0;
        border-radius: 8px;
        padding: 20px;
        margin-bottom: 20px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }
    .news-title {
        font-size: 1.4em;
        font-weight: bold;
        margin-bottom: 10px;
        color: #000000;
    }
    .news-meta {
        color: #666666;
        margin-bottom: 15px;
        font-size: 0.9em;
    }
    .news-content {
        line-height: 1.6;
        color: #000000;
    }
    
    /* Стили формы */
    .news-form {
        background-color: #f8f9fa;
        padding: 20px;
        border-radius: 8px;
        margin-bottom: 30px;
    }
    .form-label {
        font-weight: bold;
        color: #000000;
    }
    .form-control {
        margin-bottom: 15px;
    }
</style>

<div class="container">
    <h1>Актуальные новинки</h1>
    
    <!-- Форма добавления новинки -->
    <div class="news-form">
        <h3>Добавить новинку</h3>
        <form method="POST" action="/news">
            <div class="form-group">
                <label class="form-label">Заголовок:</label>
                <input type="text" name="title" class="form-control" 
                       value="{{title or ''}}" required>
            </div>
            
            <div class="form-group">
                <label class="form-label">Содержание:</label>
                <textarea name="content" class="form-control" rows="5" 
                          required>{{content or ''}}</textarea>
            </div>
            
            <div class="form-group">
                <label class="form-label">Дата публикации:</label>
                <input type="date" name="news_date" class="form-control" 
                       value="{{news_date or ''}}" required>
            </div>
            
            <button type="submit" class="btn btn-primary">Опубликовать</button>
        </form>
    </div>

    <!-- Вывод ошибок -->
    % if errors:
    <div class="alert alert-danger">
        <h4>Ошибки:</h4>
        <ul>
            % for error in errors:
            <li>{{error}}</li>
            % end
        </ul>
    </div>
    % end

    <!-- Список новинок -->
    <h2>Последние новинки</h2>
    % if not news:
    <p>Пока нет новинок</p>
    % else:
    % for item in news:
    <div class="news-card">
        <div class="news-title">{{item.get('title', 'Без названия')}}</div>
        <div class="news-meta">
            Опубликовано: {{item.get('news_date', '')}}
        </div>
        <div class="news-content">
            {{!item.get('content', '')}}
        </div>
    </div>
    % end
    % end
</div>