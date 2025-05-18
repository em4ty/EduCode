% rebase('layout.tpl', title='Active Users - Tovstogan', year=year)

<!-- Tovstogan Design System -->
<link rel="stylesheet" href="/static/css/tovstogan.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<div class="container tovstogan-users-container">
    <div class="tovstogan-page-header">
        <h1 class="tovstogan-page-title">
            <i class="fas fa-users"></i> Active Users
        </h1>
        <div class="tovstogan-header-divider"></div>
    </div>
    
    <!-- User Form with Tovstogan Styling -->
    <div class="tovstogan-user-form">
        <div class="tovstogan-form-header">
            <h3><i class="fas fa-user-plus"></i> Add New User</h3>
        </div>
        <form method="POST" action="/users_tovsa" class="tovstogan-form">
            <div class="form-group">
                <label class="tovstogan-form-label">
                    <i class="fas fa-user-circle"></i> Username:
                </label>
                <input type="text" name="username" class="form-control tovstogan-input" 
                       value="{{username or ''}}" required>
            </div>
            <div class="form-group">
                <label class="tovstogan-form-label">
                    <i class="fas fa-calendar-plus"></i> Registration Date:
                </label>
                <input type="date" name="registration_date" class="form-control tovstogan-input" 
                       value="{{registration_date or ''}}" required>
            </div>
            <div class="form-group">
                <label class="tovstogan-form-label">
                    <i class="fas fa-calendar-check"></i> Last Activity:
                </label>
                <input type="date" name="last_activity" class="form-control tovstogan-input" 
                       value="{{last_activity or ''}}" required>
            </div>
            <button type="submit" class="btn tovstogan-btn-primary">
                <i class="fas fa-user-check"></i> Add User
            </button>
        </form>
    </div>

    <!-- Error Display with Tovstogan Styling -->
    % if errors:
    <div class="tovstogan-alert tovstogan-alert-danger">
        <div class="tovstogan-alert-icon">
            <i class="fas fa-exclamation-circle"></i>
        </div>
        <div class="tovstogan-alert-content">
            <h4>Validation Errors</h4>
            <ul class="tovstogan-error-list">
                % for error in errors:
                <li><i class="fas fa-angle-right"></i> {{error}}</li>
                % end
            </ul>
        </div>
    </div>
    % end

    <!-- Users List Section -->
    <div class="tovstogan-users-section">
        <div class="tovstogan-section-header">
            <h2>
                <i class="fas fa-list-ol"></i> Users List
            </h2>
        </div>
        
        % if not users:
        <div class="tovstogan-empty-state">
            <i class="fas fa-user-slash"></i>
            <p>No user data available</p>
        </div>
        % else:
        <div class="tovstogan-users-list">
            % for user in users:
            <div class="tovstogan-user-card">
                <div class="tovstogan-user-badge">
                    <i class="fas fa-user-tie"></i>
                </div>
                <div class="tovstogan-user-info">
                    <div class="tovstogan-username">
                        {{user.get('username', '')}}
                    </div>
                    <div class="tovstogan-user-meta">
                        <span class="tovstogan-meta-item">
                            <i class="fas fa-calendar-plus"></i> {{user.get('registration_date', '')}}
                        </span>
                        <span class="tovstogan-meta-item">
                            <i class="fas fa-calendar-check"></i> {{user.get('last_activity', '')}}
                        </span>
                    </div>
                </div>
                <div class="tovstogan-user-status">
                    <span class="tovstogan-status-active">
                        <i class="fas fa-circle"></i> Active
                    </span>
                </div>
            </div>
            % end
        </div>
        % end
    </div>
</div>