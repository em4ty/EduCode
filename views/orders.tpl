% rebase('layout.tpl', title='Заказы', year=year)

<style>
    /* Общие стили */
    .container {
        color: #000000;
        padding: 20px;
    }
    
    /* Стили для карточек заказов */
    .order-card {
        background-color: #ffffff;
        border: 1px solid #dddddd;
        border-radius: 5px;
        padding: 15px;
        margin-bottom: 15px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    .order-header {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
    }
    .order-number {
        font-weight: bold;
        font-size: 1.2em;
        color: #000000;
    }
    .order-date {
        color: #666666;
        font-size: 0.9em;
    }
    .order-client {
        margin-bottom: 5px;
    }
    .order-phone {
        margin-bottom: 10px;
    }
    .order-description {
        padding: 10px;
        background-color: #f9f9f9;
        border-radius: 3px;
    }
    
    /* Стили формы */
    .order-form {
        background-color: #f8f9fa;
        padding: 20px;
        border-radius: 5px;
        margin-bottom: 30px;
    }
    .form-label {
        font-weight: bold;
        color: #000000;
    }
</style>

<div class="container">
    <h1>Управление заказами</h1>
    
    <!-- Форма добавления заказа -->
    <div class="order-form">
        <h3>Добавить новый заказ</h3>
        <form method="POST" action="/orders">
            <div class="form-group">
                <label class="form-label">Номер заказа:</label>
                <input type="text" name="order_number" class="form-control" 
                       value="{{order_number or ''}}" required>
            </div>
            
            <div class="form-group">
                <label class="form-label">Имя клиента:</label>
                <input type="text" name="client_name" class="form-control" 
                       value="{{client_name or ''}}" required>
            </div>
            
            <div class="form-group">
                <label class="form-label">Телефон клиента:</label>
                <input type="tel" name="phone" class="form-control" 
                       value="{{phone or ''}}" required>
            </div>
            
            <div class="form-group">
                <label class="form-label">Описание заказа:</label>
                <textarea name="description" class="form-control" rows="3" 
                          required>{{description or ''}}</textarea>
            </div>
            
            <button type="submit" class="btn btn-primary">Добавить заказ</button>
        </form>
    </div>

    <!-- Вывод ошибок -->
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

    <!-- Список заказов -->
    <h2>Последние заказы</h2>
    % if not orders:
    <p>Нет доступных заказов</p>
    % else:
    % for order in orders:
    <div class="order-card">
        <div class="order-header">
            <span class="order-number">Заказ #{{order.get('order_number', '')}}</span>
            <span class="order-date">{{order.get('order_date', '')}}</span>
        </div>
        <div class="order-client"><strong>Клиент:</strong> {{order.get('client_name', '')}}</div>
        <div class="order-phone"><strong>Телефон:</strong> {{order.get('phone', '')}}</div>
        <div class="order-description">
            {{order.get('description', '')}}
        </div>
    </div>
    % end
    % end
</div>