% rebase('layout.tpl', title='Активные пользователи', year=year)

<style>
    .container {
        color: #000000;
        padding: 20px;
    }
    .user-card {
        background-color: #ffffff;
        border: 1px solid #e0e0e0;
        border-radius: 8px;
        padding: 15px;
        margin-bottom: 15px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .user-info {
        flex-grow: 1;
    }
    .user-name {
        font-weight: bold;
        font-size: 1.2em;
    }
    .user-dates {
        font-size: 0.9em;
        color: #666;
    }
    .user-form {
        background-color: #f8f9fa;
        padding: 20px;
        border-radius: 8px;
        margin-bottom: 30px;
    }
</style>

<div class="container">
    <h1>Активные пользователи</h1>
    
    <div class="user-form">
        <h3>Добавить пользователя</h3>
        <form method="POST" action="/users">
            <div class="form-group">
                <label>Имя пользователя:</label>
                <input type="text" name="username" class="form-control" value="{{username or ''}}" required>
            </div>
            <div class="form-group">
                <label>Дата регистрации:</label>
                <input type="date" name="registration_date" class="form-control" value="{{registration_date or ''}}" required>
            </div>
            <div class="form-group">
                <label>Дата последней активности:</label>
                <input type="date" name="last_activity" class="form-control" value="{{last_activity or ''}}" required>
            </div>
            <button type="submit" class="btn btn-primary">Добавить</button>
        </form>
    </div>

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

    <h2>Список пользователей</h2>
    % if not users:
    <p>Нет данных о пользователях</p>
    % else:
    % for user in users:
    <div class="user-card">
        <div class="user-info">
            <div class="user-name">{{user.get('username', '')}}</div>
            <div class="user-dates">
                Зарегистрирован: {{user.get('registration_date', '')}} | 
                Последняя активность: {{user.get('last_activity', '')}}
            </div>
        </div>
    </div>
    % end
    % end
</div>