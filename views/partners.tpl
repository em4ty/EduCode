% rebase('layout.tpl', title='Партнёрские компании', year=year)

<style>
    .container {
        color: #000000;
        padding: 20px;
    }
    .partner-card {
        background-color: #ffffff;
        border: 1px solid #e0e0e0;
        border-radius: 8px;
        padding: 20px;
        margin-bottom: 20px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    .partner-header {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
    }
    .partner-name {
        font-weight: bold;
        font-size: 1.3em;
    }
    .partner-contact {
        margin: 10px 0;
    }
    .partner-form {
        background-color: #f8f9fa;
        padding: 20px;
        border-radius: 8px;
        margin-bottom: 30px;
    }
</style>

<div class="container">
    <h1>Партнёрские компании</h1>
    
    <div class="partner-form">
        <h3>Добавить партнёра</h3>
        <form method="POST" action="/partners">
            <div class="form-group">
                <label>Название компании:</label>
                <input type="text" name="company_name" class="form-control" value="{{company_name or ''}}" required>
            </div>
            <div class="form-group">
                <label>Контактное лицо:</label>
                <input type="text" name="contact_person" class="form-control" value="{{contact_person or ''}}" required>
            </div>
            <div class="form-group">
                <label>Телефон:</label>
                <input type="tel" name="phone" class="form-control" value="{{phone or ''}}" required>
            </div>
            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email" class="form-control" value="{{email or ''}}" required>
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

    <h2>Список партнёров</h2>
    % if not partners:
    <p>Нет данных о партнёрах</p>
    % else:
    % for partner in partners:
    <div class="partner-card">
        <div class="partner-header">
            <span class="partner-name">{{partner.get('company_name', '')}}</span>
        </div>
        <div class="partner-contact">
            <strong>Контакт:</strong> {{partner.get('contact_person', '')}}<br>
            <strong>Телефон:</strong> {{partner.get('phone', '')}}<br>
            <strong>Email:</strong> {{partner.get('email', '')}}
        </div>
    </div>
    % end
    % end
</div>