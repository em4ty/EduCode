% rebase('layout.tpl', title='Useful Articles - Tovstogan', year=year)

<link rel="stylesheet" href="/static/css/tovstogan.css">

<div class="container tovstogan-container">
    <h1 class="tovstogan-header">Useful Articles</h1>
    
    <!-- Article submission form with Tovstogan styling -->
    <div class="tovstogan-article-form">
        <h3 class="tovstogan-form-title">
            <i class="fas fa-plus-circle"></i> Add New Article
        </h3>
        <form method="POST" action="/articles_tovsa" class="tovstogan-form">
            <div class="form-group">
                <label class="tovstogan-form-label">Article Title:</label>
                <input type="text" name="title" class="form-control tovstogan-input" 
                       value="{{title or ''}}" required>
            </div>
            
            <div class="form-group">
                <label class="tovstogan-form-label">Author:</label>
                <input type="text" name="author" class="form-control tovstogan-input" 
                       value="{{author or ''}}" required>
            </div>
            
            <div class="form-group">
                <label class="tovstogan-form-label">Content:</label>
                <textarea name="content" class="form-control tovstogan-textarea" 
                          rows="6" required>{{content or ''}}</textarea>
            </div>
            
            <button type="submit" class="btn btn-info tovstogan-submit-btn">
                <i class="fas fa-paper-plane"></i> Publish Article
            </button>
        </form>
    </div>

    <!-- Error display with Tovstogan styling -->
    % if errors:
    <div class="alert alert-warning tovstogan-alert">
        <h4><i class="fas fa-exclamation-triangle"></i> Errors:</h4>
        <ul class="tovstogan-error-list">
            % for error in errors:
            <li>{{error}}</li>
            % end
        </ul>
    </div>
    % end

    <!-- Articles list with Tovstogan styling -->
    <h2 class="tovstogan-section-title">
        <i class="fas fa-newspaper"></i> Recent Articles
    </h2>
    % if not articles:
    <p class="tovstogan-empty-message">No articles yet. Be the first author!</p>
    % else:
    % for article in articles:
    <div class="tovstogan-article-card">
        <div class="tovstogan-article-header">
            <div class="tovstogan-article-title">{{article.get('title', 'Untitled')}}</div>
            <div class="tovstogan-article-meta">
                <span><i class="fas fa-user"></i> {{article.get('author', 'Unknown')}}</span> | 
                <span><i class="far fa-calendar-alt"></i> {{article.get('date', '')}}</span>
            </div>
        </div>
        <div class="tovstogan-article-content">
            {{!article.get('content', '')}}
        </div>
    </div>
    % end
    % end
</div>

<!-- Font Awesome for icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">