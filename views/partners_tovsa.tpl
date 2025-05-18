% rebase('layout.tpl', title='Partner Companies - Tovstogan', year=year)

<link rel="stylesheet" href="/static/css/tovstogan.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<div class="container tovstogan-partners-container">
    <h1 class="tovstogan-partners-header">
        <i class="fas fa-handshake"></i> Partner Companies
    </h1>
    
    <!-- Partner form with Tovstogan styling -->
    <div class="tovstogan-partner-form">
        <h3 class="tovstogan-form-title">
            <i class="fas fa-plus-circle"></i> Add New Partner
        </h3>
        <form method="POST" action="/partners_tovsa" class="tovstogan-form">
            <div class="form-group">
                <label class="tovstogan-form-label">
                    <i class="fas fa-building"></i> Company Name:
                </label>
                <input type="text" name="company_name" class="form-control tovstogan-input" 
                       value="{{company_name or ''}}" required>
            </div>
            <div class="form-group">
                <label class="tovstogan-form-label">
                    <i class="fas fa-user-tie"></i> Contact Person:
                </label>
                <input type="text" name="contact_person" class="form-control tovstogan-input" 
                       value="{{contact_person or ''}}" required>
            </div>
            <div class="form-group">
                <label class="tovstogan-form-label">
                    <i class="fas fa-phone"></i> Phone:
                </label>
                <input type="tel" name="phone" class="form-control tovstogan-input" 
                       value="{{phone or ''}}" required>
            </div>
            <div class="form-group">
                <label class="tovstogan-form-label">
                    <i class="fas fa-envelope"></i> Email:
                </label>
                <input type="email" name="email" class="form-control tovstogan-input" 
                       value="{{email or ''}}" required>
            </div>
            <button type="submit" class="btn btn-info tovstogan-submit-btn">
                <i class="fas fa-save"></i> Add Partner
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

    <!-- Partners list with Tovstogan styling -->
    <h2 class="tovstogan-section-title">
        <i class="fas fa-list-ul"></i> Partners List
    </h2>
    % if not partners:
    <p class="tovstogan-empty-message">
        <i class="far fa-frown"></i> No partner data available
    </p>
    % else:
    % for partner in partners:
    <div class="tovstogan-partner-card">
        <div class="tovstogan-partner-header">
            <span class="tovstogan-partner-name">
                <i class="fas fa-building"></i> {{partner.get('company_name', '')}}
            </span>
        </div>
        <div class="tovstogan-partner-contact">
            <div><i class="fas fa-user-tie"></i> <strong>Contact:</strong> {{partner.get('contact_person', '')}}</div>
            <div><i class="fas fa-phone"></i> <strong>Phone:</strong> {{partner.get('phone', '')}}</div>
            <div><i class="fas fa-envelope"></i> <strong>Email:</strong> {{partner.get('email', '')}}</div>
        </div>
    </div>
    % end
    % end
</div>