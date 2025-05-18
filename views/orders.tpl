% rebase('layout.tpl', title='Orders', year=year)

<link rel="stylesheet" href="/static/css/yumashkin.css">
<div class="container">
    <h1>Order Management</h1>
    
    <!-- Order creation form -->
    <div class="order-form">
        <h3>Create New Order</h3>
        <form method="POST" action="/orders">
            <div class="form-group">
                <label class="form-label">Order Number:</label>
                <input type="text" name="order_number" class="form-control {{'is-invalid' if 'Укажите номер заказа' in errors else ''}}" 
                       value="{{order_number or ''}}" required>
                % if 'Укажите номер заказа' in errors:
                <div class="invalid-feedback">Please provide an order number</div>
                % end
            </div>
            
            <div class="form-group">
                <label class="form-label">Customer Name:</label>
                <input type="text" name="client_name" class="form-control {{'is-invalid' if 'Укажите имя клиента' in errors else ''}}" 
                       value="{{client_name or ''}}" required>
                % if 'Укажите имя клиента' in errors:
                <div class="invalid-feedback">Please provide a customer name</div>
                % end
            </div>
            
            <div class="form-group">
                <label class="form-label">Customer Phone:</label>
                <input type="tel" name="phone" class="form-control {{'is-invalid' if 'Укажите телефон клиента' in errors else ''}}" 
                       value="{{phone or ''}}" 
                       placeholder="+79161234567 or 89161234567" required>
                % if 'Укажите телефон клиента' in errors:
                <div class="invalid-feedback">Please provide a valid Russian phone number (+79161234567 or 89161234567)</div>
                % end
            </div>
            
            <div class="form-group">
                <label class="form-label">Order Description:</label>
                <textarea name="description" class="form-control {{'is-invalid' if 'Укажите описание заказа' in errors else ''}}" 
                          rows="3" required>{{description or ''}}</textarea>
                % if 'Укажите описание заказа' in errors:
                <div class="invalid-feedback">Please provide an order description</div>
                % end
            </div>
            
            <button type="submit" class="btn btn-primary">Add Order</button>
        </form>
    </div>

    <!-- Error display -->
    % if errors:
    <div class="alert alert-danger mt-3">
        <h4>Errors:</h4>
        <ul>
            % for error in errors:
            <li>{{error}}</li>
            % end
        </ul>
    </div>
    % end

    <!-- Orders list -->
    <h2 class="mt-4">Recent Orders</h2>
    % if not orders:
    <p>No orders available</p>
    % else:
    <div class="orders-list">
        % for order in orders:
        <div class="order-card mb-3">
            <div class="order-header">
                <span class="order-number">Order #{{order.get('order_number', '')}}</span>
                <span class="order-date">{{order.get('order_date', '')}}</span>
            </div>
            <div class="order-client"><strong>Customer:</strong> {{order.get('client_name', '')}}</div>
            <div class="order-phone"><strong>Phone:</strong> {{order.get('phone', '')}}</div>
            <div class="order-description">
                {{order.get('description', '')}}
            </div>
        </div>
        % end
    </div>
    % end
</div>

<script>
document.querySelector('form').addEventListener('submit', function(e) {
    const phone = document.querySelector('input[name="phone"]').value;
    const phoneRegex = /^(\+7|8)\d{10}$/;
    const cleanedPhone = phone.replace(/[^\d+]/g, '');
    
    if (!phoneRegex.test(cleanedPhone)) {
        e.preventDefault();
        alert('Please enter a valid Russian phone number (+79161234567 or 89161234567)');
    }
});
</script>