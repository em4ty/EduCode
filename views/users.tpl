% rebase('layout.tpl', title='Active Users', year=year)

<link rel="stylesheet" href="/static/css/yumashkin.css">
<div class="container">
    <h1>Active Users</h1>
    
    <!-- Форма добавления пользователя -->
    <div class="user-form">
        <h3>Add User</h3>
        <form method="POST" action="/users">
            <div class="form-group">
                <label>Username:</label>
                <input type="text" name="username" class="form-control" value="{{username or ''}}" required>
            </div>
            <div class="form-group">
                <label>Registration Date:</label>
                <input type="date" name="registration_date" class="form-control" value="{{registration_date or ''}}" required>
            </div>
            <div class="form-group">
                <label>Last Activity Date:</label>
                <input type="date" name="last_activity" class="form-control" value="{{last_activity or ''}}" required>
            </div>
            <button type="submit" class="btn btn-primary">Add</button>
        </form>
    </div>

    <!-- Блок отображения ошибок -->
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

    <!-- Список пользователей -->
    <h2>Users List</h2>
    % if not users:
    <p>No user data available</p>
    % else:
    % for user in users:
    <div class="user-card">
        <div class="user-info">
            <div class="user-name">{{user.get('username', '')}}</div>
            <div class="user-dates">
                Registered: {{user.get('registration_date', '')}} | 
                Last activity: {{user.get('last_activity', '')}}
            </div>
        </div>
    </div>
    % end
    % end
</div>