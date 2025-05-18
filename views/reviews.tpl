% rebase('layout.tpl', title='Reviews', year=year)

<link rel="stylesheet" href="/static/css/yumashkin.css">

<div class="container yumashkin-container">
    <h1 class="yumashkin-page-title">Course Reviews</h1>
    
    <!--Отзывы заполнение -->
    <div class="yumashkin-form-container">
        <h3 class="yumashkin-form-title">Add Review</h3>
        <form method="POST" action="/reviews">
            <div class="form-group">
                <label class="yumashkin-form-label">Your Name:</label>
                <input type="text" name="author" class="form-control yumashkin-form-input" 
                       value="{{author or ''}}" required>
            </div>
            
            <div class="form-group">
                <label class="yumashkin-form-label">Review Text:</label>
                <textarea name="text" class="form-control yumashkin-form-textarea" 
                          rows="4" required>{{text or ''}}</textarea>
            </div>
            
            <div class="form-group">
                <label class="yumashkin-form-label">Date:</label>
                <input type="date" name="date" class="form-control yumashkin-form-input" 
                       value="{{date or ''}}" required>
            </div>
            
            <button type="submit" class="btn btn-primary yumashkin-btn">Submit Review</button>
        </form>
    </div>

    <!-- Ошибка дисплея -->
    % if errors:
    <div class="alert alert-danger yumashkin-alert">
        <h4>Errors:</h4>
        <ul>
            % for error in errors:
            <li>{{error}}</li>
            % end
        </ul>
    </div>
    % end

    <!-- Отзыв лист -->
    <h2 class="yumashkin-section-title">Recent Reviews</h2>
    % if not reviews:
    <p class="yumashkin-no-items">No reviews yet. Be the first!</p>
    % else:
    % for review in reviews:
    <div class="yumashkin-card">
        <div class="yumashkin-card-header">
            <div class="yumashkin-card-title">{{review.get('author', 'Anonymous')}}</div>
            <div class="yumashkin-card-meta">{{review.get('date', '')}}</div>
        </div>
        <div class="yumashkin-card-content">
            {{review.get('text', '')}}
        </div>
    </div>
    % end
    % end
</div>