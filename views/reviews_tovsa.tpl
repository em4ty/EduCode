% rebase('layout.tpl', title='Course Reviews - Tovstogan', year=year)

<link rel="stylesheet" href="/static/css/tovstogan.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<div class="container tovstogan-container">
    <h1 class="tovstogan-page-title">
        <i class="fas fa-comment-dots"></i> Course Reviews
    </h1>
    
    <!-- Review Form with Tovstogan Styling -->
    <div class="tovstogan-form-container">
        <h3 class="tovstogan-form-title">
            <i class="fas fa-edit"></i> Share Your Experience
        </h3>
        <form method="POST" action="/reviews_tovsa" class="tovstogan-form">
            <div class="form-group">
                <label class="tovstogan-form-label">
                    <i class="fas fa-user"></i> Your Name:
                </label>
                <input type="text" name="author" class="form-control tovstogan-form-input" 
                       value="{{author or ''}}" required>
            </div>
            
            <div class="form-group">
                <label class="tovstogan-form-label">
                    <i class="fas fa-pencil-alt"></i> Your Review:
                </label>
                <textarea name="text" class="form-control tovstogan-form-textarea" 
                          rows="4" required>{{text or ''}}</textarea>
            </div>
            
            <div class="form-group">
                <label class="tovstogan-form-label">
                    <i class="far fa-calendar-alt"></i> Date:
                </label>
                <input type="date" name="date" class="form-control tovstogan-form-input" 
                       value="{{date or ''}}" required>
            </div>
            
            <button type="submit" class="btn btn-info tovstogan-btn">
                <i class="fas fa-paper-plane"></i> Submit Review
            </button>
        </form>
    </div>

    <!-- Error Display with Tovstogan Styling -->
    % if errors:
    <div class="alert alert-warning tovstogan-alert">
        <h4><i class="fas fa-exclamation-circle"></i> Issues Found:</h4>
        <ul class="tovstogan-error-list">
            % for error in errors:
            <li><i class="fas fa-chevron-right"></i> {{error}}</li>
            % end
        </ul>
    </div>
    % end

    <!-- Reviews List with Tovstogan Styling -->
    <h2 class="tovstogan-section-title">
        <i class="fas fa-list-ol"></i> Recent Feedback
    </h2>
    % if not reviews:
    <p class="tovstogan-no-items">
        <i class="far fa-comment-dots"></i> No reviews yet. Be the first to share!
    </p>
    % else:
    % for review in reviews:
    <div class="tovstogan-card">
        <div class="tovstogan-card-header">
            <div class="tovstogan-card-title">
                <i class="fas fa-user-circle"></i> {{review.get('author', 'Anonymous')}}
            </div>
            <div class="tovstogan-card-meta">
                <i class="far fa-clock"></i> {{review.get('date', '')}}
            </div>
        </div>
        <div class="tovstogan-card-content">
            <i class="fas fa-quote-left"></i> {{review.get('text', '')}} <i class="fas fa-quote-right"></i>
        </div>
    </div>
    % end
    % end
</div>