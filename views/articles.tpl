% rebase('layout.tpl', title='Полезные статьи', year=year)

<style>
    /* Общие стили для страницы статей */
    .container {
        color: #000000;
    }
    
    /* Стили для статей */
    .article-item {
        color: #000000;
        background-color: #ffffff;
        border: 1px solid #dddddd;
        margin-bottom: 20px;
        padding: 20px;
        border-radius: 5px;
    }
    .article-title {
        color: #000000;
        font-weight: bold;
        font-size: 1.3em;
        margin-bottom: 5px;
    }
    .article-meta {
        color: #000000;
        opacity: 0.8;
        font-size: 0.9em;
        margin-bottom: 10px;
    }
    .article-content {
        color: #000000;
        margin-top: 15px;
        line-height: 1.6;
    }
    
    /* Стили для формы */
    .article-form {
        background-color: #f8f9fa;
        padding: 20px;
        border-radius: 5px;
        margin-bottom: 30px;
    }
    .form-label {
        font-weight: bold;
        color: #000000;
    }
</style>

<div class="container">
    <h1>Полезные статьи</h1>
    
    <!-- Форма добавления статьи -->
    <div class="article-form">
        <h3>Добавить новую статью</h3>
        <form method="POST" action="/articles">
            <div class="form-group">
                <label class="form-label">Название статьи:</label>
                <input type="text" name="title" class="form-control" value="{{title or ''}}" required>
            </div>
            
            <div class="form-group">
                <label class="form-label">Автор:</label>
                <input type="text" name="author" class="form-control" value="{{author or ''}}" required>
            </div>
            
            <div class="form-group">
                <label class="form-label">Содержание:</label>
                <textarea name="content" class="form-control" rows="6" required>{{content or ''}}</textarea>
            </div>
            
            <button type="submit" class="btn btn-primary">Опубликовать статью</button>
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

    <!-- Список статей -->
    <h2>Последние статьи</h2>
    % if not articles:
    <p>Пока нет статей. Будьте первым автором!</p>
    % else:
    % for article in articles:
    <div class="article-item">
        <div class="article-title">{{article.get('title', 'Без названия')}}</div>
        <div class="article-meta">
            Автор: {{article.get('author', 'Неизвестен')}} | 
            Дата: {{article.get('date', '')}}
        </div>
        <div class="article-content">
            {{!article.get('content', '')}}
        </div>
    </div>
    % end
    % end
</div>