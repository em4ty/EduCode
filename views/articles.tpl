% rebase('layout.tpl', title='Useful Articles', year=year)

<link rel="stylesheet" href="/static/css/yumashkin.css">

<div class="container">
    <h1>Useful Articles</h1>
    
    <!-- Форма для добавления новой статьи -->
    <div class="article-form">
        <h3>Add New Article</h3>
        <form method="POST" action="/articles">
            <div class="form-group">
                <label class="form-label">Article Title:</label>
                <input type="text" name="title" class="form-control" value="{{title or ''}}" required>
            </div>
            
            <div class="form-group">
                <label class="form-label">Author:</label>
                <input type="text" name="author" class="form-control" value="{{author or ''}}" required>
            </div>
            
            <div class="form-group">
                <label class="form-label">Content:</label>
                <textarea name="content" class="form-control" rows="6" required>{{content or ''}}</textarea>
            </div>
            
            <button type="submit" class="btn btn-primary">Publish Article</button>
        </form>
    </div>

    <!-- Блок для отображения ошибок валидации -->
    % if errors:
    <div class="alert alert-danger">
        <h4>Errors:</h4>
        <ul>
            % for error in errors:
            <li>{{error}}</li>
            % end
        </ul>
    </div>
    % end

    <!-- Секция со списком существующих статей -->
    <h2>Recent Articles</h2>
    % if not articles:
    <p>No articles yet. Be the first author!</p>
    % else:
    % for article in articles:
    <div class="article-item">
        <div class="article-title">{{article.get('title', 'Untitled')}}</div>
        <div class="article-meta">
            Author: {{article.get('author', 'Unknown')}} | 
            Date: {{article.get('date', '')}}
        </div>
        <div class="article-content">
            {{!article.get('content', '')}}
        </div>
    </div>
    % end
    % end
</div>