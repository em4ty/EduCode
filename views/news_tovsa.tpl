% rebase('layout.tpl', title='Latest News - Tovstogan', year=year)

<link rel="stylesheet" href="/static/css/tovstogan.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<div class="container tovstogan-news-container">
    <h1 class="tovstogan-news-header">
        <i class="fas fa-bullhorn"></i> Latest News
    </h1>
    
    <!-- News submission form with Tovstogan styling -->
    <div class="tovstogan-news-form">
        <h3 class="tovstogan-form-title">
            <i class="fas fa-plus-circle"></i> Add News Item
        </h3>
        <form method="POST" action="/news_tovsa" class="tovstogan-form">
            <div class="form-group">
                <label class="tovstogan-form-label">
                    <i class="fas fa-heading"></i> Title:
                </label>
                <input type="text" name="title" class="form-control tovstogan-input" 
                       value="{{title or ''}}" required>
            </div>
            
            <div class="form-group">
                <label class="tovstogan-form-label">
                    <i class="fas fa-align-left"></i> Content:
                </label>
                <textarea name="content" class="form-control tovstogan-textarea" 
                          rows="5" required>{{content or ''}}</textarea>
            </div>
            
            <div class="form-group">
                <label class="tovstogan-form-label">
                    <i class="far fa-calendar-alt"></i> Publication Date:
                </label>
                <input type="date" name="news_date" class="form-control tovstogan-input" 
                       value="{{news_date or ''}}" required>
            </div>
            
            <button type="submit" class="btn btn-info tovstogan-submit-btn">
                <i class="fas fa-paper-plane"></i> Publish News
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

    <!-- News list with Tovstogan styling -->
    <h2 class="tovstogan-section-title">
        <i class="far fa-newspaper"></i> Recent News
    </h2>
    % if not news:
    <p class="tovstogan-empty-message">
        <i class="far fa-frown"></i> No news items yet
    </p>
    % else:
    % for item in news:
    <div class="tovstogan-news-card">
        <div class="tovstogan-news-header">
            <div class="tovstogan-news-title">
                <i class="fas fa-bookmark"></i> {{item.get('title', 'Untitled')}}
            </div>
            <div class="tovstogan-news-meta">
                <span><i class="far fa-clock"></i> Published: {{item.get('news_date', '')}}</span>
            </div>
        </div>
        <div class="tovstogan-news-content">
            {{!item.get('content', '')}}
        </div>
    </div>
    % end
    % end
</div>