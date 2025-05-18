% rebase('layout.tpl', title='Latest News', year=year)

<link rel="stylesheet" href="/static/css/yumashkin.css">

<div class="container">
    <h1>Latest News</h1>
    
    <!-- Form for adding news -->
    <div class="news-form">
        <h3>Add News</h3>
        <form method="POST" action="/news">
            <div class="form-group">
                <label class="form-label">Title:</label>
                <input type="text" name="title" class="form-control" 
                       value="{{title or ''}}" required>
            </div>
            
            <div class="form-group">
                <label class="form-label">Content:</label>
                <textarea name="content" class="form-control" rows="5" 
                          required>{{content or ''}}</textarea>
            </div>
            
            <div class="form-group">
                <label class="form-label">Publication Date:</label>
                <input type="date" name="news_date" class="form-control" 
                       value="{{news_date or ''}}" required>
            </div>
            
            <button type="submit" class="btn btn-primary">Publish</button>
        </form>
    </div>

    <!-- Error display -->
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

    <!-- News list -->
    <h2>Recent News</h2>
    % if not news:
    <p>No news yet</p>
    % else:
    % for item in news:
    <div class="news-card">
        <div class="news-title">{{item.get('title', 'Untitled')}}</div>
        <div class="news-meta">
            Published: {{item.get('news_date', '')}}
        </div>
        <div class="news-content">
            {{!item.get('content', '')}}
        </div>
    </div>
    % end
    % end
</div>